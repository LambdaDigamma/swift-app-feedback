// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "AppFeedback",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v14),
        .macOS(.v11),
    ],
    products: [
        .library(
            name: "AppFeedback",
            targets: ["AppFeedback"]
        ),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "AppFeedback",
            dependencies: []
        ),
        .testTarget(
            name: "AppFeedbackTests",
            dependencies: ["AppFeedback"]
        ),
    ]
)
