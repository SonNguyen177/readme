//
//  SecondViewController.swift
//  ReadMe
//
//  Created by Son Nguyen on 10/5/17.
//  Copyright © 2017 Son Nguyen. All rights reserved.
//

import UIKit
//import FacebookCore

class SecondViewController: UIViewController {
    
//    struct MyProfileRequest: GraphRequestProtocol {
//        struct Response: GraphResponseProtocol {
//            init(rawResponse: Any?) {
//                // Decode JSON from rawResponse into other properties here.
//            }
//        }
//
//        var graphPath = "/me"
//        var parameters: [String : Any]? = ["fields": "id, name"]
//        var accessToken = AccessToken.current
//        var httpMethod: GraphRequestHTTPMethod = .GET
//        var apiVersion: GraphAPIVersion = .defaultVersion
//    }
//
//
//    let connection = GraphRequestConnection()
//
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      

    }
    
    override func viewWillAppear(_ animated: Bool) {
//        connection.add(MyProfileRequest()) { response, result in
//            switch result {
//            case .success(let response):
//                //response.
//                print("Custom Graph Request Succeeded: \(response)")
//                // print("My facebook id is \(response?["id"])")
//            // print("My name is \(response.dictionaryValue?["name"])")
//            case .failed(let error):
//                print("Custom Graph Request Failed: \(error)")
//            }
//        }
//        connection.start()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

