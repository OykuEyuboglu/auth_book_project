📚 Auth Book Project

Auth Book Project is a full-stack cross-platform application that allows users to register, log in, and manage book purchases. The backend is built with **ASP.NET Core Web API** and uses **JWT-based authentication**, while the frontend is a **Flutter** app that communicates with the API to provide a smooth user experience.

---

🌟 Features

🔐 **User Authentication**  
- Register & log in using email and password  
- Secure authentication via JWT tokens

📚 **Book Management**  
- View all available books  
- Purchase books and view your personal library  
- Filter purchased and unpurchased books

📦 **Token Storage**  
- Access token saved locally using `SharedPreferences`

📈 **Real-Time Interaction**  
- Instant UI update after book purchase  
- Error handling and loading indicators included

---

🚀 Tech Stack

🎯 Frontend  
- Flutter  
- Dart  
- SharedPreferences (local token storage)  
- HTTP package for API communication  

🛠 Backend  
- ASP.NET Core Web API  
- Entity Framework Core  
- JWT Authentication  
- SQL Server  

🗄 Database  
- Microsoft SQL Server  
- Code-first with EF Core

---

🛠️ Getting Started

### 🔧 Backend Setup

1. Navigate to the backend folder:  
   `cd backend`

2. Create and configure your `appsettings.json` for SQL Server and JWT settings

3. Run the project:  
   `dotnet run`

### 📱 Frontend Setup

1. Navigate to the frontend folder:  

2. Get dependencies:  
   `flutter pub get`

3. Run the Flutter app on Chrome:  
   `flutter run -d chrome`
