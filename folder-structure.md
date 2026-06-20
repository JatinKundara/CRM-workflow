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
