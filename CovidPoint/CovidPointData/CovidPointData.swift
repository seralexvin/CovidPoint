import Foundation

struct CovidPointData {
    let name: String
    let latitude: Double
    let longitude: Double
    let numberOfInfected: Int
    
    init(name: String,
         latitude: Double,
         longitude: Double,
         numberOfInfected: Int){
        self.name = name
        self.latitude = latitude
        self.longitude = longitude
        self.numberOfInfected = numberOfInfected
    }
}
