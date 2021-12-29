//
//  CovidModel.swift
//  CovidPoint
//
//  Created by Servin Asanov on 28.12.2021.
//

import Foundation
import UIKit


struct Country {
    var countryName: String
    var statusLabel: String
//    var infectedPeople: String
    var countryImage: String

    static var point = ["США", "Индия", "Бразилия", "Великобритания"]
    
    static func getCity() -> [Country] {
        var places = [Country]()
//        var infected = ["45 219 067", "34 127 450", "21 680 488", "8 630 076"]
//        var image = ["usa", "india", "brasil", "greatBritain"]
        
        for element in point {
            places.append(Country(countryName: element, statusLabel: "Подтвержденно", countryImage: element))
            
        }
        return places

    }

}
