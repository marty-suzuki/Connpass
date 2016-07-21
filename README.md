# Connpass

[![CI Status](http://img.shields.io/travis/szk-atmosphere/Connpass.svg?style=flat)](https://travis-ci.org/szk-atmosphere/Connpass)
[![Version](https://img.shields.io/cocoapods/v/Connpass.svg?style=flat)](http://cocoapods.org/pods/Connpass)
[![License](https://img.shields.io/cocoapods/l/Connpass.svg?style=flat)](http://cocoapods.org/pods/Connpass)
[![Platform](https://img.shields.io/cocoapods/p/Connpass.svg?style=flat)](http://cocoapods.org/pods/Connpass)

![](./Images/connpass_logo_1.png)

[connpass](http://connpass.com/) search API for Swift.

## Usage

```swift
let query = ConnpassSearchQuery(.Keyword("swift"), .Count(100))
ConnpassApiClient.sharedClient.searchEvent(query) { response in
    switch response.result {
        case .Success(let result):
            print(result.events)
        case .Failure(let error):
            print(error)
    }
}
```

## Parameters

You can use Associated values as parameter with `ConnpassSearchQuery`.

|ConnpassSearchQuery.Parameter| Type       |
|:---------------------------:|:----------:|
|.EventId                     |Int         |
|.Keyword                     |String      |
|.KeywordOr                   |String      |
|.Ym                          |Int         |
|.Ymd                         |Int         |
|.Nickname                    |String      |
|.OwnerNickname               |String      |
|.SeriesId                    |Int         |
|.Start                       |Int         |
|.Order                       |DisplayOrder|
|.Count                       |Int         |

|DisplayOrder|
|:----------:|
|.UpdateTime |
|.StartDate  |
|.New        |

## Result

You can fetch the result as `ConnpassResult`.

```swift
public struct ConnpassResult {
    public let resultsReturned: Int
    public let resultsAvailable: Int
    public let resultsStart: Int
    public let events: [ConnpassEvent]
}
```

```swift
public struct ConnpassEvent {
    public enum EventType: String {
        case Participation = "participation"
        case Advertisement = "advertisement"
    }

    public let eventId: Int
    public let title: String
    public let `catch`: String
    public let `descriotion`: String
    public let eventUrl: NSURL
    public let hashTag: String
    public let startedAt: NSDate
    public let endAt: NSDate
    public let limit: Int?
    public let eventType: EventType
    public let series: ConnpassSeries?
    public let address: String?
    public let place: String?
    public let lat: Double?
    public let lon: Double?
    public let ownerId: Int
    public let ownerNickname: String
    public let ownerDisplayname: String
    public let accepted: Int
    public let waiting: Int
    public let updatedAt: NSDate
}
```

```swift
public struct ConnpassSeries {
    public let url: String
    public let id: Int
    public let title: String
}
```

## Functions

```swift
public func searchEvent(query: ConnpassSearchQuery, completion: (Response -> Void)?)
public func searchEvent(query: ConnpassSearchQuery, success: ((NSURLResponse?, ConnpassResult) -> Void)?, failure: ((NSURLResponse?, NSError) -> Void)?)
```

## Installation

Connpass is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Connpass"
```

## API Reference

[http://connpass.com/about/api/](http://connpass.com/about/api/)

## Requirements

- Xcode 7.3 or greater
- iOS 8.0 or greater

## Author

szk-atmosphere, s1180183@gmail.com

## License

Connpass is available under the MIT license. See the LICENSE file for more info.
