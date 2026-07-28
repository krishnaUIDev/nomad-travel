// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NomadTravel",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "NomadTravel",
            targets: ["NomadTravel"]
        )
    ],
    targets: [
        .target(
            name: "NomadTravel",
            path: "Sources"
        ),
        .testTarget(
            name: "NomadTravelTests",
            dependencies: ["NomadTravel"],
            path: "Tests/NomadTravelTests"
        )
    ]
)
