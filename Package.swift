// swift-tools-version:5.1

import PackageDescription

let package = Package(
  name: "PickImageAlert",
  platforms: [
    .iOS(.v13)
  ],
  products: [
    .library(
      name: "PickImageAlert",
      targets: ["PickImageAlert"]
    ),
  ],
  dependencies: [],
  targets: [
    .target(
      name: "PickImageAlert",
      dependencies: []
    ),
    .testTarget(
      name: "PickImageAlertTests",
      dependencies: ["PickImageAlert"]
    ),
  ]
)
