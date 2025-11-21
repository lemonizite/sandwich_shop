# Sandwich Shop Flutter App

A modern, user-friendly Flutter application for browsing, customizing, and ordering delicious sandwiches. Designed for both Android and iOS, this app streamlines the sandwich ordering experience with an intuitive interface and robust features.

## Features

- Browse a menu of sandwiches with images and descriptions
- Customize sandwiches with a variety of ingredients and extras
- Add items to a cart and manage your order
- Place orders and view order history
- Responsive design for mobile and tablet
- Smooth navigation and engaging UI

---

## Installation and Setup

### Prerequisites

- **Operating System:** Windows, macOS, or Linux
- **Flutter SDK:** [Install Flutter](https://flutter.dev/docs/get-started/install)
- **Dart SDK:** Included with Flutter
- **Android Studio/Xcode:** For emulator/simulator or device deployment
- **Git:** For cloning the repository

### Clone the Repository

```bash
git clone https://github.com/yourusername/sandwich_shop.git
cd sandwich_shop
```

### Install Dependencies

```bash
flutter pub get
```

### Run the App

- **Android/iOS Emulator:**  
    Start your emulator/simulator, then run:
    ```bash
    flutter run
    ```
- **Physical Device:**  
    Connect your device and run:
    ```bash
    flutter run
    ```

---

## Usage

1. **Browse Menu:**  
     Launch the app to view the sandwich menu.
2. **Customize Order:**  
     Select a sandwich to customize ingredients and extras.
3. **Add to Cart:**  
     Add your customized sandwich to the cart.
4. **Checkout:**  
     Review your cart and place your order.
5. **Order History:**  
     View your previous orders from the profile or history section.

### Running Tests

```bash
flutter test
```

### Screenshots

<!-- Replace with your own screenshots -->
![Menu Screen](screenshots/menu.png)
![Customization Screen](screenshots/customize.png)
![Cart Screen](screenshots/cart.png)

---

## Project Structure & Technologies

```
sandwich_shop/
├── lib/
│   ├── main.dart           # App entry point
│   ├── models/             # Data models (Sandwich, Order, etc.)
│   ├── screens/            # UI screens (Menu, Cart, History, etc.)
│   ├── widgets/            # Reusable UI components
│   └── services/           # Business logic, data handling
├── test/                   # Unit and widget tests
├── pubspec.yaml            # Dependencies and assets
```

**Key Packages:**
- `provider` or `bloc` for state management
- `http` for API calls (if applicable)
- `flutter_test` for testing

**Development Tools:**  
Flutter DevTools, Android Studio, VS Code

---

## Known Issues & Future Improvements

- [ ] Add user authentication
- [ ] Integrate payment gateway
- [ ] Improve accessibility
- [ ] Add localization support

**Contributions:**  
Pull requests are welcome! Please open an issue first to discuss changes.

---

## Contact

**Author:** [Lem Wilton]  
**Email:** up2276395@myport.ac.uk  
**GitHub:** [lemonizite](https://github.com/lemonizite)

---

*Feel free to reach out for questions, suggestions, or collaboration!*