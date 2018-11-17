# PickImageAlert

[![GitHub release](https://img.shields.io/github/release/limadeveloper/PickImageAlert.svg)](https://github.com/limadeveloper/PickImageAlert/releases)
[![Build Status](https://travis-ci.org/limadeveloper/PickImageAlert.svg?branch=master)](https://travis-ci.org/limadeveloper/PickImageAlert)
![Language](https://img.shields.io/badge/language-Swift%204.2-orange.svg)
[![CocoaPods](https://img.shields.io/badge/Cocoa%20Pods-✓-4BC51D.svg?style=flat)](https://cocoapods.org/pods/PickImageAlert)
[![License](https://img.shields.io/cocoapods/l/PickImageAlert.svg?style=flat)](http://cocoapods.org/pods/PickImageAlert)
[![Platform](https://img.shields.io/cocoapods/p/PickImageAlert.svg?style=flat)](http://cocoapods.org/pods/PickImageAlert)

PickImageAlert provides a list of your photos using the system alert controller. Also it's possible to take a photo and access the photo library.

![PickImageAlert](https://raw.githubusercontent.com/limadeveloper/PickImageAlert/master/Documents/PickImageAlert.gif)

## Requirements

- iOS 11.0+
- Swift 4.2+

## Installation

### CocoaPods

**PickImageAlert** is available through [CocoaPods](https://cocoapods.org/pods/PickImageAlert). To install
it, simply add the following line to your Podfile:

```ruby
# Swift 4.2 or later
pod 'PickImageAlert', '~> 1.0'
```

and run `pod install`

## How to use

Import library in your swift file:

```Swift
import PickImageAlert
```

Setup PickImageAlert in your action:

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

And don't forget to setup your info.plist file to require photo library access:

![plist](https://raw.githubusercontent.com/limadeveloper/PickImageAlert/master/Documents/plist_photos_access.png)

## Feature

- Can change title and actions text;
- Can access photo library;
- Can take photo using the camera;
- Auto layout support;
- iPad support;

## Communication

- If you found a bug, open an issue.
- If you have a feature request, open an issue.
- If you want to contribute, submit a pull request. 👨🏻‍💻

## License

**PickImageAlert** is under MIT license. See the [LICENSE](LICENSE) file for more info.