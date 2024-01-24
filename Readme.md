# SwiftShowcase

## Overview
SwiftShowcase is an iOS application that demonstrates advanced development techniques in Swift and SwiftUI, focusing on both RESTful and GraphQL API integrations. The project adheres to Clean Architecture principles to ensure maintainability, scalability, and separation of concerns.

## Objective
This application is designed to showcase:
- Swift and SwiftUI application development
- Implementation of MVVM design pattern within Clean Architecture
- Integration with RESTful and GraphQL APIs
- Local data management using Core Data
- Advanced SwiftUI features and animations
- Unit and UI testing

## Clean Architecture
Clean Architecture involves separating the code into layers, each with its distinct responsibility. This project is structured into:
- **Entities Layer**: Contains the business logic models.
- **Use Cases Layer**: Encapsulates the application-specific business rules.
- **Interface Adapters Layer**: Comprises ViewModels, presenting data to the UI and handling user input.
- **Frameworks and Drivers Layer**: Manages external dependencies and data sources, such as API services and databases.

This layered approach ensures that the application is not only testable and independent of external frameworks but also that business logic and UI are decoupled.

## Features
SwiftShowcase includes:
1. **REST API Integration**: Fetching and displaying data from RESTful services.
2. **GraphQL API Integration**: Handling queries and mutations with GraphQL.
3. **Local Data Storage**: Using Core Data for CRUD operations.
4. **SwiftUI Features**: Implementing UI components.
5. **Testing**: Unit and UI tests to validate code.

## Architecture
The application uses a modular approach with Swift Packages, promoting code reusability and maintainability.

## App Structure

The application is structured into several layers and packages, each with a specific role in the overall architecture. Below is an overview of the main components:

### Domain Layer: `SpaceXDomain` (Swift Package)
- Contains the core business logic and entities (models) of the application.
- Defines interfaces (protocols) for repositories and use cases.

### Data Layer: `SpaceXRestApi` (Swift Package)
- Responsible for data retrieval and persistence.
- Implements the repository interfaces defined in the `SpaceXDomain` package.
- Interacts with external data sources, such as REST APIs.

### Network Service: `NetworkService` (Swift Package)
- A standalone package dedicated to handling network requests.
- Provides a reusable and configurable service for making API calls.

### App Layer
- **DIContainer**: Manages the dependencies of the application, providing a centralized point for object creation and dependency injection.
- **PreviewDIContainer**: A specialized version of `DIContainer` used for SwiftUI previews. It typically provides mock implementations for testing and UI development purposes.

Each layer is designed to be independent and interchangeable, promoting a clean architecture that separates concerns and enhances testability.

## Getting Started
Clone the repository and open the project in Xcode to begin:

```bash
git clone https://github.com/alexShepard84/SwiftShowcase.git
```

## Project Setup

This section guides you through the initial setup process for the SwiftShowcase project.

### Ruby Dependencies and Bundler

This project uses [Bundler](https://bundler.io/) to manage Ruby dependencies, including [CocoaPods](https://cocoapods.org/) and [Fastlane](https://fastlane.tools/).

#### Prerequisites
Ensure you have Ruby installed on your system. The required Ruby version is >= 2.6.3 and <= 3.2.2. You can check your Ruby version with `ruby -v`.

If Bundler is not already installed, install it using:

```bash
gem install bundler
```

#### Installing Dependencies
To install all required Ruby gems, run the following command in the project directory:

```bash
bundle install
```

This will install the gems defined in the `Gemfile`.

#### Using `bundle exec`
To ensure you are using the specific gem versions defined for this project, you should prefix commands with `bundle exec`. For example:

- To run Fastlane lanes, use:

```bash
bundle exec fastlane [lane_name]
```

Using `bundle exec` ensures that you are using the correct versions of the gems set for this project and avoids conflicts with other gem versions that may be installed globally on your system.

## Contributions
Feedback, suggestions, and contributions are welcome. Please use GitHub issues and pull requests.

## Author
Alex Schäfer (a.schaefer@app-concept.de)

