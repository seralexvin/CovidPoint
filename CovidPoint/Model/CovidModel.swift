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
         var myArray = [Country]()
         
         let placeOne = Country(countryName: "США", statusLabel: "Подтвержденно", countryImage: "США", infected: "45 219 067", countPeople: "+86 759")
         let placeTwo = Country(countryName: "Индия", statusLabel: "Подтвержденно", countryImage: "Индия", infected: "34 127 450", countPeople: " ")
         let placeThree = Country(countryName: "Бразилия", statusLabel: "Подтвержденно", countryImage: "Бразилия", infected: "21 680 488", countPeople: "+15 609")
         let placeFour = Country(countryName: "Великобритания", statusLabel: "Подтвержденно", countryImage: "Великобритания", infected: "8 630 076", countPeople: "+48 798")

         myArray.append(placeOne)
         myArray.append(placeTwo)
         myArray.append(placeThree)
         myArray.append(placeFour)

         return myArray
     }
 }




/*
struct Country {
    var countryName: String
    var statusLabel: String
    var countryImage: String

    static var point = ["США", "Индия", "Бразилия", "Великобритания"]
    
    static func getCity() -> [Country] {
        var places = [Country]()
        
        for element in point {
            places.append(Country(countryName: element, statusLabel: "Подтвержденно", countryImage: element))
        }
        return places
    }
}
 */

