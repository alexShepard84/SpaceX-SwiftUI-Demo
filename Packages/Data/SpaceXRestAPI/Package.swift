// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SpaceXRestAPI",
    platforms: [.iOS(.v17)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SpaceXRestAPI",
            targets: ["SpaceXRestAPI"]),
    ],
    dependencies: [
        .package(name: "SpaceXDomain", path: "../Domain/SpaceXDomain"),
        .package(name: "NetworkService", path: "../Services/NetworkService"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SpaceXRestAPI",
            dependencies: [
                "NetworkService",
                "SpaceXDomain"
            ]
        ),
        .testTarget(
            name: "SpaceXRestAPITests",
            dependencies: [
                "NetworkService",
                "SpaceXRestAPI",
                "SpaceXDomain"
            ],
            resources: [
                .process("JSON")
            ]
        ),
    ]
)
