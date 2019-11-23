// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "NewsCore",
    platforms: [
        .macOS(.v10_14),
        .iOS(.v12),
        .tvOS(.v13),
        .watchOS(.v4)
    ],
    products: [
        .library(
            name: "NewsCore",
            targets: ["NewsCore"]
        )
    ],
    targets: [
        .target(
            name: "NewsCore",
            dependencies: []
        ),
        .testTarget(
            name: "NewsCoreTests",
            dependencies: ["NewsCore"]
        ),
        .testTarget(
            name: "NewsCoreModelTests",
            dependencies: ["NewsCore"]
        ),
        .testTarget(
            name: "NewsCoreUtilitiesTests",
            dependencies: ["NewsCore"]
        )
    ]
)
