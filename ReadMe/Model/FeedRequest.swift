//
//  FeedRequest.swift
//  ReadMe
//
//  Created by Son Nguyen on 12/22/17.
//  Copyright © 2017 Son Nguyen. All rights reserved.
//

import Foundation
import FacebookCore
import FacebookLogin

struct FeedDataRequest: GraphRequestProtocol {
    struct Response: GraphResponseProtocol {
        
        fileprivate let rawResponse: Any?
        
        public init(rawResponse: Any?) {
            self.rawResponse = rawResponse
        }
        
        public var dictionaryValue: [String : Any]? {
            return rawResponse as? [String : Any]
        }
        
        public var arrayValue: [Any]? {
            return rawResponse as? [Any]
        }
        
        public var stringValue: String? {
            return rawResponse as? String
        }
    }
    
    var graphPath = "/TonyBuoiSang/feed"
    var parameters: [String : Any]? = ["fields": "full_picture,message,link,created_time", "limit": 50]
    var accessToken = AccessToken.current
    var httpMethod: GraphRequestHTTPMethod = .GET
    var apiVersion: GraphAPIVersion = .defaultVersion
    // var rawResponse : String?
}
