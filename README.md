# Neuvin CRM — Full Development Workflow (Core PHP, A to Z)

This guide walks through building the CRM using the folder structure you laid out — front controller, `app/` + `modules/` separation, mysqli prepared statements — as a clean progression from an empty folder to a working, secure, multi-module system. It also notes where your existing CRM code (built with the `$obj` database class) can be ported forward instead of rewritten.

---

## Phase 0 — Decide how much to migrate vs. rewrite

Before starting, be clear-eyed about scope: you already have a working CRM with quotations, proforma invoices, leads, HR forms, and vouchers built procedurally with `$obj->select_data()` / `insert_data()` / `update_data()` / `delete_data()`. This new structure changes three things:

1. **Document root moves** — `public/` becomes the only web-accessible folder; everything else (`app/`, `modules/`, `storage/`) sits outside it.
2. **Database access moves to prepared statements** — replacing the `$obj` class with a `Database.php` core class.
3. **Each module gets its own `controller.php` + `repository.php`** instead of one big file mixing SQL, logic, and HTML.

You do **not** need to rewrite business logic from scratch. The SQL you already wrote in `select_data()` calls can be lifted almost directly into `repository.php` methods — just parameterized. Treat this as a *restructuring* project, not a *rebuild*.

---

## Phase 1 — Skeleton and environment

**1. Create the folder structure** exactly as you specified, with `public/` as the only folder pointed at by your web server (Apache vhost `DocumentRoot` or hosting panel's "public_html" mapping).

**2. `.env` and `.env.example`**
```
DB_HOST=localhost
DB_NAME=neuvin_crm
DB_USER=neuvin_user
DB_PASS=
APP_URL=https://crm.neuvin.in
APP_ENV=production
APP_TIMEZONE=Asia/Kolkata
```
Load it with a tiny parser (no Composer package needed for a single `.env`):
```php
// app/config/database.php
function env_load($path) {
    foreach (file($path, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES) as $line) {
        if (str_starts_with(trim($line), '#')) continue;
        [$key, $val] = explode('=', $line, 2);
        putenv(trim($key) . '=' . trim($val));
    }
}
env_load(dirname(__DIR__, 2) . '/.env');

return [
    'host' => getenv('DB_HOST'),
    'name' => getenv('DB_NAME'),
    'user' => getenv('DB_USER'),
    'pass' => getenv('DB_PASS'),
];
```

**3. `.gitignore`**
```
.env
/storage/uploads/*
/storage/logs/*
/vendor/
!storage/uploads/.gitkeep
!storage/logs/.gitkeep
```

**4. `composer.json`** — even in a procedural app, use Composer for DOMPDF and PSR-4 autoloading of your `core/` classes:
```json
{
    "require": { "dompdf/dompdf": "^3.0" },
    "autoload": { "psr-4": { "App\\": "app/" } }
}
```
Run `composer install` once, then `require __DIR__.'/../vendor/autoload.php'` in your front controller.

---

## Phase 2 — Core framework classes

Build these once; every module depends on them.

**`app/core/Database.php`** — mysqli wrapper with prepared statements, replacing `$obj`:
```php
namespace App\Core;

class Database {
    private static ?\mysqli $conn = null;

    public static function connect(): \mysqli {
        if (self::$conn === null) {
            $cfg = require dirname(__DIR__) . '/config/database.php';
            self::$conn = new \mysqli($cfg['host'], $cfg['user'], $cfg['pass'], $cfg['name']);
            self::$conn->set_charset('utf8mb4');
        }
        return self::$conn;
    }

    public static function select(string $sql, array $params = [], string $types = ''): array {
        $stmt = self::prepare($sql, $params, $types);
        $result = $stmt->get_result();
        $rows = $result->fetch_all(MYSQLI_ASSOC);
        $stmt->close();
        return $rows;
    }

    public static function insert(string $sql, array $params = [], string $types = ''): int {
        $stmt = self::prepare($sql, $params, $types);
        $id = self::connect()->insert_id;
        $stmt->close();
        return $id;
    }

    public static function update(string $sql, array $params = [], string $types = ''): int {
        $stmt = self::prepare($sql, $params, $types);
        $affected = $stmt->affected_rows;
        $stmt->close();
        return $affected;
    }

    public static function delete(string $sql, array $params = [], string $types = ''): int {
        return self::update($sql, $params, $types); // same mechanics
    }

    private static function prepare(string $sql, array $params, string $types): \mysqli_stmt {
        $stmt = self::connect()->prepare($sql);
        if (!$stmt) throw new \RuntimeException(self::connect()->error);
        if ($params) {
            $types = $types ?: str_repeat('s', count($params));
            $stmt->bind_param($types, ...$params);
        }
        $stmt->execute();
        return $stmt;
    }
}
```
This gives every module the same four verbs you're used to (`select`, `insert`, `update`, `delete`), just parameterized and namespaced instead of `$obj->select_data()`.

**`app/core/Auth.php`** — session-based login/role check:
```php
namespace App\Core;

class Auth {
    public static function attempt(string $email, string $password): bool {
        $rows = Database::select("SELECT * FROM users WHERE email = ? AND active = 1", [$email], 's');
        if (!$rows || !password_verify($password, $rows[0]['password'])) return false;
        $_SESSION['user'] = $rows[0];
        session_regenerate_id(true);
        return true;
    }
    public static function check(): bool { return isset($_SESSION['user']); }
    public static function user(): ?array { return $_SESSION['user'] ?? null; }
    public static function role(): ?string { return $_SESSION['user']['role'] ?? null; }
    public static function logout(): void { session_unset(); session_destroy(); }
}
```

**`app/core/Csrf.php`**
```php
namespace App\Core;

class Csrf {
    public static function token(): string {
        if (empty($_SESSION['csrf'])) $_SESSION['csrf'] = bin2hex(random_bytes(32));
        return $_SESSION['csrf'];
    }
    public static function verify(?string $token): bool {
        return $token !== null && hash_equals($_SESSION['csrf'] ?? '', $token);
    }
}
```
Every form gets `<input type="hidden" name="csrf" value="<?= Csrf::token() ?>">`; every POST controller checks `Csrf::verify($_POST['csrf'] ?? null)` before touching the database.

**`app/core/Validator.php`, `Flash.php`, `Logger.php`** — straightforward: `Validator` returns an array of error messages for a rules array (`required`, `email`, `numeric`, `max:255`); `Flash::set('success', 'Quotation saved')` / `Flash::get()` for one-time session messages; `Logger::error()` appends to `storage/logs/error.log` instead of echoing to the browser (critical since `display_errors` should be **off** in production).

**`app/core/Router.php`** — optional but recommended given you already fought `.htaccess` rewrite rules on Entrixa. A single front controller sidesteps that entirely:
```php
// public/.htaccess
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteCond %{REQUEST_FILENAME} !-d
RewriteRule ^ index.php [QSA,L]
```
```php
// app/core/Router.php
namespace App\Core;

class Router {
    private static array $routes = [];
    public static function get(string $path, callable $handler) { self::$routes['GET'][$path] = $handler; }
    public static function post(string $path, callable $handler) { self::$routes['POST'][$path] = $handler; }
    public static function dispatch(): void {
        $uri = strtok($_SERVER['REQUEST_URI'], '?');
        $handler = self::$routes[$_SERVER['REQUEST_METHOD']][$uri] ?? null;
        if ($handler) { $handler(); return; }
        http_response_code(404);
        require dirname(__DIR__) . '/views/errors/404.php';
    }
}
```
Routes are registered in `public/index.php`, one line per module — this is where clean URLs like `/quotations/edit/104` get mapped, solving the same class of problem you were debugging on Entrixa, but centrally instead of per-page.

---

## Phase 3 — Middleware

```php
// app/middleware/RequireAuth.php
if (!\App\Core\Auth::check()) {
    header('Location: /login');
    exit;
}
```
```php
// app/middleware/RequireRole.php
function require_role(string ...$roles) {
    if (!in_array(\App\Core\Auth::role(), $roles, true)) {
        http_response_code(403);
        require dirname(__DIR__) . '/views/errors/403.php';
        exit;
    }
}
```
Every module `controller.php` starts with:
```php
require APP . '/middleware/RequireAuth.php';
require_role('Admin', 'Accounts'); // module-specific
```

---

## Phase 4 — Layouts and shared views

Port your existing Bootstrap dark theme + Tabler Icons markup directly:
- `app/views/layouts/header.php` — `<head>`, CSS includes, `data-bs-theme="dark"`
- `app/views/layouts/sidebar.php` — nav grouped by module (Sales, Accounts, HR, Trading, Support)
- `app/views/layouts/footer.php` — JS includes, closing tags
- `app/views/partials/flash-messages.php` — reads `Flash::get()` and renders Bootstrap alerts
- `app/views/partials/delete-modal.php` — your reusable confirm-delete modal, parameterized by `data-id` and `data-url`

Each module view does:
```php
require APP . '/views/layouts/header.php';
require APP . '/views/layouts/sidebar.php';
?>
<!-- module content -->
<?php require APP . '/views/layouts/footer.php'; ?>
```

---

## Phase 5 — Build one module end-to-end (template for all others)

Use **customers** as the reference implementation since every other module follows the same shape.

**`modules/customers/repository.php`**
```php
namespace Modules\Customers;
use App\Core\Database;

class CustomerRepository {
    public function all(): array {
        return Database::select("SELECT * FROM customers ORDER BY createdAt DESC");
    }
    public function find(int $id): ?array {
        $rows = Database::select("SELECT * FROM customers WHERE id = ?", [$id], 'i');
        return $rows[0] ?? null;
    }
    public function create(array $data): int {
        return Database::insert(
            "INSERT INTO customers (name, email, phone, gstNo, createdAt) VALUES (?, ?, ?, ?, NOW())",
            [$data['name'], $data['email'], $data['phone'], $data['gstNo']],
            'ssss'
        );
    }
    public function update(int $id, array $data): int {
        return Database::update(
            "UPDATE customers SET name=?, email=?, phone=?, gstNo=? WHERE id=?",
            [$data['name'], $data['email'], $data['phone'], $data['gstNo'], $id],
            'ssssi'
        );
    }
    public function delete(int $id): int {
        return Database::delete("DELETE FROM customers WHERE id = ?", [$id], 'i');
    }
}
```

**`modules/customers/controller.php`**
```php
require APP . '/middleware/RequireAuth.php';
use Modules\Customers\CustomerRepository;
use App\Core\{Csrf, Flash};

$repo = new CustomerRepository();
$action = $_GET['action'] ?? 'index';

switch ($action) {
    case 'store':
        if (!Csrf::verify($_POST['csrf'] ?? null)) { http_response_code(419); exit; }
        $repo->create($_POST);
        Flash::set('success', 'Customer added');
        header('Location: /customers'); exit;

    case 'update':
        if (!Csrf::verify($_POST['csrf'] ?? null)) { http_response_code(419); exit; }
        $repo->update((int)$_POST['id'], $_POST);
        Flash::set('success', 'Customer updated');
        header('Location: /customers'); exit;

    case 'delete':
        $repo->delete((int)$_POST['id']);
        Flash::set('success', 'Customer deleted');
        header('Location: /customers'); exit;

    default:
        $customers = $repo->all();
        require __DIR__ . '/views/index.php';
}
```

**`modules/customers/views/index.php`** — your existing data table markup, AJAX edit-modal pattern preserved: the "Edit" button fires a JS fetch to `/customers?action=edit&id=104` which returns the record as JSON, populates the same modal form used for "Add," and posts back to `?action=update`. This is the pattern you already use — it doesn't need to change, only the endpoint it calls.

Once this module is solid, **contacts, suppliers, products** are copy-paste-adapt of the same three files.

---

## Phase 6 — Higher-complexity modules

**Quotations** — same repository/controller pattern, plus:
- `quoteNo` generation stays server-side in the repository (`YYYYMM-NNNN`, monthly reset) — a single method `nextQuoteNumber()` that runs inside the same request as the insert, ideally in a transaction to avoid duplicate numbers under concurrent submits:
```php
public function nextQuoteNumber(): string {
    $prefix = date('Ym');
    $rows = Database::select(
        "SELECT quoteNo FROM quotations WHERE quoteNo LIKE ? ORDER BY id DESC LIMIT 1",
        [$prefix . '%'], 's'
    );
    $next = $rows ? ((int)substr($rows[0]['quoteNo'], -4)) + 1 : 1;
    return $prefix . '-' . str_pad($next, 4, '0', STR_PAD_LEFT);
}
```
- Line items save in the same POST as a loop of parameterized inserts against `quotationItems`, wrapped in a `mysqli` transaction (`begin_transaction()` / `commit()` / `rollback()`) so a failed line item doesn't leave an orphan header row.
- `quoteRef` stays a plain free-text column, unrelated to number generation, as you already have it.

**PDF generation** (`modules/quotations/pdf/quotation-pdf.php`, `app/helpers/pdf.php`):
```php
// app/helpers/pdf.php
function make_pdf(string $html, string $filename, bool $stream = true) {
    $dompdf = new \Dompdf\Dompdf();
    $dompdf->loadHtml($html);
    $dompdf->setPaper('A4', 'portrait');
    $dompdf->render();
    if ($stream) $dompdf->stream($filename, ['Attachment' => false]);
    else return $dompdf->output();
}
```
Every module needing a PDF (quotation, proforma invoice, sales bill, purchase order) builds its HTML in a view file, then calls this one shared helper — no duplicated DOMPDF setup.

**Proforma invoices** — independent tables (`proformaInvoices`, `proformaInvoiceItems`) as you've already designed, same repository/controller shape, with `billingAddress`/`shippingAddress` as JSON or separate columns depending on whether you need them queryable.

**Sales orders, purchase orders, vouchers (bank/cash/petty cash/credit-debit note/expense/journal)** — identical CRUD pattern, but each voucher type's `create()` method should also write the corresponding ledger/accounting entry as a second insert in the same transaction — this is where your CRM-architecture posting logic plugs in.

**Leads (telecaller, lead-generation, followups)** — repository methods map to your six-stage pipeline (`New → Contacted → Qualified → Quoted → Negotiation → Won/Lost`); a `changeStage()` method updates the stage and inserts a row into a `leadStageHistory` table for audit trail. `Followups` and `CallLogs` are child tables keyed on `leadId`, same pattern as quotation items.

**HR (organization, employees, attendance, leave, payslip)** — the 5-step employee wizard writes to `storage/uploads/employees/` via `app/helpers/upload.php`, which should always check real MIME type (`finfo_file()`), not just file extension, before accepting a document.

**Settings** — one `controller.php`/`repository.php` per concern (company, users, roles, email, tax, currency, backup) is fine as separate view files under one shared controller, since these are low-volume, admin-only screens.

**Dashboard** — `modules/dashboard/controller.php` calls a handful of lightweight aggregate queries (`COUNT`, `SUM`) from each module's repository rather than duplicating SQL, so stat cards stay in sync with each module's real logic.

---

## Phase 7 — Front controller

```php
// public/index.php
require __DIR__ . '/../vendor/autoload.php';
define('ROOT', dirname(__DIR__));
define('APP', ROOT . '/app');

session_start();
require APP . '/config/constants.php';

$uri = strtok($_SERVER['REQUEST_URI'], '?');
$segments = explode('/', trim($uri, '/'));
$module = $segments[0] ?: 'dashboard';

$controllerPath = ROOT . "/modules/$module/controller.php";
if (file_exists($controllerPath)) {
    require $controllerPath;
} else {
    http_response_code(404);
    require APP . '/views/errors/404.php';
}
```
This single file is why the `.htaccess` mod_rewrite headaches from Entrixa don't recur here — every URL segment maps predictably to a module folder instead of relying on rewrite conditions matching real files.

---

## Phase 8 — Security pass (do this before go-live, not after)

- Confirm `public/` is the *only* folder the web server can serve — test by requesting `/../app/config/database.php` directly; it should 404.
- Every `INSERT`/`UPDATE`/`DELETE` goes through `Database::` with bound parameters — no string-concatenated SQL anywhere.
- Every state-changing form checks `Csrf::verify()`.
- `display_errors = Off`, `log_errors = On` in production `php.ini`; all errors route through `Logger.php`.
- Passwords stored with `password_hash()`, checked with `password_verify()` — never plain text or reversible encryption.
- File uploads validated by real MIME type and size cap, stored outside `public/`, served only through a controller action that checks `Auth::check()` first.
- Role checks (`RequireRole`) on every module, not just hidden menu items — hiding a sidebar link is not access control.

---

## Phase 9 — Deployment

1. Point the hosting panel's document root at `neuvin-crm/public`, not `neuvin-crm/`.
2. Upload everything else (`app/`, `modules/`, `storage/`, `.env`) one level above the web root.
3. `composer install --no-dev --optimize-autoloader` on the server.
4. Set `storage/uploads` and `storage/logs` to writable (`755` or `775` depending on the hosting user/group setup).
5. Set up a cron job or manual routine for `storage/backups` (mysqldump on a schedule, or trigger from Settings > Backup).

---

## Suggested build order

1. Phase 1–4 (skeleton, core classes, layouts) — one-time foundation.
2. Customers module fully working — proves the pattern end-to-end.
3. Contacts, Suppliers, Products — fast, since they copy the pattern.
4. Quotations + PDF — highest business value, most complex single module.
5. Proforma invoices — reuses the PDF helper.
6. Leads pipeline (telecaller → lead-generation → followups) → feeds into Quotations.
7. Sales orders → Sales bills → Purchase orders → Purchase bills.
8. Vouchers (bank/cash/petty cash/credit-debit/expense/journal).
9. HR module (organization → employees → attendance → leave → payslip).
10. Support (complaints → visits → AMC).
11. Settings, then Dashboard last, once every module has real data to aggregate.

This order front-loads the modules that validate the architecture (customers, quotations) before you commit to replicating the pattern 30+ more times.









# CRM-workflow

CRM File :- https://fromsmash.com/crm-20-06-2026

Claude Response for CRM :- https://claude.ai/share/b454bae0-2762-4cc9-b886-301a30a18570

CRM Test File :- https://fromsmash.com/test-file-26-06-2026
