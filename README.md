# Pixbay App

iOS Coding challenge Fetch Data from [Pixbay](https://pixabay.com/).

[![Swift Version][swift-image]][swift-url]  [![codecov.io](https://coveralls.io/repos/github/saeed3e/Build-status-and-code-coverage-badge/badge.svg?branch=master)](https://codecov.io/gh/codecov/example-swift/branch/master)

# Requirements
* Xcode 11.5
* iOS 11 and above

# Setup

## Install iOS project dependencies

Project uses ruby gems cocoapods in order to install dependencies.

Navigate to project directory:

```
pod install
```

Open `PixbayApp.xcworkspace` (don't open `PixbayApp.xcodeproj` as the app won't compile)
Then your project is ready to use within Xcode IDE.

# Dependencies

## Swiftlint

This Project uses swiftlint to enforce style. The settings are stored in the project directory inside `.swiftlint.yml`.

## RxSwift

This Project uses Reactive concept using `RxSwift` to enable easy composition of asynchronous operations and event/data streams.

# App architecture

1. The app uses *Coordinator pattern* presented by Soroush Khanlou: http://khanlou.com/2015/01/the-coordinator/. This pattern is widely used in iOS community and makes unit testing easier. Basically we're doing a coordinator for each flow of the app (e.g. *AppMainFlow* - entrance to the app, *Onboarding* - Handles register and login flow, etc.)
In swift version of *Coordinator pattern* we're using code closures to inject block of codes for given actions instead of having delegate for each *UIViewController*.
2. App implements *Router* in order to handle properly *back button actions of UINavigationController*. That help us dismiss given child coordinators and to pass outcome value of given child coordinator. Link to article explaining it further: https://hackernoon.com/coordinators-routers-and-back-buttons-c58b021b32a. Each View Controller that is displayed via router needs to conform to *Presentable* protocol.
3. For dependency injection we're using protocol composition. There is DependencyProvider object that has all dependencies and is injected into all coordinators and view models. But each view model and coordinator specifies its own *typealias* for dependencies to have access only to specific dependencies. More on this approach here: http://merowing.info/2017/04/using-protocol-compositon-for-dependency-injection/
4. Asynchronous task are performed with help of *RxSwift* library. Link to repo: https://github.com/ReactiveX/RxSwift
5. View Controllers — need to be backed up by view in standalone storyboard named as ViewController class. View Controller conforms to *StoryboardLoadable* protocol. If the View Controller displays alert view then it should do it via conforming to *DisplaysAlert* and use its methods.

![Architecture](https://user-images.githubusercontent.com/51052591/65523198-984bc600-def4-11e9-8753-2af051aa9e91.png)

# Folder structure

* *Models* - models of app domain
* *Repository* - contains the app repositories
* *Networking* - classes related to networking. It contains API specific classes.
* *NetworkLayer* - classes related to networking. It contains general classes.
* *Services* - all app's dependencies.
* *Application* - it contains AppDelegate class, DependencyProvider and root custom UINavigationController class.
* *Coordinators* - all protocols and base implementation of coordinator pattern.
* *Flows* - it contains all flows of the app. Each flow has its own Coordinator, Modules (View Controllers with View Models), Module Factory and Coordinator Factory (if it has child coordinators)
* *Components* - customised components
* *Helper* - helper classes
* *Extensions* - all extensions to Apple classes
* *Resources* - it contains all graphics assets, fonts, Lottie animation files, etc.
* *RxHelpers* - it contains helper classes for Rx.

# Coding Style guidelines

In project Swiftlint is used in order to check the code for coding style. The configuration file is in root folder undername `.swiftlint`.
Adopted standard of coding style guidelines is *The Official raywenderlich.com Swift Style Guide* that can be found here: https://github.com/raywenderlich/swift-style-guide
Moreover each developer should pay attention to the code he writes:
* There should not be any force unwrapping in code (There can be in unit tests). We're using optional unwrapping in order to prevent crashes of production app and to not disturb user experience.
* There should be empty line after *imports* and before *class, struct, enum* definition.
* There should not be empty line before method name and first line of method body
* There should not be any spaces before opening or closing brackets
* There should not be any trailing white spaces in new lines

[swift-image]:https://img.shields.io/badge/swift-5.1-orange.svg
[swift-url]: https://swift.org/
