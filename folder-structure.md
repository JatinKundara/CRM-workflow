# Neuvin CRM

Internal CRM for Neuvin Advanced Technologies. PHP/MySQL, no framework —
structured for a single developer to extend safely as modules grow.

## Folder structure at a glance

```
app/        Framework-ish code: config, core classes, helpers, middleware, shared views.
            NOT web-accessible — sits outside public/.

modules/    One folder per feature (customers, quotations, accounts/bank-voucher, etc.)
            EACH module is web-accessible directly (e.g. /modules/customers/index.php),
            since public/index.php currently just redirects to /dashboard.php rather
            than routing every request itself.

storage/    Uploaded files, logs, DB backups. Writable at runtime, NOT web-accessible.

public/     The ONLY folder your web server's document root should point to.
            Contains the front controller, login/dashboard/logout, error pages,
            and static assets (css/js/img).

vendor/     Composer dependencies (DOMPDF etc.)
```

## First-time setup

1. **Point your web server's document root at `public/`** — not at the
   project root. This is the single most important step; everything else
   assumes `app/`, `modules/`, and `storage/` are _not_ reachable by URL.

2. **Copy `.env.example` to `.env`** and fill in real database credentials.
   `.env` is already in `.gitignore` — never commit it.

3. **Install dependencies:**

   ```
   composer install
   ```

4. **Create the `users` table** (referenced by `App\Core\Auth`) if it
   doesn't already exist in your schema:

   ```sql
   CREATE TABLE users (
     userId INT AUTO_INCREMENT PRIMARY KEY,
     name VARCHAR(255),
     email VARCHAR(255) UNIQUE,
     password VARCHAR(255),
     role VARCHAR(50),
     status ENUM('Active','Inactive') DEFAULT 'Active'
   );
   ```

   Passwords must be hashed with `password_hash($plain, PASSWORD_DEFAULT)`
   when you insert your first admin user — `Auth::attempt()` verifies
   against `password_verify()`.

5. **Visit `/login.php`**, log in, you'll land on `/dashboard.php`.

## What's fully built vs. scaffolded

- **`modules/customers/`** is a complete, working reference module:
  repository, list page, create/edit form, save handler, delete handler —
  all wired to auth, CSRF, validation, and flash messages.

- **Every other module folder** (`modules/quotations/`, `modules/accounts/bank-voucher/`,
  etc.) contains only a `README.md` describing the pattern to copy from
  `customers/`. The actual form fields, table columns, and PDF logic for
  those modules were already designed in earlier conversation — this
  scaffold defines _where_ that code belongs, not what it contains.

## Key architectural decisions (and why)

| Decision                                                    | Reason                                                                                                                                                                                      |
| ----------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `public/` is the only web root                              | Everything else (config, .env, module save/delete handlers) is physically unreachable by URL, even if `.htaccess` rules fail.                                                               |
| `app/core/Database.php` uses prepared statements everywhere | Closes the SQL-injection surface that existed when `$cond` values were concatenated as raw strings.                                                                                         |
| `app/core/Auth.php` + `app/middleware/RequireAuth.php`      | Every protected `index.php`/`form.php`/`save.php`/`delete.php` requires this at the top. Previously nothing enforced login at all.                                                          |
| `app/core/Csrf.php`                                         | Every `<form>` must include `Csrf::field()`; every POST handler must call `Csrf::verifyOrFail()` first.                                                                                     |
| `app/core/Logger.php`                                       | Replaces `die("Query failed: " . $error)` patterns — errors go to `storage/logs/app.log`, never to the browser.                                                                             |
| One `Repository` class per module                           | All SQL for a module lives in one place (e.g. `CustomerRepository.php`), not scattered across `index.php`/`form.php`/`save.php`.                                                            |
| PSR-4 autoloading via Composer                              | Class filenames must match class names exactly (`CustomerRepository.php` contains `class CustomerRepository`). No manual `require` needed for classes once `vendor/autoload.php` is loaded. |

## Known gaps to close before real production traffic

- `delete.php` handlers currently use GET + a confirmation modal, not
  POST + CSRF. Harden this before going live with financial records.
- HTTPS / secure cookies: `app/bootstrap.php` sets `'secure' => false`
  for the session cookie — flip to `true` once served over HTTPS.
- No automated tests exist yet. At minimum, test `Database::update()`
  and `Database::insert()` against a throwaway schema before trusting
  them with real customer/quotation data.
- `Router.php` is provided but unused by default — `public/index.php`
  currently just redirects to `/dashboard.php`. Decide whether to adopt
  clean URLs via the router or keep direct module-file access before
  this grows much further; mixing both patterns will get confusing.




neuvin-crm/                             # ← OUTSIDE the web server's document root
│
├── app/                                # All application code — NOT web-accessible
│   │
│   ├── config/
│   │   ├── database.php                # Reads from .env, builds connection
│   │   ├── app.php                     # App name, timezone, upload limits, paths
│   │   └── constants.php               # Document prefixes (QT-, SO-, INV- etc.)
│   │
│   ├── core/
│   │   ├── Database.php                # Your db class — rewritten to use mysqli prepared statements
│   │   ├── Auth.php                    # Session creation, login check, role check, logout
│   │   ├── Csrf.php                    # Token generation + verification
│   │   ├── Validator.php               # Reusable input validation (required, email, numeric, etc.)
│   │   ├── Flash.php                   # One-time session messages ("Quotation saved")
│   │   ├── Logger.php                  # Writes errors to storage/logs instead of echoing to browser
│   │   └── Router.php                  # Optional — maps clean URLs to module files (see note below)
│   │
│   ├── helpers/
│   │   ├── functions.php               # numberToWords(), formatCurrency(), badge_for_status()
│   │   ├── upload.php                  # Centralized file upload validation (MIME check, not just extension)
│   │   └── pdf.php                     # Shared DOMPDF setup used by every PDF generator
│   │
│   ├── middleware/
│   │   ├── RequireAuth.php             # Included at top of every protected page
│   │   └── RequireRole.php             # e.g. only Admin/Accounts can open Accounts module
│   │
│   └── views/
│       ├── layouts/
│       │   ├── header.php
│       │   ├── sidebar.php
│       │   └── footer.php
│       └── partials/
│           ├── delete-modal.php        # Your reusable confirm-delete modal markup
│           └── flash-messages.php
│
├── modules/                            # Business logic, NOT web-accessible directly
│   │
│   ├── customers/
│   │   ├── controller.php              # Handles list/create/edit/delete requests
│   │   ├── repository.php              # All SQL for this module lives here, using prepared statements
│   │   └── views/
│   │       ├── index.php
│   │       └── form.php
│   │
│   ├── contacts/        (same pattern)
│   ├── suppliers/       (same pattern)
│   ├── products/        (same pattern)
│   │
│   ├── quotations/
│   │   ├── controller.php
│   │   ├── repository.php
│   │   ├── pdf/
│   │   │   ├── quotation-pdf.php
│   │   │   └── proforma-invoice-pdf.php
│   │   └── views/
│   │       ├── index.php
│   │       └── form.php
│   │
│   ├── sales/
│   │   ├── sales-order/        { controller.php, repository.php, views/ }
│   │   ├── sales-order-approval/
│   │   ├── sales-bill/
│   │   ├── purchase-order/
│   │   ├── purchase-approval/
│   │   └── purchase-bill/
│   │
│   ├── leads/
│   │   ├── telecaller/
│   │   ├── lead-generation/
│   │   └── followups/
│   │
│   ├── support/
│   │   ├── complaints/
│   │   ├── complaint-visit/
│   │   └── amc/
│   │
│   ├── trading/
│   │   ├── material-inward/
│   │   └── material-outward/
│   │
│   ├── hr/
│   │   ├── organization/
│   │   ├── employees/
│   │   ├── attendance/
│   │   ├── leave-request/
│   │   ├── leave-approval/
│   │   ├── shift-time/
│   │   └── payslip/
│   │
│   ├── accounts/
│   │   ├── bank-voucher/
│   │   ├── cash-voucher/
│   │   ├── petty-cash/
│   │   ├── credit-note/
│   │   ├── debit-note/
│   │   ├── expense-voucher/
│   │   └── journal-voucher/
│   │
│   ├── office/
│   │   ├── task-management/
│   │   └── work-log/
│   │
│   ├── settings/
│   │   ├── controller.php
│   │   ├── repository.php
│   │   └── views/
│   │       ├── company.php
│   │       ├── users.php
│   │       ├── roles.php
│   │       ├── email.php
│   │       ├── tax.php
│   │       ├── currency.php
│   │       └── backup.php
│   │
│   └── dashboard/
│       ├── controller.php          # Aggregates stat cards across modules
│       └── views/
│           └── index.php
│
├── storage/                        # Writable at runtime, NOT web-accessible
│   ├── uploads/
│   │   ├── complaints/
│   │   ├── vouchers/
│   │   ├── invoices/
│   │   └── employees/              # Documents from the 5-step wizard
│   ├── logs/
│   │   ├── app.log
│   │   └── error.log
│   └── backups/                    # Database backup files from Settings > Backup
│
├── public/                         # ← THIS is the actual web server document root
│   ├── index.php                   # Single front controller — every request enters here
│   ├── assets/
│   │   ├── css/
│   │   ├── js/
│   │   └── img/
│   │       ├── neuvin2.jpg
│   │       └── signature.jpg
│   └── .htaccess                   # Forces all requests through index.php
│
├── vendor/                         # Composer packages (DOMPDF etc.) — not web-accessible
│
├── .env                            # DB credentials, app secrets — NEVER committed to git
├── .env.example                    # Template with blank values, safe to commit
├── .gitignore                      # .env, /storage/uploads, /storage/logs, /vendor
├── composer.json
└── README.md
