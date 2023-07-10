# BlipFM

## About the APP
The app is architected using the principles of Clean/Onion Architecture, SOLID, and MVVM design pattern for UI/Interaction, the user interface was done using SwiftUI. I believe that this is sufficient to get a clear understanding of the code and how to navigate through it. 

All of it was chosen to keep things as simple as possible due to the scope of this project. 
I'm using Fastlane to automate the tests and lint executions. Also, the app is written in Swift 5.

In the app you will find the following structure:
* BlipFM - All the app code is in there
* BlipFMTests - All the Unit Tests

## TechDetails

>```bash
>Version 14.3.1 (14E300c)
>iOS: 16.0
>Swift Version: 5.0
>```

### High-Level Architecture

![GeneralArch](https://github.com/raafaelima/BlipFM/assets/7543763/eefdb8e2-4d9b-492a-bb5a-261c714b1955)

## Getting Started

### XCode

To run the project on XCode, you just need to have iOS 16.0 supported versions of Xcode and macOS, the development was made using those support versions below.

1. macOS Monterey 12.5 or higher
2. XCode Version 13 or higher

### Fastlane
If you wanna run the Fastlane scripts, you need to have some ruby version installed on your machine. There's a script on the `make setup` phase that will install the tools needed (homebrew, rbenv, swiftlint, and ruby). If you already have the ruby set on your dev machine, you just need to run the `make install` to install the gems and then use the `make test` and `make lint` to run the tests and the lint, respectively.

## Running

1. Run the tests
>
>```bash
>make test
>```

2. List all targets with documentation
>
>```bash
>make
>```
