//
//  Extension.swift
//  ReadMe
//
//  Created by Son Nguyen on 12/22/17.
//  Copyright © 2017 Son Nguyen. All rights reserved.
//

import Foundation

public extension Date {
    static let DEFAULT_FORMAT = "yyyy-MM-dd'T'HH:mm:ssZ"
    public func toString(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
    public init?(string: String, format: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        //self.init()
        self = dateFormatter.date(from: string) ?? Date(timeIntervalSince1970: 0)
    }
    
    public static func from(string: String, format: String = Date.DEFAULT_FORMAT) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        let dateString = (string.count < 10 || string.contains("+0000")) ? string : string + "+0000"
        return dateFormatter.date(from: dateString)
    }
    
    public func getComponent(_ component: Calendar.Component) -> Int {
        return Calendar.current.component(component, from: self)
    }
    
    public func getComponents(_ components: [Calendar.Component]) -> [Int] {
        var retVal = [Int]()
        for component in components {
            retVal.append(Calendar.current.component(component, from: self))
        }
        return retVal
    }
    
    public func addYear(_ year: Int) -> Date {
        return Calendar.current.date(byAdding: .year, value: year, to: self)!
    }
}
