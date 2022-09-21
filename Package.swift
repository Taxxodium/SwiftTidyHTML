// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

#if swift(>=5.3) && !os(Linux)
let dependencies: [Target.Dependency] = []
#else
let dependencies: [Target.Dependency] = ["libtidyhtml5"]
#endif

#if swift(>=5.2) && !os(Linux)
let pkgConfig: String? = nil
#else
let pkgConfig = "tidy-html5"
#endif

#if swift(>=5.2)
let provider: [SystemPackageProvider] = [
    .apt(["tidy-html5"])
]
#else
let provider: [SystemPackageProvider] = [
    .apt(["tidy-html5"]),
    .brew(["tidy-html5"])
]
#endif

let package = Package(
    name: "SwiftTidyHTML",
    platforms: [
        .iOS(.v13), .tvOS(.v13), .macOS(.v10_14)
    ],
    products: [
        .library(name: "SwiftTidyHTML", targets: ["SwiftTidyHTML"]),
    ],
    targets: [
        .systemLibrary(
            name: "libtidyhtml5",
            path: "Sources/SwiftTidyHTML",
            pkgConfig: pkgConfig,
            providers: provider
        ),
        .target(
            name: "SwiftTidyHTML",
            dependencies: dependencies,
            path: "Sources"),
        .testTarget(
            name: "SwiftTidyHTMLTests",
            dependencies: ["SwiftTidyHTML"]),
    ]
)
