# 🔐 Flutter Local Authentication App

A complete local authentication system built using **Flutter** and **SQLite (sqflite)**.  
This project demonstrates user registration, login, and profile management using a local database.

---

## 🚀 Features

- ✅ User Signup (Full Name, Email, Username, Password)
- ✅ Username-based Login
- ✅ Profile Screen with user data
- ✅ SQLite Local Database Integration
- ✅ Unique Username Constraint
- ✅ Clean UI Structure
- ✅ Reusable Custom Widgets
- ✅ Safe Async Navigation Handling

---
## 📸 Screenshots

### Main Interface

<div style="display: flex; flex-wrap: wrap; gap: 30px;">
  <img src="assets/screenshots/auth.png" alt="Auth Screen" width="200" />
  <img src="assets/screenshots/login.png" alt="Login Screen" width="200" />
</div>

<div style="display: flex; flex-wrap: wrap; gap: 30px;">
  <img src="assets/screenshots/signup.png" alt="Register Screen" width="200" />
   <img src="assets/screenshots/profile.png" alt="Profile Screen" width="200" />
</div>
---
## 🏗️ Project Structure

lib/
│
├── component/
│ ├── button.dart
│ ├── colors.dart
│ └── textfield.dart
│
├── json/
│ └── users.dart
│
├── sqflite/
│ └── database_helper.dart
│
├── views/
│ ├── auth_screen.dart
│ ├── login_screen.dart
│ ├── signup_screen.dart
│ └── profile_screen.dart
│
└── main.dart

---


### Table Schema:

```sql
CREATE TABLE users (
   usrId INTEGER PRIMARY KEY AUTOINCREMENT,
   fullName TEXT,
   email TEXT,
   usrName TEXT UNIQUE,
   usrPassword TEXT
);
---
## 🛠️ Technologies Used

- **Flutter** - UI Framework
- **Dart** - Programming Language


## 📝 Configuration

Edit `pubspec.yaml` to customize dependencies and app configuration.

## 👨‍💻 Author

**Maryam**
- GitHub: [@MaryamAPPDev](https://github.com/MaryamAPPDev)

---
