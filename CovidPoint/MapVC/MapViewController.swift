//
//  MapViewController.swift
//  NewTable
//
//  Created by Servin Asanov on 10.01.2022.
//

import UIKit
import MapKit
import CoreLocation
import SnapKit

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
   
    var locationManager: CLLocationManager = CLLocationManager()
    lazy var mapView = MKMapView()
    lazy var segmentedC = UISegmentedControl(items: ["1", "2"])
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupMapView()
        setupPin()
        setupSegmentedControl()
        
    }

    func setupMapView() {
        self.view.addSubview(mapView)
        mapView.snp.makeConstraints { make in
            make.top.equalTo(self.view.snp.top)
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottom)
        }
    }

    func setupPin() {
        let coordinate = CLLocationCoordinate2D(latitude: 44.9571900, longitude: 34.1107900)
        let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: true)
        
        let pin1 = MKPointAnnotation()
        pin1.coordinate = CLLocationCoordinate2D(latitude: 44.9571900, longitude: 34.1107900)
        pin1.title = "You"
        pin1.subtitle = "there"
        
        let pin2 = MKPointAnnotation()
        pin2.coordinate = CLLocationCoordinate2D(latitude: 44.9571900, longitude: 34.10)
        pin2.title = "20 000"
        
        let pin3 = MKPointAnnotation()
        pin3.coordinate = CLLocationCoordinate2D(latitude: 44.9571900, longitude: 34.12)
        pin3.title = "10 000"

        self.mapView.addAnnotations([pin1, pin2, pin3])

    }
    
    func setupSegmentedControl() {
        segmentedC.setImage(UIImage(named: "1"), forSegmentAt: 0)
        segmentedC.setImage(UIImage(named: "2"), forSegmentAt: 1)
        segmentedC.selectedSegmentIndex = 0

        segmentedC.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        mapView.addSubview(segmentedC)
        
        segmentedC.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedC.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(38)
            make.left.equalTo(self.mapView.snp.left).offset(88)
            make.right.equalTo(self.mapView.snp.right).offset(-87)
            make.top.equalTo(self.mapView.snp.topMargin).offset(38)
        }
        
        segmentedC.addTarget(self, action: #selector(mapVCChange(_:)), for: .valueChanged)
    }
    
    @objc func mapVCChange(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            let mapVC = MapViewController()
            
            mapVC.modalPresentationStyle = .fullScreen
            present(mapVC, animated: false, completion: nil)
        case 1:
            let vc = CountryListViewController()
            
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: false, completion: nil)
        default:
            print("error")
        }
    }
}


