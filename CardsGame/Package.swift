// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "CardsGame",
    targets: [
        Target(name: "PlayingCardKit", dependencies:[]),
        Target(name: "CardsGame", dependencies:["PlayingCardKit"])
    ],
    dependencies: [
        .Package(url: "https://github.com/onevcat/Rainbow", majorVersion: 2)
    ]
)
