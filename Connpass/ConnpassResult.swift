//
//  ConnpassResult.swift
//  Connpass
//
//  Created by Taiki Suzuki on 2016/07/21.
//
//

import Foundation

public struct ConnpassResult {
    public let resultsReturned: Int
    public let resultsAvailable: Int
    public let resultsStart: Int
    public let events: [ConnpassEvent]
    
    init?(_ dictionary: [String : NSObject]) {
        guard
            let resultsReturned = dictionary["results_returned"] as? Int,
            let resultsAvailable = dictionary["results_available"] as? Int,
            let resultsStart = dictionary["results_start"] as? Int,
            let rawEvents = dictionary["events"] as? [[String : NSObject]]
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
            let eventId = dictionary["event_id"] as? Int,
            let title = dictionary["title"] as? String,
            let `catch` = dictionary["catch"] as? String,
            let `descriotion` = dictionary["description"] as? String,
            let rawEventUrl = dictionary["event_url"] as? String,
            let eventUrl = NSURL(string: rawEventUrl),
            let hashTag = dictionary["hash_tag"] as? String,
            let rawStartedAt = dictionary["started_at"] as? String,
            let startedAt = NSDate.dateFromISO8601String(rawStartedAt),
            let rawEndAt = dictionary["ended_at"] as? String,
            let endAt = NSDate.dateFromISO8601String(rawEndAt),
            let rawEventType = dictionary["event_type"] as? String,
            let eventType = EventType(rawValue: rawEventType),
            let ownerId = dictionary["owner_id"] as? Int,
            let ownerNickname = dictionary["owner_nickname"] as? String,
            let ownerDisplayname = dictionary["owner_display_name"] as? String,
            let accepted = dictionary["accepted"] as? Int,
            let waiting = dictionary["waiting"] as? Int,
            let rawUpdatedAt = dictionary["updated_at"] as? String,
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
        self.limit = dictionary["limit"] as? Int
        self.eventType = eventType
        self.series = ConnpassSeries(dictionary["series"] as? [String : NSObject] ?? [:])
        self.address = dictionary["address"] as? String
        self.place = dictionary["place"] as? String
        self.lat = dictionary["lat"] as? Double
        self.lon = dictionary["lon"] as? Double
        self.ownerId = ownerId
        self.ownerNickname = ownerNickname
        self.ownerDisplayname = ownerDisplayname
        self.accepted = accepted
        self.waiting = waiting
        self.updatedAt = updatedAt
    }
}

public struct ConnpassSeries {
    public let url: String
    public let id: Int
    public let title: String
    
    init?(_ dictionary: [String : NSObject]) {
        guard
            let url = dictionary["url"] as? String,
            let id = dictionary["id"] as? Int,
            let title = dictionary["title"] as? String
        else {
            return nil
        }
        self.url = url
        self.id = id
        self.title = title
    }
}