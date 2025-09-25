// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Networking",
    platforms: [
        .macOS(.v12), .iOS(.v13), .tvOS(.v13)
    ],
    products: [
        .library(name: "Networking", targets: ["Networking"]),
        .library(name: "NetworkingTesting", targets: ["NetworkingTesting"])
    ],
    targets: [
        .target(name: "Networking"),
        .target(name: "NetworkingTesting", dependencies: ["Networking"])
    ]
)
