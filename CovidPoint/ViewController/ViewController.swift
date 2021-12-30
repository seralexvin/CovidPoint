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
    
    let zoomView = UIView()
    let zoomPlus = UIButton()
    let zoomMinus = UIButton()
    
    var scale : CLLocationDistance = 100000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.delegate = self
        
        
        self.view.addSubview(zoomView)
        self.zoomView.backgroundColor = .white
        self.zoomView.layer.cornerRadius = 5
        
        self.zoomView.snp.makeConstraints { make in
            make.height.equalTo(81)
            make.width.equalTo(40)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
        self.zoomView.addSubview(zoomPlus)
        self.zoomPlus.backgroundColor = .white
        self.zoomPlus.layer.cornerRadius = 5
//        self.zoomPlus.setTitle("+", for: .normal)
//        self.zoomPlus.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 30.0)
//        self.zoomPlus.setTitleColor(.gray, for: .normal)
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
        self.zoomMinus.layer.cornerRadius = 5
//        self.zoomMinus.setTitle("-", for: .normal)
//        self.zoomMinus.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 30.0)
//        self.zoomMinus.setTitleColor(.gray, for: .normal)
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
    
    @objc func buttonAction(sender: UIButton!) {
        let btnsendertag: UIButton = sender
        switch btnsendertag.tag{
            case 1:
                var region: MKCoordinateRegion = mapView.region
                region.span.latitudeDelta /= 2.0
                region.span.longitudeDelta /= 2.0
                mapView.setRegion(region, animated: true)
            
            case 2:
                var region: MKCoordinateRegion = mapView.region
            region.span.latitudeDelta = min(region.span.latitudeDelta * 2.0, 180.0)
                region.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
                mapView.setRegion(region, animated: true)
            
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

