<h1 align="center">PickImageAlert</h1>

<p align="center">
 <a href="https://github.com/thejohnlima/PickImageAlert/releases">
  <img src="https://img.shields.io/github/v/release/thejohnlima/PickImageAlert?style=flat">
 </a>
 <a href="https://travis-ci.org/thejohnlima/PickImageAlert">
  <img src="https://travis-ci.org/thejohnlima/PickImageAlert.svg?branch=master">
 </a>
 <a href="https://codecov.io/gh/thejohnlima/PickImageAlert">
  <img src="https://codecov.io/gh/thejohnlima/PickImageAlert/branch/master/graph/badge.svg">
 </a>
 <a href="https://cocoapods.org/pods/PickImageAlert">
  <img src="https://img.shields.io/badge/Cocoa%20Pods-✓-4BC51D.svg?style=flat">
 </a>
 <a href="https://github.com/thejohnlima/PickImageAlert">
  <img src="https://img.shields.io/github/repo-size/thejohnlima/PickImageAlert.svg?style=flat">
 </a>
 <a href="https://raw.githubusercontent.com/thejohnlima/PickImageAlert/master/LICENSE">
  <img src="https://img.shields.io/github/license/thejohnlima/PickImageAlert.svg?style=flat">
 </a>
 <a href="https://developer.apple.com/ios/">
  <img src="https://img.shields.io/cocoapods/p/PickImageAlert?style=flat">
 </a>
 <a href="https://developer.apple.com/swift/">
  <img src="https://img.shields.io/badge/Swift-5-blue.svg?style=flat">
 </a>
 <a href="https://patreon.com/thejohnlima">
  <img src="https://img.shields.io/badge/donate-patreon-yellow.svg?style=flat">
 </a>
</p>

**PickImageAlert** shows a list of your photos using the system alert controller. Also it's possible to take a photo and access the photo library.

![PickImageAlert](https://raw.githubusercontent.com/thejohnlima/PickImageAlert/master/Documents/PickImageAlert.gif)

## ❗️Requirements

- iOS 11.0+
- Swift 5.0+

## ⚒ Installation

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

![plist](https://raw.githubusercontent.com/thejohnlima/PickImageAlert/master/Documents/plist_photos_access.png)

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

**PickImageAlert** is under MIT license. See the [LICENSE](LICENSE) file for more info.
