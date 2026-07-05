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
            path: "LiquidGlassHabit" // Points directly to the subfolder where your .swift files live
        )
    ]
)
