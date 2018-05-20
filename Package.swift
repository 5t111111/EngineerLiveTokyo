// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "EngineerLiveTokyo",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.3"),
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0-rc.2.2"),
        .package(url: "https://github.com/crossroadlabs/Markdown.git", .exact("1.0.0-alpha.2"))
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Leaf", "Markdown"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
