// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "EngineerLiveTokyo",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🍃 Leaf template engine.
        .package(url: "https://github.com/vapor/leaf.git", from: "3.0.0-rc.2.2")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "Leaf"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
