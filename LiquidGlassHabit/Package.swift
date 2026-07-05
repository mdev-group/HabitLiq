// swift-tools-version: 5.10
import PackageDescription

let package = Package(
    name: "LiquidGlassHabit",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .executable(name: "LiquidGlassHabit", targets: ["LiquidGlassHabit"])
    ],
    dependencies: [],
    targets: [
        .executableTarget(
            name: "LiquidGlassHabit",
            dependencies: [],
            path: "Sources/LiquidGlassHabit"
        )
    ]
)
