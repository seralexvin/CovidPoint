import Foundation
import MapKit

class CovidPointData: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: Int?
    
    let latitude: Double
    let longitude: Double
    
    init(title: String,
         latitude: Double,
         longitude: Double,
         numberOfInfected: Int){
        self.coordinate = CLLocationCoordinate2D(latitude: latitude,
                                                 longitude: longitude)
        self.latitude = latitude
        self.longitude = longitude
        self.title = title
        self.subtitle = numberOfInfected
    }
}



