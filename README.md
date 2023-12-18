
# Flutter QR Scanner and In-App WebView App

This Flutter application is designed to scan QR codes and open the scanned URLs within an in-app web browser. 
It's a simple yet powerful tool for accessing web content directly from QR codes.

## Features

- **QR Code Scanning**: Scan any QR code quickly and easily.
- **In-App Web Browser**: Open and view URLs directly in the app without needing an external browser.
- **Back to Scanner**: Easily switch back to the scanner after viewing a web page.

## Getting Started

To get started with this project, follow these steps:

### Prerequisites

Ensure you have the following installed:
- Flutter SDK
- Android Studio or Visual Studio Code (with Flutter plugin)
- An Android or iOS device or emulator for testing

### Installation

1. **Clone the Repository**:
   \```sh
   git clone https://github.com/Dortgoth/module_ar.git
   \```
2. **Navigate to Project Directory**:
   \```sh
   cd your-project-name
   \```
3. **Get Packages**:
   \```sh
   flutter pub get
   \```
4. **Run the App**:
   \```sh
   flutter run
   \```

## Usage

Simply launch the app, grant the necessary permissions, and start scanning QR codes. The app will automatically open the URL contained in the QR code within its in-app browser. You can return to the QR scanner at any time by pressing the 'Back to Scanner' button.

## Permissions

The app requires the following permissions:
- **Camera**: To scan QR codes.
- **Internet**: For accessing and displaying web content.
- **Location (Optional)**: If your QR code or web content involves geolocation.

## Contributing

Contributions to the project are welcome! Feel free to fork the repository and submit pull requests.

## License

This project is licensed under the [MIT License](LICENSE).
