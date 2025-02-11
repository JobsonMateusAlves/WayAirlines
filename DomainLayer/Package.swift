// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DomainLayer",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "DomainLayer",
            targets: ["DomainLayer"]
        ),
    ],
    targets: [
        .target(
            name: "DomainLayer"
        ),
        .testTarget(
            name: "DomainLayerTests",
            dependencies: ["DomainLayer"]
        ),
    ]
)
