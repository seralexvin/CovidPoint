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
    var countryImage: String
    var infected: String
    var countPeople: String
    
    static func getCity() -> [Country] {
        let myArray = [Country(countryName: "США", statusLabel: "Подтвержденно", countryImage: "США", infected: "45 219 067", countPeople: "+86 759"),
                       Country(countryName: "Индия", statusLabel: "Подтвержденно", countryImage: "Индия", infected: "34 127 450", countPeople: " "),
                       Country(countryName: "Бразилия", statusLabel: "Подтвержденно", countryImage: "Бразилия", infected: "21 680 488", countPeople: "+15 609"),
                       Country(countryName: "Великобритания", statusLabel: "Подтвержденно", countryImage: "Великобритания", infected: "8 630 076", countPeople: "+48 798")
        ]
        
        return myArray
    }
}
