// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NetworkService",
    platforms: [.iOS(.v17), .macOS(.v10_15)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "NetworkService",
            targets: ["NetworkService"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/AliSoftware/OHHTTPStubs.git",
            .upToNextMajor(from: "9.1.0")
        ),
        .package(
            url: "https://github.com/joel-perry/ApolloCombine.git",
            .upToNextMajor(from: "0.7.1")
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "NetworkService",
            dependencies: [
                "ApolloCombine"
            ]
        ),
        .testTarget(
            name: "NetworkServiceTests",
            dependencies: [
                "NetworkService",
                .product(name: "OHHTTPStubsSwift", package: "OHHTTPStubs")
            ]
        ),
    ]
)
