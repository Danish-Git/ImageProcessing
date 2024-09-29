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

  
   ## Flow Chart


   ```bash
          +--------------------------------+
          |               User             |
          +--------------------------------+
                           |
                           | Selects Image
                           v
        +-------------------------------------+
        |            Image Selection          |
        +-------------------------------------+
        | - Get Image from Gallery            |
        |                                     |
        | - Get Image from Camera             |
        |                                     |
        +-------------------------------------+
                           |
                           |  Gallery Image Selected
                           |  Camera Image Captured
                           v
        +-------------------------------------+
        |              DS1: Image             |
        |              Repository             |
        +-------------------------------------+
                           |
                           | Contains: Gallery Image
                           | Contains: Camera Image
                           v
        +-------------------------------------+
        |          P2: Image Merging          |
        +-------------------------------------+
        | - Merges images from                |
        |      DS1 (Gallery & Camera)         |
        | - Outputs merged image              |
        +-------------------------------------+
                           |
                           | Merged Image Output
                           v
        +-------------------------------------+
        |          DS2: Merged Image          |
        |                Store                |
        +-------------------------------------+
                          |
                          | Merged Image
                          v
        +-------------------------------------+
        |          P3: Display Merged         |
        |               Image                 |
        +-------------------------------------+
        | - Displays merged image             |
        +-------------------------------------+
                         |
                         | Merged Image Displayed
                         v
        +-------------------------------------+
        |          P4: Handle Errors          |
        +-------------------------------------+
        | - Error handling during             |
        |     image selection and             |
        |     merging processes               |
        +-------------------------------------+


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
 
## Screens

- #### *Image Selection Screen*
| Before Image Selection | After Image Selection |
|--|--|
| <img width="200" alt="Screenshot 2024-09-13 at 4 39 03 PM" src="https://github.com/user-attachments/assets/2a84d369-3e13-4b0c-b111-beaab2a9a538"> | <img width="200" alt="Screenshot 2024-09-13 at 4 39 03 PM" src="https://github.com/user-attachments/assets/bfed43d8-165b-4b35-8f49-0c9f77ceac86"> |

<img width="200" alt="Screenshot 2024-09-13 at 4 39 03 PM" src="https://github.com/user-attachments/assets/d400da85-2485-43c3-a361-97ea91538f88">



- #### *Assets Image Selection Screen*
| Select From Assets |
|--|
| <img width="200" alt="Screenshot 2024-09-13 at 4 39 03 PM" src="https://github.com/user-attachments/assets/da128053-1e53-42b5-aaa8-1371c24eed83"> |


- #### *Gallery Image Selection Section*
| Select From Gallery |
|--|
| <img width="200" alt="Screenshot 2024-09-13 at 4 39 03 PM" src="https://github.com/user-attachments/assets/bf0b523d-1a82-43f1-8024-840b3cc29d4b"> |


- #### *Capture Image Using Camera Screen*
| Capture Image |
|--|
| <img width="200" alt="Screenshot 2024-09-13 at 4 39 03 PM" src="https://github.com/user-attachments/assets/372d2fcb-82c4-449f-b38a-b3f595c5794a"> |


- #### *Image Processing Screen*
| Processing |
|--|
| <img width="200" alt="Screenshot 2024-09-13 at 4 39 03 PM" src="https://github.com/user-attachments/assets/b7ad8827-1d43-4a54-9e37-8439e62e5bc5"> |


- #### *Final Processed Image Representation Screen*
| Merged Image |
|--|
| <img width="200" alt="Screenshot 2024-09-13 at 4 39 03 PM" src="https://github.com/user-attachments/assets/e9d6114a-7cc1-4d2c-9dce-58a2bd7a914f"> |
