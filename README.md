# Student Result Management App

This is a SwiftUI-based iOS application for managing student records and exam results. It allows schools, educators, or private tutors to easily input student data, manage exam scores, and filter results based on class, division, and more.

---

## Features

- Google and Email authentication using Firebase
- Add new students via the Student Entry Page
- Add, update, and view exam results
- Filter students based on class, division, or other attributes
- Secure logout functionality
- Clean SwiftUI-based UI and MVVM architecture

---

## Screens (Main Sections)

- **Login Screen**: Sign in with Google or Email
- **Home Screen**: Navigate to add students or view results
- **Student Entry Page**: Add new student details
- **Exam Result Page**: Input and view exam scores
- **Filtered Results**: Display results based on class, division, etc.
- **Profile/Settings**: Logout and view account details

---

## Project Structure

- **Models**: Contains Swift structs like `Student`, `Exam`, `Result`
- **Views**: SwiftUI views like `StudentEntryView`, `LoginView`, `ResultsView`
- **ViewModels**: Handles business logic and data binding
- **FirebaseManager**: Handles Firebase authentication and Firestore queries
- **Utilities**: Helper files like `FilterManager`, `Validation`

---

## Getting Started

### Prerequisites

- Xcode 15 or higher
- iOS 16.0+ deployment target
- A configured Firebase project (iOS app setup complete)
- Enable Firebase Auth (Google and Email/Password)
- Enable Firestore Database
