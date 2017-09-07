# Veteran Caregiver Resource
> Veteran Caregiver Resource is an app for users to easily search, save and share resources from an open database API provided by the U.S. Veterans Affairs.

[![Swift Version][swift-image]][swift-url]
[![Build Status][travis-image]][travis-url] 
[![Platform](https://img.shields.io/cocoapods/p/LFAlertController.svg?style=flat)](http://cocoapods.org/pods/LFAlertController)

This app gives any U.S. servicemember, veteran, their caregiver, family member or advocate access to a comprehensive list of over 2,000+ federal, state, and NGO resources compiled by U.S Dept of Veteran Affairs. The range of resources include: 
	
	* Health, 
	* Benefits & Compensation
 	* Housing
    * Education & Training
    * Employment
    * Family & Caregiver Support
    * Transportation & Travel
    * Homeless Assistance
    * Other Services & Resources 

Veteran Caregiver Resource app peforms a get request to the Veteran Affairs API, downloads and parses a JSON file into a persistant Core Data database. The user can initially filter through all the resources for a specific subject, then search through all the titles, description and subects of that filter. Once the resource is found, the user can see the details of that resource, go to the resource website, save it to a persistent list of saved resource and then share it with anyone through textmessage, email or social media.

![01resource](https://user-images.githubusercontent.com/17869297/30175983-c3173630-93ce-11e7-866c-a4ce53943d47.jpg)
![02resource](https://user-images.githubusercontent.com/17869297/30175982-c3154384-93ce-11e7-8230-a7eb65709b34.jpg)
![03resource](https://user-images.githubusercontent.com/17869297/30175984-c317769a-93ce-11e7-9031-5a8c02370b4f.jpg)
![04resource](https://user-images.githubusercontent.com/17869297/30175985-c323e592-93ce-11e7-9c03-7ff92e1da12e.jpg)
![05resource](https://user-images.githubusercontent.com/17869297/30175981-c31533d0-93ce-11e7-9933-582b5bf123c0.jpg)

## Features

- [x] A persistent database of resources utilizing Core Data
- [x] Quickly search through all titles, descriptions, and subjects of resources with UISearchController 
- [x] Create a saved list of resources, that persists with your app.
- [x] Share a resource with UIActivityController
- [x] Go to resource websites from the app.

## Requirements

- iOS 8.0+
- Xcode 7.3

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `YourLibrary` by adding it to your `Podfile`:

```ruby
platform :ios, '8.0'
use_frameworks!
pod 'YourLibrary'
```

To get the full benefits import `YourLibrary` wherever you import UIKit

``` swift
import UIKit
import YourLibrary
```
#### Carthage
Create a `Cartfile` that lists the framework and run `carthage update`. Follow the [instructions](https://github.com/Carthage/Carthage#if-youre-building-for-ios) to add `$(SRCROOT)/Carthage/Build/iOS/YourLibrary.framework` to an iOS project.

```
github "yourUsername/yourlibrary"
```
#### Manually
1. Download and drop ```YourLibrary.swift``` in your project.  
2. Congratulations!  

## Usage example

```swift
import EZSwiftExtensions
ez.detectScreenShot { () -> () in
    print("User took a screen shot")
}
```

## Contribute

We would love you for the contribution to **YourLibraryName**, check the ``LICENSE`` file for more info.

## Meta

Your Name – [@YourTwitter](https://twitter.com/dbader_org) – YourEmail@example.com

Distributed under the XYZ license. See ``LICENSE`` for more information.

[https://github.com/yourname/github-link](https://github.com/dbader/)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/
[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
[codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com