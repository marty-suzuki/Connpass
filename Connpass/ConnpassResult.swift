//
//  ConnpassResult.swift
//  Connpass
//
//  Created by Taiki Suzuki on 2016/07/21.
//
//

import Foundation

public struct ConnpassResult {
    private struct JsonKey {
        static let resultsReturned = "results_returned"
        static let resultsAvailable  = "results_available"
        static let resultsStart = "results_start"
        static let events = "events"
    }
    
    public let resultsReturned: Int
    public let resultsAvailable: Int
    public let resultsStart: Int
    public let events: [ConnpassEvent]
    
    init?(_ dictionary: [String : NSObject]) {
        guard
            let resultsReturned = dictionary[JsonKey.resultsReturned] as? Int,
            let resultsAvailable = dictionary[JsonKey.resultsAvailable] as? Int,
            let resultsStart = dictionary[JsonKey.resultsStart] as? Int,
            let rawEvents = dictionary[JsonKey.events] as? [[String : NSObject]]
        else {
            return nil
        }
        self.resultsReturned = resultsReturned
        self.resultsAvailable = resultsAvailable
        self.resultsStart = resultsStart
        self.events = rawEvents.flatMap { ConnpassEvent($0) }
    }
}

public struct ConnpassEvent {
    private struct JsonKey {
        static let eventId = "event_id"
        static let title = "title"
        static let `catch` = "catch"
        static let `description` = "description"
        static let eventUrl = "event_url"
        static let hashTag = "hash_tag"
        static let startedAt = "started_at"
        static let endedAt = "ended_at"
        static let eventType = "event_type"
        static let ownerId = "owner_id"
        static let ownerNickname = "owner_nickname"
        static let ownerDisplayName = "owner_display_name"
        static let accepted = "accepted"
        static let waiting = "waiting"
        static let updatedAt = "updated_at"
        static let limit = "limit"
        static let series = "series"
        static let address = "address"
        static let place = "place"
        static let lat = "lat"
        static let lon = "lon"
    }
    
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
    
    init?(_ dictionary: [String : NSObject]) {
        guard
            let eventId = dictionary[JsonKey.eventId] as? Int,
            let title = dictionary[JsonKey.title] as? String,
            let `catch` = dictionary[JsonKey.`catch`] as? String,
            let `descriotion` = dictionary[JsonKey.`description`] as? String,
            let rawEventUrl = dictionary[JsonKey.eventUrl] as? String,
            let eventUrl = NSURL(string: rawEventUrl),
            let hashTag = dictionary[JsonKey.hashTag] as? String,
            let rawStartedAt = dictionary[JsonKey.startedAt] as? String,
            let startedAt = NSDate.dateFromISO8601String(rawStartedAt),
            let rawEndAt = dictionary[JsonKey.endedAt] as? String,
            let endAt = NSDate.dateFromISO8601String(rawEndAt),
            let rawEventType = dictionary[JsonKey.eventType] as? String,
            let eventType = EventType(rawValue: rawEventType),
            let ownerId = dictionary[JsonKey.ownerId] as? Int,
            let ownerNickname = dictionary[JsonKey.ownerNickname] as? String,
            let ownerDisplayname = dictionary[JsonKey.ownerDisplayName] as? String,
            let accepted = dictionary[JsonKey.accepted] as? Int,
            let waiting = dictionary[JsonKey.waiting] as? Int,
            let rawUpdatedAt = dictionary[JsonKey.updatedAt] as? String,
            let updatedAt = NSDate.dateFromISO8601String(rawUpdatedAt)
        else {
            return nil
        }
        
        self.eventId = eventId
        self.title = title
        self.`catch` = `catch`
        self.`descriotion` = `descriotion`
        self.eventUrl = eventUrl
        self.hashTag = hashTag
        self.startedAt = startedAt
        self.endAt = endAt
        self.limit = dictionary[JsonKey.limit] as? Int
        self.eventType = eventType
        self.series = ConnpassSeries(dictionary[JsonKey.series] as? [String : NSObject] ?? [:])
        self.address = dictionary[JsonKey.address] as? String
        self.place = dictionary[JsonKey.place] as? String
        self.lat = dictionary[JsonKey.lat] as? Double
        self.lon = dictionary[JsonKey.lon] as? Double
        self.ownerId = ownerId
        self.ownerNickname = ownerNickname
        self.ownerDisplayname = ownerDisplayname
        self.accepted = accepted
        self.waiting = waiting
        self.updatedAt = updatedAt
    }
}

public struct ConnpassSeries {
    private struct JsonKey {
        static let url = "url"
        static let id = "id"
        static let title = "title"
    }
    
    public let url: String
    public let id: Int
    public let title: String
    
    init?(_ dictionary: [String : NSObject]) {
        guard
            let url = dictionary[JsonKey.url] as? String,
            let id = dictionary[JsonKey.id] as? Int,
            let title = dictionary[JsonKey.title] as? String
        else {
            return nil
        }
        self.url = url
        self.id = id
        self.title = title
    }
}