# Fay iOS App Challenge – Appointments App

## 📹 Demo Video
👉 [Watch the Demo](https://www.loom.com/share/4381d601f9e545cc8ff781db03b778b1?sid=5973b30f-09af-4ff7-904a-d2d03c3f110f)

## 🛠 Implementation Notes

- **Architecture**: MVVM with SwiftUI and async/await for networking.
- **Networking**: Used protocols to abstract the network service for better testability.
- **State Management**: Used a container App State to hold TabViewState to prevent extra view body updates/redraws when switching tabs.
- **Error Handling**: Graceful error handling for login and data-fetching failures.
- **UI Decisions**:
  - Created reusable custom components (buttons/textfields) for cleaner and more scalable code.
  - Decided to stick with the Fay theme and strike a balance between visual appeal and simplicity to ensure the login screen draws attention without feeling overdone or distracting.
- **Code Quality**: Modularized views, created unit tests for core logic (login/auth and network calls)

## ⏱ Time Breakdown

| Feature                        | Time Spent |
|-------------------------------|------------|
| 🔐 Login Screen               | 1 hour     |
| 📅 Appointments Screen        | 1.5 hours  |
| ✨ Nice-to-Haves              | 45 minutes |
| 🧪 Additional                 | 1.5 hours  |
