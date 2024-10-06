// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "PresentationLayer",
    products: [
        .library(
            name: "PresentationLayer",
            targets: ["PresentationLayer"]
        ),
    ],
    dependencies: [
        .package(path: "../DomainLayer")
    ],
    targets: [
        .target(
            name: "PresentationLayer",
            dependencies: [
                "DomainLayer"
            ]
        ),
        .testTarget(
            name: "PresentationLayerTests",
            dependencies: ["PresentationLayer"]
        ),
    ]
)
