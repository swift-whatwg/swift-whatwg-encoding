// swift-tools-version: 6.4

import PackageDescription

let package = Package(
    name: "swift-whatwg-encoding",
    platforms: [
        .macOS(.v27),
        .iOS(.v27),
        .tvOS(.v27),
        .watchOS(.v27),
        .visionOS(.v27),
    ],
    products: [
        .library(
            name: "WHATWG Encoding",
            targets: ["WHATWG Encoding"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/swift-atoms/swift-byte.git", branch: "main")
    ],
    targets: [
        .target(
            name: "WHATWG Encoding",
            dependencies: [
                .product(name: "Byte", package: "swift-byte")
            ]
        ),
        .testTarget(
            name: "WHATWG Encoding Tests",
            dependencies: [
                .target(name: "WHATWG Encoding"),
                .product(name: "Byte", package: "swift-byte"),
            ]
        ),
    ],
    swiftLanguageModes: [.v6]
)

for target in package.targets where ![.system, .binary, .plugin, .macro].contains(target.type) {
    target.swiftSettings = (target.swiftSettings ?? []) + [
        .strictMemorySafety(),
        .enableUpcomingFeature("ExistentialAny"),
        .enableUpcomingFeature("InternalImportsByDefault"),
        .enableUpcomingFeature("MemberImportVisibility"),
        .enableUpcomingFeature("NonisolatedNonsendingByDefault"),
        .enableUpcomingFeature("InferIsolatedConformances"),
        .enableExperimentalFeature("Lifetimes"),
        .treatAllWarnings(as: .error),
    ]
}
