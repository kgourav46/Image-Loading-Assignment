## Overview

This application is developed for iOS to efficiently load and display images in a scrollable grid using the Unsplash API. The app implements asynchronous image loading, caching mechanism for efficient retrieval, and effective error handling for network errors and image loading failures.

## Requirements

- Xcode (latest version)
- iOS device or simulator
- Internet connection

## Installation

1. Clone the repository from GitHub:

- git clone https://github.com/kgourav46/Image-Loading-Assignment.git

2. Open the project in Xcode:

- cd Image-Loading-Assignment
- open Image Loading Assignment.xcodeproj

3. Build and run the project in Xcode.

## Usage

- Upon launching the application, you'll see a scrollable grid of images loaded from the Unsplash API.
- Scroll through the grid to view more images.
- Images are loaded asynchronously and cached for efficient retrieval.
- If there's a network error, the app will gracefully handle it by providing informative error messages.

## Implementation Details

- The application is implemented in Swift.
- Asynchronous image loading is implemented without using any third-party libraries.
- Images retrieved from the Unsplash API are cached in memory and/or disk cache for efficient retrieval.
- Effective error handling is implemented to handle network errors.


