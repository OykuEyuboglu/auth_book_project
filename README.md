# 📚 Auth Book Project

<div align="center">

![Book App](https://cdn-icons-png.flaticon.com/512/29/29302.png)

*A full-stack cross-platform book purchasing application built with ASP.NET Core Web API and Flutter.*

[![ASP.NET](https://img.shields.io/badge/ASP.NET%20Core-512BD4?style=for-the-badge&logo=.net&logoColor=white)]()
[![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)]()
[![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)]()
[![SQL Server](https://img.shields.io/badge/SQL%20Server-CC2927?style=for-the-badge&logo=microsoft-sql-server&logoColor=white)]()
[![JWT](https://img.shields.io/badge/JWT-000000?style=for-the-badge&logo=jsonwebtokens&logoColor=white)]()

</div>

---

# 🌟 Project Overview

Auth Book Project is a **full-stack cross-platform application** that allows users to register, log in, and purchase books.

The system consists of:

- **ASP.NET Core Web API backend**
- **Flutter frontend application**
- **SQL Server database**
- **JWT-based authentication system**

Users can browse available books, purchase them, and manage their personal book library through a modern user interface.

---

# 🚀 Features

## 🔐 User Authentication
- Register and login using email and password
- Secure authentication using **JWT tokens**
- Token-based authorization for protected endpoints

## 📚 Book Management
- View all available books
- Purchase books
- Display purchased books in a personal library
- Filter purchased and unpurchased books

## 📦 Token Storage
- Access token stored locally using **SharedPreferences**
- Automatically used in authenticated API requests

## ⚡ Real-Time Interaction
- Instant UI updates after book purchases
- Loading indicators for API calls
- Error handling for failed requests

---

# 📺 Demo Video

[![Watch the demo](https://img.youtube.com/vi/bR5VdX_FwwQ/0.jpg)](https://youtube.com/shorts/bR5VdX_FwwQ?feature=share)
> Click the thumbnail to watch the full demo.

---

# 📷 Screenshot

### ⚙️ Backend API (Swagger)

![Swagger API]
<img width="987" height="559" alt="auth1" src="https://github.com/user-attachments/assets/f5532e39-0c9e-48b3-a18f-8bc5cf95e7c9" />

---

# 🧱 Technology Stack

## 🎯 Frontend

```txt
Flutter
Dart
SharedPreferences (Token Storage)
HTTP Package
```

## 🛠 Backend

```txt
ASP.NET Core Web API
C#
Entity Framework Core
JWT Authentication
```

## 🗄 Database

```txt
Microsoft SQL Server
Code-first approach with Entity Framework Core
```

---

# 🧩 Project Architecture

```
AuthBookProject
│
├── backend
│     ├── Controllers
│     ├── DTOs
│     ├── Services
│     ├── Models
│     ├── Data
│     └── Program.cs
│
├── frontend
│     ├── screens
│     ├── services
│     ├── models
│     ├── widgets
│     └── main.dart
│
└── README.md
```

---

# 🔐 Authentication Flow

1️⃣ User registers or logs in  
2️⃣ Backend generates a **JWT token**  
3️⃣ Token is stored locally in **SharedPreferences**  
4️⃣ Flutter app sends the token in the request header  
5️⃣ Backend verifies the token and returns protected data  

Example request header:

```
Authorization: Bearer YOUR_JWT_TOKEN
```

---

# 🛠 Installation & Setup

## 📌 Prerequisites

Make sure the following tools are installed:

- .NET SDK
- Flutter SDK
- SQL Server
- Visual Studio / VS Code

---

# 🔧 Backend Setup

### 1️⃣ Navigate to the backend folder

```bash
cd backend
```

### 2️⃣ Configure `appsettings.json`

Add your **SQL Server connection string** and **JWT settings**.

Example:

```json
"ConnectionStrings": {
  "DefaultConnection": "Server=.;Database=AuthBookDb;Trusted_Connection=True;TrustServerCertificate=True;"
}
```

JWT example:

```json
"Jwt": {
  "Key": "your-secret-key",
  "Issuer": "AuthBookAPI",
  "Audience": "AuthBookUsers"
}
```

---

### 3️⃣ Run database migrations

```bash
dotnet ef database update
```

---

### 4️⃣ Run the API

```bash
dotnet run
```

API will run at:

```
https://localhost:5001
```

Swagger interface:

```
https://localhost:5001/swagger
```

---

# 📱 Frontend Setup

### 1️⃣ Navigate to the frontend folder

```bash
cd frontend
```

### 2️⃣ Install dependencies

```bash
flutter pub get
```

### 3️⃣ Run the application

```bash
flutter run -d chrome
```

You can also run it on an Android emulator or physical device.

---

# 🔗 API Communication Example

Example login request from Flutter:

```dart
http.post(
  Uri.parse("https://localhost:5001/api/auth/login"),
  headers: {
    "Content-Type": "application/json"
  },
  body: jsonEncode({
    "email": email,
    "password": password
  })
);
```

---

# 📚 Learning Goals

This project demonstrates:

- Full-stack application development
- Flutter and ASP.NET Core integration
- JWT authentication implementation
- RESTful API design
- Secure token storage
- Mobile and web application interaction

---

# 👩‍💻 Author

**Dila Öykü Eyüboğlu**  
