# ControllerMocker

ControllerMocker is simple tool for iOS that allow simply mock and load multiple `ViewController`s. It takes as parametr `array` of `ViewController`s and allows switch among them like in image gallery.

When ControllerMocker is loaded it shows arrows for switching among mocked controllers. Long press on button hide these buttons and double click show list of mocked controllers.

## Installation
For installation use CocoaPods (more info https://cocoapods.org/).
```
pod ’ControllerMocker’, :git => ’https://github.com/marysmech/ControllerMocker.git’
```

- sometimes is needed after CocoaPods installation add manually ControllerMocker to "Linked Frameworks and Libraries" in project settings (tab General).

## Usage
ControllerMocker is extensions of `UIApplicationDelegate` and has two methods.

### Basic usage
Simplest usage is using method with signature:

```swift
public static func testViewControllers( 
  window: UIWindow, 
  controllers: [UIViewController]
)
```

### Slideshow usage
Second option is use mocking with automatic slideshow. Signature is:
```swift
public static func testViewControllersWithTimer( 
  window: UIWindow ,
  controllers: [UIViewController],
  delay: NSTimeInterval = 5
)
```

## Example
```swift
let myViewController1 = MyViewController(MyMock()) 
let myViewController2 = MyViewController(MyMock2())

let controllers = [myViewController1 , myViewController2]

AppDelegate.testViewControllers(window!, controllers: controllers)
```

## Dummy image
If you need some image for controller that you want to mock you can use dummy image that is part of ControllerMocker.

Usage of dummy image is:

```swift
let imgUrl = ControllerMockerDummy.getUrlToDummyImage()
```
Method above return local URL to image.
