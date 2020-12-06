// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "aoc2020",
    products: [
        .executable(name: "aoc2020", targets: ["aoc2020"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "0.3.0"),
        .package(name: "Combinatorics", url: "https://github.com/dankogai/swift-combinatorics.git", from: "0.1.0")
    ],
    targets: [
        .target(
            name: "aoc2020",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .byName(name: "Combinatorics")
            ]),
        .testTarget(
            name: "aoc2020Tests",
            dependencies: ["aoc2020"])
    ]
)
