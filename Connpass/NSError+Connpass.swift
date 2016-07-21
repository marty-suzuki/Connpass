//
//  NSError+Connpass.swift
//  Connpass
//
//  Created by Taiki Suzuki on 2016/07/21.
//
//

import Foundation

extension NSError {
    struct Domain: RawRepresentable {
        static let InvalidateURL        = Domain(rawValue: ("Invalidate URL",        10001))
        static let InvalidateData       = Domain(rawValue: ("Invalidate data",       10002))
        static let InvalidateDictionary = Domain(rawValue: ("Invalidate dictionary", 10003))
        let rawValue: (String, Int)
    }
    
    convenience init(domain: Domain) {
        self.init(domain: domain.rawValue.0, code: domain.rawValue.1, userInfo: nil)
    }
}