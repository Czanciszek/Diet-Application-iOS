// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DietAppService",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "DietAppService",
            targets: ["DietAppService"]),
    ],
    dependencies: [
        .package(path: "DietAppAPI"),
        .package(path: "DietAppModel"),
        .package(path: "DietAppUtils"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "DietAppService",
            dependencies: ["DietAppAPI", "DietAppModel", "DietAppUtils"]
        ),
        .testTarget(
            name: "DietAppServiceTests",
            dependencies: ["DietAppService"]),
    ]
)
