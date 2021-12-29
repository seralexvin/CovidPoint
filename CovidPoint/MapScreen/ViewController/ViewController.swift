//
//  ViewController.swift
//  CovidPoint
//
//  Created by Vladislav on 28.12.2021.
//

import UIKit
import SnapKit
import MapKit

class ViewController: UIViewController {
    
    @IBOutlet private var mapView: MKMapView!
    let data = CovidPointViewModel()
    let startPoint = CovidPointData(name: "Simferopol",
                                    latitude: 44.948237,
                                    longitude: 34.100327,
                                    numberOfInfected: 886)
    
    var scale : CLLocationDistance = 100000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        
        let centerPointCircle = CLLocationCoordinate2DMake(self.data.dataCovidPoint[0].latitude, self.data.dataCovidPoint[0].longitude)
        showCircle(coordinate: centerPointCircle, radius: 200)
        
        let initialLocation = CLLocation(latitude: self.startPoint.latitude,
                                         longitude: self.startPoint.longitude)
        mapView.centerToLocation(initialLocation, regionRadius: scale)
        
        
        
    }
    
    func showCircle(coordinate: CLLocationCoordinate2D,
                    radius: CLLocationDistance){
        let circle = MKCircle(center: coordinate, radius: radius)
        mapView.addOverlay(circle)
    }
    
}

private extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

extension ViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer{
        if let circleOverlay = overlay as? MKCircle{
            let circleRender = MKCircleRenderer(overlay: circleOverlay)
            circleRender.fillColor = .black
            circleRender.alpha = 0.5
            
            return circleRender
        }
        return MKOverlayRenderer()
    }
}

