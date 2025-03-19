# SIGNCONNECT: A MOBILE-BASED REAL TIME AMERICAN SIGN LANGUAGE TRANSLATION SYSTEM

## Overview

The **American Sign Language (ASL) Recognition App** is a mobile application developed using Flutter that facilitates real-time translation between ASL gestures and text. This app aims to bridge the communication gap between the deaf and hearing communities by providing seamless ASL-to-text and text-to-ASL conversions.

## Features

- **Real-Time ASL-to-Text Translation**: Utilizes the device's camera to recognize ASL gestures and convert them into corresponding text.
- **Text-to-ASL Conversion**: Translates input text into ASL gestures, aiding non-ASL users in learning and communicating.
- **User-Friendly Interface**: Designed with an intuitive UI for easy navigation and interaction.
- **Offline Functionality**: Performs translations without requiring an active internet connection.

## Technologies Used

- **Flutter**: Cross-platform framework for building the application's user interface.
- **TensorFlow Lite**: Facilitates on-device machine learning for gesture recognition.
- **OpenCV**: Handles image processing tasks for ASL gesture detection.
- **Dart**: Programming language used in Flutter for application development.

## How It Works

1. **ASL-to-Text Translation**:

   - The app accesses the device's camera to capture live video feed.
   - Processes each frame using OpenCV to detect and isolate hand gestures.
   - TensorFlow Lite interprets the gestures and translates them into corresponding text, displayed in real-time.

2. **Text-to-ASL Conversion**:

   - Users input text into the app.
   - The app translates the text into ASL gestures, providing visual representations or animations to guide users.

## Installation

### Prerequisites

- Ensure Flutter is installed on your system. [Flutter Installation Guide](https://flutter.dev/docs/get-started/install)
- Compatible with Android and iOS devices.

### Steps

1. **Clone the Repository**:
   ```bash
   git clone https://github.com/logeshkannan9550/American-Sign-Language-Flutter-App.git
   ```
2. **Navigate to the Project Directory**:
   ```bash
   cd American-Sign-Language-Flutter-App/Frontend/asl_project_1
   ```
3. **Install Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the Application**:
   ```bash
   flutter run
   ```

## Applications

- **Educational Tool**: Assists in learning and practicing ASL.
- **Communication Aid**: Facilitates interaction between ASL users and non-ASL users.
- **Accessibility Enhancement**: Promotes inclusivity by providing translation services.

## Contributors

Developed by **Logesh Kannan** and contributors. Contributions are welcome; please refer to the [contributing guidelines](https://github.com/logeshkannan9550/American-Sign-Language-Flutter-App/blob/main/CONTRIBUTING.md).

## License

This project is licensed under the **MIT License**. See the [LICENSE](https://github.com/logeshkannan9550/American-Sign-Language-Flutter-App/blob/main/LICENSE) file for details.

## Acknowledgements

- Inspired by the need to bridge communication gaps between ASL users and the broader community.
- Utilizes open-source technologies and libraries to achieve functionality.

For more details, visit the [GitHub Repository](https://github.com/logeshkannan9550/American-Sign-Language-Flutter-App).

