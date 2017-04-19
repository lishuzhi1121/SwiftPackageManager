// swift-tools-version:3.1

import PackageDescription

let package = Package(
    name: "CardsGame",
    targets: [
        Target(name: "PlayingCardKit", dependencies:[]),
        Target(name: "FisherYatesKit", dependencies:[]),
        Target(name: "DeckOfPlayingCardsKit", dependencies:["PlayingCardKit", "FisherYatesKit"]),
        Target(name: "CardsGame", dependencies:["DeckOfPlayingCardsKit"])
    ],
    dependencies: [
        .Package(url: "https://github.com/onevcat/Rainbow", majorVersion: 2)
    ]
)
