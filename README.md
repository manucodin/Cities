# Cities App

[![iOS Tests](https://github.com/manucodin/Cities/actions/workflows/ios-tests.yml/badge.svg)](https://github.com/manucodin/Cities/actions/workflows/ios-tests.yml) ![Xcode version](https://img.shields.io/badge/Xcode-16.4-blue?logo=Xcode&logoColor=white) ![iOS version](https://img.shields.io/badge/iOS-18.0-blue&logo=apple&logoColor=white) ![Swift version](https://img.shields.io/badge/Swift-6.0-orange?logo=Swift&logoColor=white) 

## ✨ Description
This repository contains Ualá iOS Mobile Challange. The goal of this assignment is to evaluate the problem solving skills, UX judgement and code quality. This proyect is an iOS application that allows users to explore, search, and save favorite cities. The app uses a modular architecture that separates the data, domain, and presentation layers, ensuring clean and maintainable code.

## 🌟 Main Features
- City listing.
- City details.
- Save and remove favorite cities.
- Interactive map to explore locations.

## 📋 Requirements
- iOS 18.0 or later.
- Xcode 16.4 or later.
- Swift 6.0 or later.

## ⚙️ Installation
1. Clone this repository:
   ```bash
   git clone https://github.com/manucodin/Cities.git
   ```
2. Open the project in Xcode:
   ```bash
   open Cities/Cities.xcodeproj
   ```

## 🏗️ Project Structure
The project follows a modular architecture with the following layers:

- **Data**: Contains data sources, repositories, and network services.
  - `DataSources`: Handles data retrieval from different sources.
  - `Network`: Contains network logic and DTOs.
  - `Repositories`: Implementations of repository contracts.

- **Domain**: Contains models, use cases, and mappers.
  - `Models`: Defines the main domain entities.
  - `UseCases`: Implements business logic.
  - `Mappers`: Converts data between layers.

- **Presentation**: Contains views and presentation logic.
  - `Screens`: Defines the main screens of the application.

- **Utils**: Shared extensions and utilities.

## ▶️ Running the App
1. Select the `Cities` scheme in Xcode.
2. Build and run the app on a simulator or physical device.

## 🔎 Search Algorithm Design

The search functionality in **Cities App** was implemented with a focus on **performance**, **responsiveness**, and **scalability**.

- All city data is **preloaded and cached in memory**, allowing fast, in-memory filtering without requiring disk or network access on each keystroke.
- We use a simple but effective `.lowercased().hasPrefix()` comparison to filter cities based on user input. This ensures fast, case-insensitive matches from the beginning of city names.
- The filtering logic is wrapped inside a **`Task` using `TaskGroup`**, which allows filtering work to run concurrently across multiple chunks of data.
- The list of cities is **split into chunks** and processed in parallel. This improves performance on large datasets by taking advantage of multiple CPU cores and preventing long-running synchronous loops from blocking the main thread.
- Chunking also adds flexibility: it allows tuning performance for different dataset sizes or devices (e.g., reducing chunk size on low-memory devices).
- The SwiftUI `.searchable` modifier combined with `onChange` provides a declarative and efficient way to trigger filtering only when needed.

> ✅ This design achieves a balance between simplicity and efficiency, ensuring a responsive experience while keeping the code clean and adaptable—even when handling hundreds or thousands of cities.


## 🧪 Testing
The project includes unit and UI tests:
- **Unit Tests**: Located in the `CitiesTests` directory.
- **UI Tests**: Located in the `CitiesUITests` directory.

To run the tests:
1. Select the corresponding test scheme.
2. Press `Cmd + U` in Xcode.
