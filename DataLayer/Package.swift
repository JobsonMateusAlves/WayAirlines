// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DataLayer",
    products: [
        .library(
            name: "DataLayer",
            targets: ["DataLayer"]
        ),
    ],
    dependencies: [
        .package(path: "../NetworkLayer"),
        .package(path: "../DomainLayer")
    ],
    targets: [
        .target(
            name: "DataLayer",
            dependencies: [
                "NetworkLayer",
                "DomainLayer"
            ],
            resources: [
                .process("Resources/flights.json")
            ]
        ),
        .testTarget(
            name: "DataLayerTests",
            dependencies: ["DataLayer"]
        ),
    ]
)
