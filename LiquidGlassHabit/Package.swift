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
    targets: [
        .executableTarget(
            name: "LiquidGlassHabit",
            path: ".", // <--- CRUCIAL: Tells the compiler to look right here in the main folder!
            sources: ["App.swift", "ContentView.swift"] // <--- Points directly to your code files
        )
    ]
)
