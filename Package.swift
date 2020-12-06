// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "aoc2020",
    products: [
        .executable(name: "day1", targets: ["day1"]),
        .executable(name: "day2", targets: ["day2"]),
        .executable(name: "day3", targets: ["day3"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
        .package(name: "Combinatorics", url: "https://github.com/dankogai/swift-combinatorics.git", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "day1",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .byName(name: "Combinatorics")
            ]),
        .testTarget(
            name: "day1Tests",
            dependencies: ["day1"]),
        .target(
            name: "day2",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ]),
        .target(
            name: "day3",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
            ])
    ]
)
