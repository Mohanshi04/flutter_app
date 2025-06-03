# Flutter User Management App

## Overview

This Flutter application demonstrates user management with the **BLoC pattern**, **API integration**, and clean architecture principles. It interacts with the [DummyJSON API](https://dummyjson.com/docs) to fetch and manage users, their posts, and todos.

This project was developed as part of an internship task with the following goals:

## Objective

Build a Flutter app with user management using BLoC pattern, API integration, and clean code practices.

## Features

### 1. API Integration

- Fetches user data from [DummyJSON Users API](https://dummyjson.com/users)
- Implements pagination using `limit` and `skip` query parameters
- Real-time search functionality by user name
- Infinite scrolling for user list
- Fetches posts and todos for selected users:
  - [User Posts](https://dummyjson.com/posts/user/{userId})
  - [User Todos](https://dummyjson.com/todos/user/{userId})

### 2. State Management with BLoC

- Utilizes `flutter_bloc` for efficient state management
- Handles all loading, success, and error states
- Separate events for:
  - Fetching users
  - Searching users
  - Pagination
- Manages nested asynchronous calls for posts and todos

### 3. User Interface

- **User List Screen:** Displays user avatar, name, and email
- **Search Bar:** Real-time filtering of user list
- **User Detail Screen:** Displays full user info, posts, and todos
- **Create Post Screen:** Add new posts locally (title + body)
- **Loading Indicators:** For all asynchronous API calls
- **Error Messages:** Shown where appropriate during failures

### 4. Code Quality

- Clean and modular codebase
- Follows best practices for Dart and Flutter development
- Structured folder hierarchy for maintainability
- Handles edge cases and possible errors gracefully

### 5. Bonus Features (Optional)

- Pull-to-refresh functionality
- Offline caching with local storage
- Light/Dark theme switching (if implemented)

---

## Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/your-username/flutter-user-management-app.git
   cd flutter-user-management-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

---

## Architecture Explanation

The app uses the **BLoC (Business Logic Component)** pattern to separate business logic from UI, ensuring a clear separation of concerns.

- `blocs/` — Contains BLoC classes, events, and states
- `models/` — Data models mapped from the API responses
- `services/` — Handles all API interactions
- `screens/` — UI screens for different functionalities
- `widgets/` — Reusable custom widgets
- `utils/` — Helper functions and constants

---

## Video Demonstration

[https://drive.google.com/file/d/1BHl_WXFyJj7zDg-ukwsF6Qt414hrZZLO/view?usp=drive_link]

---

## Resources

- [DummyJSON API Docs](https://dummyjson.com/docs)
- [Flutter BLoC Documentation](https://bloclibrary.dev)

---
