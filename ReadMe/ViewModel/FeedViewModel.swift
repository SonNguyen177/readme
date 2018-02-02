//
//  FeedViewModel.swift
//  ReadMe
//
//  Created by Son Nguyen on 12/22/17.
//  Copyright © 2017 Son Nguyen. All rights reserved.
//

import Foundation
import FacebookCore

protocol FeedBindingDelegate : class {
    func didGetData(error : Any?)
}

class FeedViewModel {
    
    var pagingData = PagingData()
    weak var delegate : FeedBindingDelegate?
    
    func requestData(feedOfPage : FeedDataRequest? = FeedDataRequest()){
        let connection = GraphRequestConnection()
        if AccessToken.current != nil {
            // User is logged in, use 'accessToken' here.
            connection.add(feedOfPage!) { response, result in
                switch result {
                case .success(let response):
                    if let responseDictionary = response.dictionaryValue {
                        if let newData = PagingData.deserialize(from: responseDictionary) {
                            self.pagingData = newData
                            self.delegate?.didGetData(error: nil)
                        }
                    
                    }
                    
                case .failed(let error):
                    print("Custom Graph Request Failed: \(error)")
                    self.delegate?.didGetData(error: error)
                }
            }
            connection.start()
            
        }
    }
}
