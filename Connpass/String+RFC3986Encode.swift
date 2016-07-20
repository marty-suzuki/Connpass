//
//  String+RFC3986Encode.swift
//  Connpass
//
//  Created by Taiki Suzuki on 2016/07/21.
//
//

import Foundation

extension String {
    var RFC3986Encode: String {
        let allowedCharacterSet: NSMutableCharacterSet = .alphanumericCharacterSet()
        allowedCharacterSet.addCharactersInString("-._~")
        return stringByAddingPercentEncodingWithAllowedCharacters(allowedCharacterSet) ?? ""
    }
}