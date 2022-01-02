//
//  CountPeople.swift
//  CovidPoint
//
//  Created by Servin Asanov on 02.01.2022.
//

import Foundation
import UIKit

struct CountPeople {
    var countPeople: String
    
    static var count = ["+86 759", " ", "+15 609", "+48 798"]
    
    static func getCount() -> [CountPeople] {
        var places = [CountPeople]()
        
        for element in count {
            places.append(CountPeople(countPeople: element))
        }
        
        return places
    }
}
