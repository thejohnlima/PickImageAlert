# PickImageAlert

PickImageAlert provides a list of your photos in your alert controller with three alert actions

![PickImageAlert](Documents/PickImageAlert.gif)

```Swift
let properties = PIAlertController.AlertProperties(
    title: "Pick Image",
    cameraActionTitle: "Camera",
    gallaryActionTitle: "Gallary",
    cancelActionTitle: "Cancel",
    style: .actionSheet
)

let pickImageAlert = PickImageAlert(with: self, alertProperties: properties)

pickImageAlert.pickImage { image in
    print("📷 selected photo: \(image)")
}
```

[![GitHub release](https://img.shields.io/github/release/limadeveloper/PickImageAlert.svg)](https://github.com/limadeveloper/PickImageAlert/releases)
![Language](https://img.shields.io/badge/language-Swift%204.2-orange.svg)
[![CocoaPods](https://img.shields.io/badge/Cocoa%20Pods-✓-4BC51D.svg?style=flat)](https://cocoapods.org/pods/PickImageAlert)
[![CocoaPodsDL](https://img.shields.io/cocoapods/dt/PickImageAlert.svg)](https://cocoapods.org/pods/PickImageAlert)

## Feature

- Can change title and actions text;
- Can access photo library;
- Can take photo using the camera;
- Auto layout support;
- iPad support;

## Requirements

- iOS 11.0+
- Swift 4.2+

## Installation

### CocoaPods

**PickImageAlert** is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
# Swift 4.2 or later
pod 'PickImageAlert', '~> 1.0'
```

and run `pod install`

## Change log

Change log is [here](https://github.com/limadeveloper/PickImageAlert/blob/master/CHANGELOG.md).

## Communication

- If you found a bug, open an issue.
- If you have a feature request, open an issue.
- If you want to contribute, submit a pull request. 👨🏻‍💻

## License

**PickImageAlert** is under MIT license. See the [LICENSE](LICENSE) file for more info.