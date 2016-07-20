//
//  ConnpassApiClient.swift
//  Connpass
//
//  Created by Taiki Suzuki on 2016/07/21.
//
//

import Foundation

public class ConnpassApiClient {
    public enum Result {
        case Success(ConnpassResult)
        case Failure(NSError)
    }
    
    public static let sharedClient = ConnpassApiClient()
    
    private let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
    private init() {}
    
    public func searchEvent(query: ConnpassSearchQuery, completion: (Result -> Void)?) {
        searchEvent(query, success: { completion?(.Success($0)) }) { completion?(.Failure($0)) }
    }
    
    public func searchEvent(query: ConnpassSearchQuery, success: (ConnpassResult -> Void)?, failure: (NSError -> Void)?) {
        let urlString = "https://connpass.com/api/v1/event/?" + query.value
        guard let url = NSURL(string: urlString) else {
            failure?(NSError(domain: "Invalidate URL", code: -9999, userInfo: nil))
            return
        }
        session.dataTaskWithURL(url) { data, response, error in
            if let error = error {
                failure?(error)
                return
            }
            guard let data = data else {
                failure?(NSError(domain: "Invalidate data", code: -9999, userInfo: nil))
                return
            }
            do {
                guard
                    let dictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as? [String : NSObject],
                    let result = ConnpassResult(dictionary)
                else {
                    failure?(NSError(domain: "Invalidate dictionary", code: -9999, userInfo: nil))
                    return
                }
                success?(result)
                return
            } catch let e as NSError {
                failure?(e)
                return
            }
        }.resume()
    }
}