// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SpaceXGraphQL",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SpaceXGraphQL",
            targets: ["SpaceXGraphQL"]),
    ],
    dependencies: [
        .package(name: "SpaceXDomain", path: "../Domain/SpaceXDomain"),
        .package(name: "NetworkService", path: "../Services/NetworkService"),
        .package(
            url: "https://github.com/apollographql/apollo-ios.git",
            .upToNextMajor(from: "1.5.0")
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SpaceXGraphQL",
            dependencies: [
                "NetworkService",
                "SpaceXDomain",
                .product(name: "ApolloAPI", package: "apollo-ios")
            ]
        ),
        .testTarget(
            name: "SpaceXGraphQLTests",
            dependencies: ["SpaceXGraphQL"]),
    ]
)
