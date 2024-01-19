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
4. **SwiftUI Advanced Features**: Implementing custom animations and dynamic UI components.
5. **Testing**: Unit and UI tests to validate code.

## Architecture
The application uses a modular approach with Swift Packages, promoting code reusability and maintainability.

## Getting Started
Clone the repository and open the project in Xcode to begin:

```bash
git clone https://github.com/alexShepard84/SwiftShowcase.git
```

## Contributions
Feedback, suggestions, and contributions are welcome. Please use GitHub issues and pull requests.

## Author
Alex Schäfer (a.schaefer@app-concept.de)

