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

![01](https://user-images.githubusercontent.com/17869297/30176591-03b2282e-93d1-11e7-966a-d29019271f00.jpg)
![02](https://user-images.githubusercontent.com/17869297/30176592-03b9b792-93d1-11e7-98dd-8555d954e5bf.jpg)
![03](https://user-images.githubusercontent.com/17869297/30176594-03be6698-93d1-11e7-9d6f-d1e610f4438f.jpg)
![04](https://user-images.githubusercontent.com/17869297/30176595-03c00372-93d1-11e7-91a7-ea83adc24564.jpg)
![05](https://user-images.githubusercontent.com/17869297/30176593-03bbd306-93d1-11e7-9e07-9a04a3aeb624.jpg)

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

## Usage
Virtual Tourist is written in Swift 3. You can download it and run it in any version of Xcode and Simulator.

## Contributing
1. Fork it!
2. Create your feature branch: `git checkout -b my-new-feature`
3. Commit your changes: `git commit -am 'Add some feature'`
4. Push to the branch: `git push origin my-new-feature`
5. Submit a pull request.

## Meta

Your Name – erikuecke@gmail.com

[https://github.com/erikuecke](https://github.com/erikuecke)

[swift-image]:https://img.shields.io/badge/swift-3.0-orange.svg
[swift-url]: https://swift.org/

[travis-image]: https://img.shields.io/travis/dbader/node-datadog-metrics/master.svg?style=flat-square
[travis-url]: https://travis-ci.org/dbader/node-datadog-metrics
<!-- [codebeat-image]: https://codebeat.co/badges/c19b47ea-2f9d-45df-8458-b2d952fe9dad
[codebeat-url]: https://codebeat.co/projects/github-com-vsouza-awesomeios-com -->