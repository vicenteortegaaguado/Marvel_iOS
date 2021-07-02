# Marvel_iOS

## Version

1.0

### Build

1

## Build and Runtime Requirements
+ Xcode 12.4 or later
+ iOS 14.4 or later


## Configuring the Project

Configuring the Xcode project requires a few steps . 

1) Create an account at [Marvel API](https://developer.marvel.com)

2) Get you api keys (public and private) and remember to read documentation.
    [Keys](https://developer.marvel.com/account)
    [Start](https://developer.marvel.com/documentation/getting_started)
    [GENERAL API INFORMATION](https://developer.marvel.com/documentation/generalinfo)
    [RESULT STRUCTURE](https://developer.marvel.com/documentation/apiresults)
    [ENTITY TYPES AND REPRESENTATIONS](https://developer.marvel.com/documentation/entity_types)
    [AUTHORIZING AND SIGNING REQUESTS](https://developer.marvel.com/documentation/authorization)
    [ATTRIBUTION, LINKING AND RATE LIMITS](https://developer.marvel.com/documentation/attribution)
    [IMAGES](https://developer.marvel.com/documentation/images)
    
3) Find CommunicationKeys.plist and fill the field with your marvel keys

4) Configure to the project bundle identifier

5) Ready to run the project!

## About Marvel

This is an iOS project that collect data from Marvel api and feed a list to show marvel characters and the detail of each one of them.

## Language version

Swift  5

## Application Architecture

This project follows the Model-View View-Model (MVVM) design pattern and development practices the view components by code. Entry point is CharactersListViewController and show Marvel characters with a table view where each cell navigates to CharacterDetailViewController to display character content individually.

The files are grouped by functionality and there are 3 groups: presentation, data and common.

Presentation where you can find views and tools to configure them. Each view or view model inherits from a base class that defines binding between view and model.

Data where you can find all related with models and tools to work with tem. Communication manager is responsible to get that from Marvel api and notifiy back to requestor, you have to fill communication keys fields as commented at  "Configuring the Project".

Commom containts common tools and resources for views and data.

## Unit Tests

Marvel has unit tests. These tests are in the MarvelTests folder and are grouped following the same folder structure that the project. UnitTest AppDelegate is the mock of AppDelegate to avoid normal app launch and to not interfere in tests.
