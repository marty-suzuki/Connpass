//
//  ConnpassApiClient.swift
//  Connpass
//
//  Created by Taiki Suzuki on 2016/07/21.
//
//

import Foundation

public class ConnpassApiClient {
    public struct Response {
        public enum Result {
            case Success(ConnpassResult)
            case Failure(NSError)
        }
        public let result: Result
        public let response: NSURLResponse?
    }
    
    private struct Const {
        static let HttpAPIPath = "http://connpass.com/api/v1/event/"
        static let HttpsAPIPath = "https://connpass.com/api/v1/event/"
    }
    
    public static let sharedClient = ConnpassApiClient()
    
    private let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    public var useHttps: Bool = false
    
    private init() {}
    
    public func searchEvent(query: ConnpassSearchQuery, completion: (Response -> Void)?) {
        searchEvent(query, success: {
            completion?(Response(result: .Success($1), response: $0))
        }) {
            completion?(Response(result: .Failure($1), response: $0))
        }
    }
    
    public func searchEvent(query: ConnpassSearchQuery, success: ((NSURLResponse?, ConnpassResult) -> Void)?, failure: ((NSURLResponse?, NSError) -> Void)?) {
        let path = useHttps ? Const.HttpsAPIPath : Const.HttpAPIPath
        let urlString = path + "?" + query.value
        guard let url = NSURL(string: urlString) else {
            failure?(nil, NSError(domain: .InvalidateURL))
            return
        }
        session.dataTaskWithURL(url) {
            if let error = $2 {
                failure?($1, error)
                return
            }
            guard let data = $0 else {
                failure?($1, NSError(domain: .InvalidateData))
                return
            }
            do {
                guard
                    let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String : NSObject],
                    let result = ConnpassResult(dictionary)
                else {
                    failure?($1, NSError(domain: .InvalidateDictionary))
                    return
                }
                success?($1, result)
                return
            } catch let e as NSError {
                failure?($1, e)
                return
            }
        }.resume()
    }
}