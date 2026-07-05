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
            name: "LiquidGlassHabit" // Bypassed the strict path field! Swift will now auto-scan.
        )
    ]
)
