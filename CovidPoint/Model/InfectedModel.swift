//
//  InfectedModel.swift
//  CovidPoint
//
//  Created by Servin Asanov on 02.01.2022.
//

import Foundation
import UIKit

struct InfectedCovid {
    var infected: String
    
    static var countPeople = ["45 219 067", "34 127 450", "21 680 488", "8 630 076"]
    
    static func getInfected() -> [InfectedCovid] {
        var places = [InfectedCovid]()
        
        for element in countPeople {
            places.append(InfectedCovid(infected: element))
        }
        
        return places
    }
}
