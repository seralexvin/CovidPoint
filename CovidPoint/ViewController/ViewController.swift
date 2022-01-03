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
    
    //@IBOutlet private var mapView: MKMapView!
    let mapView = MKMapView()
    let dataCity = CovidPointViewModel().dataCovidPointCity
    
    let startPoint = CovidPointData(title: "Simferopol",
                                    latitude: 44.948237,
                                    longitude: 34.100327,
                                    numberOfInfected: 886)
    
    let zoomView = UIView()
    let zoomPlus = UIButton()
    let zoomMinus = UIButton()
    
    let geolocationCircle = UIView()
    
    var scale : CLLocationDistance = 100000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        CreateMap()
        ZoomButton()
        geolocationButton()
        
        //        let centerPointCircle = CLLocationCoordinate2DMake(self.startPoint.latitude, self.startPoint.longitude)
        //        showCircle(coordinate: centerPointCircle, radius: scale)
        //
        let initialLocation = CLLocation(latitude: self.startPoint.latitude,
                                         longitude: self.startPoint.longitude)
        mapView.centerToLocation(initialLocation, regionRadius: scale)
        
        for i in dataCity {
            mapView.addAnnotation(i)
        }
        
        //        mapView.addAnnotation(<#T##annotation: MKAnnotation##MKAnnotation#>)
        //        mapView.addAnnotation(
    }
    
    
    
    func CreateMap(){
        self.view.addSubview(mapView)
        mapView.delegate = self
        self.mapView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(-50)
            make.bottom.equalToSuperview().offset(55)
            make.left.right.equalToSuperview().offset(0)
        }
    }
    
    
    
    func ZoomButton(){
        self.mapView.addSubview(zoomView)
        self.zoomView.backgroundColor = .white
        self.zoomView.layer.cornerRadius = 6
        
        self.zoomView.snp.makeConstraints { make in
            make.height.equalTo(81)
            make.width.equalTo(40)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
        }
        
        self.zoomView.addSubview(zoomPlus)
        self.zoomPlus.backgroundColor = .white
        self.zoomPlus.layer.cornerRadius = 6
        self.zoomPlus.tag = 1
        
        self.zoomPlus.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.left.equalTo(zoomView).offset(0)
        }
        
        let plus1 = UIView()
        self.zoomPlus.addSubview(plus1)
        plus1.backgroundColor = .gray
        
        plus1.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(15)
            make.center.equalTo(zoomPlus)
        }
        
        let plus2 = UIView()
        self.zoomPlus.addSubview(plus2)
        plus2.backgroundColor = .gray
        
        plus2.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.width.equalTo(3)
            make.center.equalTo(zoomPlus)
        }
        
        self.zoomPlus.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        
        self.zoomView.addSubview(zoomMinus)
        self.zoomMinus.backgroundColor = .white
        self.zoomMinus.layer.cornerRadius = 6
        self.zoomMinus.tag = 2
        
        self.zoomMinus.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.bottom.left.equalTo(zoomView).offset(0)
        }
        
        let minus = UIView()
        self.zoomMinus.addSubview(minus)
        minus.backgroundColor = .gray
        
        minus.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(15)
            make.center.equalTo(zoomMinus)
        }
        
        self.zoomMinus.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        let partition = UIView()
        self.zoomView.addSubview(partition)
        partition.backgroundColor = .systemGray6
        
        partition.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.width.equalTo(30)
            make.center.equalTo(zoomView)
        }
    }
    
    
    
    func geolocationButton() {
        self.mapView.addSubview(geolocationCircle)
        self.geolocationCircle.backgroundColor = .white
        self.geolocationCircle.layer.cornerRadius = 45/2
        self.geolocationCircle.snp.makeConstraints { make in
            make.size.equalTo(45)
            make.bottom.equalToSuperview().offset(-90)
            make.right.equalToSuperview().offset(-15)
        }
        
        let geolocationPointer = UIImageView(image: UIImage(named: "geolocationPointer"))
        self.geolocationCircle.addSubview(geolocationPointer)
        geolocationPointer.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.left.equalToSuperview().offset(11.5)
            make.top.equalToSuperview().offset(13.5)
        }
        
    }
    
    
    
    func showCircle(coordinate: CLLocationCoordinate2D,
                    radius: CLLocationDistance){
        let circle = MKCircle(center: coordinate, radius: radius / 10)
        mapView.addOverlay(circle)
    }
    
    @objc func buttonAction(sender: UIButton!) {
        
        //        let centerPointCircle = CLLocationCoordinate2DMake(self.startPoint.latitude, self.startPoint.longitude)
        //        showCircle(coordinate: centerPointCircle, radius: scale)
        //
        //        let initialLocation = CLLocation(latitude: self.startPoint.latitude,
        //                                         longitude: self.startPoint.longitude)
        //        mapView.centerToLocation(initialLocation, regionRadius: scale)
        //
        let btnsendertag: UIButton = sender
        switch btnsendertag.tag{
        case 1:
            var region: MKCoordinateRegion = mapView.region
            region.span.latitudeDelta /= 2.0
            region.span.longitudeDelta /= 2.0
            mapView.setRegion(region, animated: true)
            self.scale = self.scale / 2.0
            print(self.scale)
            
        case 2:
            var region: MKCoordinateRegion = mapView.region
            region.span.latitudeDelta = min(region.span.latitudeDelta * 2.0, 180.0)
            region.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
            mapView.setRegion(region, animated: true)
            self.scale = self.scale * 2.0
            print(self.scale)
            
        default:
            print("")
        }
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

