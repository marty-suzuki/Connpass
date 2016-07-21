//
//  ConnpassSearchQuery.swift
//  Connpass
//
//  Created by Taiki Suzuki on 2016/07/21.
//
//

import Foundation

public struct ConnpassSearchQuery {
    public enum Parameter {
        public enum DisplayOrder: Int {
            case UpdateTime = 1
            case StartDate  = 2
            case New        = 3
        }
        
        case EventId       (Int)
        case Keyword       (String)
        case KeywordOr     (String)
        case Ym            (Int)
        case Ymd           (Int)
        case Nickname      (String)
        case OwnerNickname (String)
        case SeriesId      (Int)
        case Start         (Int)
        case Order         (DisplayOrder)
        case Count         (Int)
        case Format
        
        var value: String {
            switch self {
            case .EventId       (let id)       : return "event_id=\(id)"
            case .Keyword       (let keyword)  : return "keyword=\(keyword.RFC3986Encode)"
            case .KeywordOr     (let keyword)  : return "keyword_or=\(keyword.RFC3986Encode)"
            case .Ym            (let ym)       : return "ym=\(ym)"
            case .Ymd           (let ymd)      : return "ymd=\(ymd)"
            case .Nickname      (let nickname) : return "nickname=\(nickname.RFC3986Encode)"
            case .OwnerNickname (let nickname) : return "owner_nickname=\(nickname.RFC3986Encode)"
            case .SeriesId      (let id)       : return "series_id=\(id)"
            case .Start         (let start)    : return "start=\(start)"
            case .Order         (let order)    : return "order=\(order.rawValue)"
            case .Count         (let count)    : return "count=\(max(1 ,min(100, count)))"
            case .Format                       : return "format=json"
            }
        }
    }
    
    private let parameters: [Parameter]
    var value: String {
        return parameters.map { $0.value }.sort { $0 < $1 }.joinWithSeparator("&")
    }
    
    public init(_ parameter: Parameter) {
        self.parameters = [parameter]
    }
    
    public init(_ parameters: Parameter...) {
        self.parameters = parameters
    }
    
    public init(_ parameters: [Parameter]) {
        self.parameters = parameters
    }
}