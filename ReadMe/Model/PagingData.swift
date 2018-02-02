//
//  PagingData.swift
//  ReadMe
//
//  Created by Son Nguyen on 12/22/17.
//  Copyright © 2017 Son Nguyen. All rights reserved.
//

import Foundation
import HandyJSON
class PagingData: HandyJSON {
    required init() { }
    var data = [FeedDataModel]()
    var paging : Paging?
}

class Paging : HandyJSON {
required init() { }
    var next : String?
    var previous : String?
}
