# PickImageAlert

[![GitHub release](https://img.shields.io/github/release/limadeveloper/PickImageAlert.svg)](https://github.com/limadeveloper/PickImageAlert/releases)
[![Build Status](https://travis-ci.org/limadeveloper/PickImageAlert.svg?branch=master)](https://travis-ci.org/limadeveloper/PickImageAlert)
[![codecov](https://codecov.io/gh/limadeveloper/PickImageAlert/branch/master/graph/badge.svg)](https://codecov.io/gh/limadeveloper/PickImageAlert)
[![CocoaPods](https://img.shields.io/badge/Cocoa%20Pods-✓-4BC51D.svg?style=flat)](https://cocoapods.org/pods/PickImageAlert)
[![Language](https://img.shields.io/badge/language-Swift%205.0-orange.svg)](https://developer.apple.com/swift/)
[![Platform](https://img.shields.io/cocoapods/p/PickImageAlert.svg?style=flat)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/github/license/limadeveloper/PickImageAlert.svg)](https://raw.githubusercontent.com/limadeveloper/PickImageAlert/master/LICENSE)
[![Donate](https://img.shields.io/badge/Donate-PayPal-blue.svg)](https://www.paypal.com/cgi-bin/webscr?cmd=_donations&business=NZN6YS87V9ZZW&currency_code=BRL&source=url)

**PickImageAlert** shows a list of your photos using the system alert controller. Also it's possible to take a photo and access the photo library.

![PickImageAlert](https://raw.githubusercontent.com/limadeveloper/PickImageAlert/master/Documents/PickImageAlert.gif)

## ❗️Requirements

- iOS 11.0+
- Swift 5.0+

## ⚒ Installation

### Swift Package Manager

**SWMailgun** is available through [SPM](https://developer.apple.com/videos/play/wwdc2019/408/). To install
it, follow the steps:

```script
Open Xcode project > File > Swift Packages > Add Package Dependecy
```

After that, put the url in the field: `https://github.com/limadeveloper/PickImageAlert.git`

### CocoaPods

**PickImageAlert** is available through [CocoaPods](https://cocoapods.org/pods/PickImageAlert). To install
it, simply add the following line to your Podfile:

```ruby
# Swift 5.0 or later
pod 'PickImageAlert'
```

and run `pod install`

## 🎓 How to use

Import library in your swift file:

```Swift
import PickImageAlert
```

Setup PickImageAlert in your action:

```Swift
let properties = PIAlertProperties(
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

## 📱 Feature

- [x] Can change alert action title;
- [x] Can change the color of alert action;
- [x] Can add icons to alert action;
- [x] Can access photo library;
- [x] Can take photo using the camera;
- [x] Auto layout support;
- [x] iPad support;

## 🙋🏻‍  Communication

- If you found a bug, open an issue.
- If you have a feature request, open an issue.
- If you want to contribute, submit a pull request. 👨🏻‍💻

## 📜 License

**PickImageAlert** is under MIT license. See the [LICENSE](https://raw.githubusercontent.com/limadeveloper/PickImageAlert/master/LICENSE) file for more info.
