# Cash-in-Out

A simple **cash ledger** app for small businesses.  
This repo contains both the **Flutter Frontend** and **PHP (XAMPP) Backend**.

Here you go 🚀 — this is the **ready-to-paste text** for your `README.md` file.
Just copy this whole block into `README.md` at the root of your repo.

---

```markdown
# Cash-in-Out

A simple **cash ledger** app for small businesses.  
This repo contains both the **Flutter Frontend** and **PHP (XAMPP) Backend**.

```

Cash-in-out/
├─ cash-in-out/            # Flutter app (Android/iOS/Web/Desktop)
└─ cash-in-out-backend/    # PHP backend (XAMPP + MySQL)

````

---

## ✨ Features

- Add customers and record **You Gave / You Got** transactions  
- Customer profile & reports (running balance)  
- Edit/Update transactions  
- Simple phone-based login (starter)  
- REST-style PHP endpoints for the app  
- Works locally on XAMPP

---

## 🛠 Tech Stack

- **Frontend:** Flutter (Dart)  
- **Backend:** PHP 8+, MySQL (MariaDB), XAMPP/Apache  
- **Tools:** Postman (API testing)

---

## 🚀 Quick Start

### 1) Backend (XAMPP)

1. **Install XAMPP** and start **Apache** & **MySQL**.
2. Ensure the backend is located at:  
   `C:\xampp\htdocs\cash-in-out-backend`
3. Create a MySQL database (example): `cashinout`
4. Create `cash-in-out-backend/db.php` (not committed) with your creds:

   ```php
   <?php
   $host = "localhost";
   $user = "root";
   $pass = "";           // XAMPP default is empty
   $db   = "cashinout";  // your database name

   $mysqli = new mysqli($host, $user, $pass, $db);
   if ($mysqli->connect_error) {
       http_response_code(500);
       die("Database connection failed: " . $mysqli->connect_error);
   }
   ?>
````

5. Visit the backend test endpoint:
   [http://localhost/cash-in-out-backend/test\_connection.php](http://localhost/cash-in-out-backend/test_connection.php)

---

### 2) Frontend (Flutter)

1. Install **Flutter SDK** and run:

   ```bash
   flutter doctor
   ```
2. Open the app folder:

   ```
   C:\xampp\htdocs\cash-in-out
   ```
3. Get packages & run:

   ```bash
   flutter pub get
   flutter run
   ```
4. The app expects backend base URL (default):

   ```
   http://localhost/cash-in-out-backend/
   ```

   > On Android emulator/device, use your PC IP instead of `localhost`.

---

## 🔗 API Endpoints (Summary)

Base URL (local): `http://localhost/cash-in-out-backend/`

| Endpoint                        | Method | Purpose                       |
| ------------------------------- | ------ | ----------------------------- |
| `login.php`                     | POST   | Log in                        |
| `fetch_profile.php`             | POST   | Get user profile              |
| `update_profile.php`            | POST   | Update user profile           |
| `add_customer_contact.php`      | POST   | Add customer                  |
| `get_customer.php`              | GET    | List customers                |
| `get_customer_details.php`      | GET    | Single customer details       |
| `update_customer_profile.php`   | POST   | Update customer profile       |
| `add_transaction.php`           | POST   | Add entry (plus/minus)        |
| `update_transaction.php`        | POST   | Edit an existing entry        |
| `get_transactions.php`          | GET    | List all transactions         |
| `get_customer_transactions.php` | GET    | Transactions for one customer |
| `get_user_id_by_phone.php`      | GET    | Resolve user by phone         |
| `test_connection.php`           | GET    | Quick server/DB connectivity  |

---

## 🧭 Folder Structure

```
cash-in-out/ (Flutter)
├─ lib/
│  ├─ screens/        # UI pages
│  ├─ models/         # data models
│  └─ utils/          # constants, helpers
├─ android/ ios/ web/ windows/ macos/ linux/
└─ pubspec.yaml

cash-in-out-backend/ (PHP)
├─ *.php              # API endpoints
├─ upload/            # uploaded images (ignored by git)
└─ db.php             # local DB config (ignored by git)
```

---

## 🧪 Local Testing Checklist

* `http://localhost/cash-in-out-backend/test_connection.php` works
* Add a customer via API → appears in app
* Add plus/minus transactions → running balance updates
* Frontend base URL matches backend

---

## 🐛 Troubleshooting

* **White screen in Flutter:**
  `flutter clean && flutter pub get`
* **Backend 404:**
  Path should be `C:\xampp\htdocs\cash-in-out-backend`
* **DB errors (table missing):**
  Ensure schema/tables exist (`transactions`, `customers`, etc.)
* **Android can’t reach localhost:**
  Use your PC’s LAN IP (e.g., `http://192.168.1.5/cash-in-out-backend/`)

---

## 🔒 Git Hygiene

This repo ignores:

* `db.php`, `.env`, `*.log`, `uploads/`
* IDE/OS files (`.vscode`, `.idea`, `.DS_Store`, `Thumbs.db`)
* Flutter build artifacts (`build/`, `.dart_tool/`)

---
