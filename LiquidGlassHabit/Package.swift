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
            path: ".",
            sources: [
                "sources/liquidglasshabit/App.swift",
                "sources/liquidglasshabit/ContentView.swift",
                "Sources/LiquidGlassHabit/App.swift",
                "Sources/LiquidGlassHabit/ContentView.swift"
            ]
        )
    ]
)
