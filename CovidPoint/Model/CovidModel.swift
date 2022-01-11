import Foundation
import UIKit


struct Country {
    var countryName: String
    var statusLabel: String
    var countryImage: String
    var infected: String
    var countPeople: String
    var infectedProgress: Double

    
    static func getCity() -> [Country] {
        let myArray = [Country(countryName: "США", statusLabel: "Подтвержденно", countryImage: "США", infected: "45 219 067", countPeople: "+86 759", infectedProgress: 0.90),
                       Country(countryName: "Индия", statusLabel: "Подтвержденно", countryImage: "Индия", infected: "34 127 450", countPeople: " ", infectedProgress: 0.80),
                       Country(countryName: "Бразилия", statusLabel: "Подтвержденно", countryImage: "Бразилия", infected: "21 680 488", countPeople: "+15 609", infectedProgress: 0.70),
                       Country(countryName: "Великобритания", statusLabel: "Подтвержденно", countryImage: "Великобритания", infected: "8 630 076", countPeople: "+48 798", infectedProgress: 0.60)
        ]
        
        return myArray
    }
}
