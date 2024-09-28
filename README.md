# Image Processing App

## Introduction

This application is an image processing tool built with Flutter that allows users to select images from the gallery, capture images using the camera, and merge two images together. The app uses the Flutter Riverpod state management library and follows Clean Architecture principles to ensure maintainability and scalability. Users can also select images from asset files, providing a rich user experience for image manipulation.

## Code Architecture

The code is structured using Clean Architecture principles, which separate the application into distinct layers:

- **Presentation Layer**: This layer contains the UI components and handles user interactions. It uses `ConsumerWidget` from Riverpod to listen to state changes and update the UI accordingly.

- **Domain Layer**: This layer includes the business logic and state management using the `ImageNotifier` class. It holds the application state and defines methods to manipulate that state.

- **Data Layer**: This layer contains the repositories that interact with external data sources. For example, it includes methods for image picking, compression, and permission handling.

### Directory Structure

lib/
│
├── data/
│   ├── provider/
│   |   ├── camera_provider.dart
│   |   └── image_provider.dart
│   ├── repositories/
│   |   ├── camera_repositories.dart
│   |   └── image_repositories.dart
│   └── services/
│       ├── camera_service.dart
│       └── permission_service.dart
│
├── domain/
│   └── image_use_case.dart
│
├── presentation/
│   └── screens/
│       ├── capture_camera_image_screen.dart
│       ├── image_selection_screen.dart
│       └── merged_image_screen.dart
│
└── main.dart


## App Flow Chart

The flow of the application can be visualized as follows:

1. **User opens the app**.
2. **Check Permissions**:
   - If permissions are denied, show a message prompting the user to allow them.
3. **Image Selection**:
   - User can choose an image from the gallery.
   - User can capture an image using the camera.
   - User can select an image from predefined asset images.
4. **Image Merging**:
   - User initiates the merging of selected images.
   - App shows progress indicators during the merging process.
5. **Display Merged Image**:
   - Once merged, the new image is displayed to the user.

+---------------------+
|        User         |
+---------------------+
          |
          | Selects Image
          v
+--------------------------+
|     P1: Image Selection  |
+--------------------------+
| - Get Image from Gallery |
|                          |
| - Get Image from Camera  |
|                          |
+--------------------------+
          |
          |  Gallery Image Selected
          |  Camera Image Captured
          v
+--------------------------+
|       DS1: Image         |
|      Repository          |
+--------------------------+
          |
          | Contains: Gallery Image
          | Contains: Camera Image
          v
+--------------------------+
|      P2: Image Merging   |
+--------------------------+
| - Merges images from     |
|   DS1 (Gallery & Camera) |
| - Outputs merged image   |
+--------------------------+
          |
          | Merged Image Output
          v
+--------------------------+
|   DS2: Merged Image      |
|         Store            |
+--------------------------+
          |
          | Merged Image
          v
+--------------------------+
|    P3: Display Merged    |
|        Image             |
+--------------------------+
| - Displays merged image  |
+--------------------------+
          |
          | Merged Image Displayed
          v
+--------------------------+
|     P4: Handle Errors    |
+--------------------------+
| - Error handling during  |
|   image selection and    |
|   merging processes      |
+--------------------------+


## Installation

To install and run this application locally, follow these steps:

1. **Clone the repository**:
   ```bash
   git clone https://github.com/your-repo/image-processing-app.git
   cd image-processing-app

2. **Install dependencies**: 
   Make sure you have Flutter installed. Run the following command in the project directory:
   ```bash
   flutter pub get
   

3. **Run the application: Connect a device or start an emulator, then run:
   ```bash
   flutter run

## Features

- **Image Selection**: 
  - Choose images from the gallery or capture images using the camera, providing users with flexible options for sourcing images.

- **Asset Image Support**: 
  - Select images from predefined asset files through a convenient bottom sheet, enhancing the user experience with quick access to frequently used images.

- **Image Merging**: 
  - Effortlessly merge two selected images with a simple button click, making image processing straightforward and intuitive.

- **Permissions Handling**: 
  - Comprehensive handling of camera and storage permissions, ensuring users receive appropriate feedback and guidance if permissions are denied.

- **User-Friendly UI**: 
  - An intuitive layout with clear prompts and feedback for user actions, ensuring a smooth and enjoyable user experience.


## Future Enhancements

This application is designed to be easily extendable, allowing for future features such as:

- **Filters for Images**: 
  - Implement various filters to enhance and modify images, providing users with creative editing options.

- **Additional Image Processing Functionalities**: 
  - Explore and integrate more advanced image processing techniques, such as resizing, cropping, and effects.

- **Sharing Capabilities**: 
  - Enable users to share their edited images directly to social media platforms, enhancing connectivity and sharing.

- **User Settings**: 
  - Introduce user settings for customizing the app experience, allowing users to tailor the application to their preferences.


This application is designed to be easily extendable, allowing for future features such as filters, additional image processing functionalities, or sharing capabilities. Enjoy exploring and utilizing the image processing capabilities!
