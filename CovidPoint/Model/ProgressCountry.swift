//
//  ProgressCountry.swift
//  CovidPoint
//
//  Created by Servin Asanov on 10.01.2022.
//

import Foundation
import UIKit


struct ProgressCountry {
    var infectedProgress: Double
    
    static func myProgress() -> [ProgressCountry] {
        let arrayProgress = [ProgressCountry(infectedProgress: 0.90),
                             ProgressCountry(infectedProgress: 0.80),
                             ProgressCountry(infectedProgress: 0.70),
                             ProgressCountry(infectedProgress: 0.60)]
        
        return arrayProgress
    }
}
