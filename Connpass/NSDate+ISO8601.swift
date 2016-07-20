//
//  NSDate+ISO8601.swift
//  Connpass
//
//  Created by Taiki Suzuki on 2016/07/21.
//
//

import Foundation

extension NSDate {
    private static let ISO8601Formatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()
        dateFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZ"
        return dateFormatter
    }()
    
    class func dateFromISO8601String(string: String) -> NSDate? {
        return ISO8601Formatter.dateFromString(string)
    }
}