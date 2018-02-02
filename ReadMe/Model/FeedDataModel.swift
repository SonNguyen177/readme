//
//  FeedDataModel.swift
//  ReadMe
//
//  Created by Son Nguyen on 12/22/17.
//  Copyright © 2017 Son Nguyen. All rights reserved.
//

import UIKit
import HandyJSON
class FeedDataModel: HandyJSON {
    required init() { }
    var id = ""
    var full_picture = ""
    var message = ""
    var link = ""
    var created_time : Date?
    
    func mapping(mapper: HelpingMapper) {
        
        mapper <<< self.created_time <-- ("created_time",
                                      TransformOf<Date, String>(fromJSON: { Date.from(string: "\($0 ?? "")", format: Date.DEFAULT_FORMAT) },
                                                                toJSON: { $0?.toString(format: Date.DEFAULT_FORMAT) }))
       
        
        
    }
    
}
