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
    
    let mapView = MKMapView()
    
    let city = CovidPointViewModel().dataCovidPointCity
    let country = CovidPointViewModel().dataCovidPointState
    
    var dataCity : [CovidPointData]!
    var dataCountry : [CovidPointData]!
    
    let segmentControlView = UIView()
    let conteiner = UIView()
    
    let startPoint = CovidPointData(title: "Simferopol",
                                    latitude: 44.948237,
                                    longitude: 34.100327,
                                    numberOfInfected: 886)
    
    let zoomView = UIView()
    let zoomPlus = UIButton()
    let zoomMinus = UIButton()
    
    let geolocationCircle = UIView()
    
    let table = UIView()
    
    let segmentControl = UISegmentedControl(items: ["Map", "Table"])
    
    var scale : CLLocationDistance = 4
    
    
    
    override func viewDidLoad() {
//        super.viewWillAppear(true)
        super.viewDidLoad()
        
        self.view.addSubview(segmentControlView)
        self.segmentControlView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }

        self.segmentControlView.addSubview(conteiner)
        self.conteiner.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
        
        dataCity = city
        
        createMap()
        createSegmentControl()

        self.conteiner.addSubview(table)
        self.table.backgroundColor = .white
        self.table.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
        self.table.isHidden = true

        

        let initialLocation = CLLocation(latitude: self.startPoint.latitude,
                                         longitude: self.startPoint.longitude)
        
        // Center to Location -> Start Point
        self.mapView.setRegion(MKCoordinateRegion(center: initialLocation.coordinate,
                                                  span: MKCoordinateSpan(latitudeDelta: 4,
                                                                         longitudeDelta: 4)),
                               animated: true)

        cityAnnotation()
        
        
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        circleGradient()
    }
    
    
    
    func circleGradient(){
        
        let circleGrad = UIView()
        self.view.addSubview(circleGrad)
//        circleGrad.backgroundColor = .black
        circleGrad.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.center.equalToSuperview()
        }
        
        
        let gradient: CAGradientLayer = {
            let gradient = CAGradientLayer()
            gradient.type = .radial
            gradient.colors = [
                UIColor.purple.cgColor,
                UIColor.blue.cgColor
            ]
            gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
//            let endY = 0.5 + circleGrad.frame.size.width / circleGrad.frame.size.height / 2
            gradient.endPoint = CGPoint(x: 1, y: 1)
            gradient.cornerRadius = 25
            return gradient
        }()
        
//
        
        
        gradient.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        circleGrad.layer.addSublayer(gradient)
        //circleGrad.layer.cornerRadius = 25
        
//        circleGrad.layer.addSublayer(gradient)
//            circleGrad.layer.insertSublayer(gradient, at: 0)
        
    }
    
    
    
    func createMap(){
        self.conteiner.addSubview(mapView)
        mapView.delegate = self
        self.mapView.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
        }
        mapView.showsScale = true
        zoomButton()
        geolocationButton()
    }
    
    
    func createSegmentControl(){
        self.segmentControlView.addSubview(segmentControl)
        self.segmentControl.backgroundColor = .white
        self.segmentControl.snp.makeConstraints { make in
            make.height.equalTo(38)
            make.width.equalTo(200)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(65)
        }
        self.segmentControl.selectedSegmentIndex = 0
        self.segmentControl.addTarget(self, action: #selector(segmentControlAction(_:)), for: .valueChanged)
        self.segmentControl.addTarget(self, action: #selector(segmentControlAction(_:)), for: .touchUpInside)


    }
    
    @objc func segmentControlAction(_ sender: UISegmentedControl!){
        switch sender.selectedSegmentIndex{
            case 0:
            cityAnnotation()
            self.conteiner.sendSubviewToBack(self.table)
            mapView.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.right.equalTo(self.conteiner.snp.left)
            }
            
            UIView.performWithoutAnimation {
                self.conteiner.layoutIfNeeded()
            }
            
            mapView.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            UIView.animate(withDuration: 0.2) {
                self.conteiner.layoutIfNeeded()
            } completion: { _ in
                
                self.table.isHidden = true
            }
            
            mapView.isHidden = false
            
            case 1:
            mapView.removeAnnotations(mapView.annotations)
            self.conteiner.sendSubviewToBack(self.mapView)
            table.snp.remakeConstraints { make in
                make.top.bottom.equalToSuperview()
                make.left.equalTo(self.conteiner.snp.right)
            }
            
            UIView.performWithoutAnimation {
                self.conteiner.layoutIfNeeded()
            }
            
            table.snp.remakeConstraints { make in
                make.edges.equalToSuperview()
            }
            
            UIView.animate(withDuration: 0.2) {
                self.conteiner.layoutIfNeeded()
            } completion: { _ in
                self.mapView.isHidden = true
            }
            
            table.isHidden = false
            default:
                break
        }
    }
    
    func zoomButton(){
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
        plus1.isUserInteractionEnabled = false
        plus1.snp.makeConstraints { make in
            make.height.equalTo(3)
            make.width.equalTo(15)
            make.center.equalTo(zoomPlus)
        }
        
        let plus2 = UIView()
        self.zoomPlus.addSubview(plus2)
        plus2.backgroundColor = .gray
        plus2.isUserInteractionEnabled = false
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
        minus.isUserInteractionEnabled = false
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
            make.bottom.equalToSuperview().offset(-70)
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
    
    
    
    func cityAnnotation(){
        for i in dataCity {
            mapView.addAnnotation(i)
        }
    }
    
    
    
    func stateAnnotation(){
        for i in dataCountry {
            mapView.addAnnotation(i)
        }
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
            if scale > 0.005{
                self.scale = self.scale / 2.0
            }
            print(self.scale)
            
        case 2:
            var region: MKCoordinateRegion = mapView.region
            region.span.latitudeDelta = min(region.span.latitudeDelta * 2.0, 180.0)
            region.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
            mapView.setRegion(region, animated: true)
            if scale > 0.005{
                self.scale = self.scale * 2.0
            }
            print(self.scale)
            
        default:
            break
        }
    }
    
}


//
//private extension MKMapView {
//    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
//        let coordinateRegion = MKCoordinateRegion(
//            center: location.coordinate,
//            latitudinalMeters: regionRadius,
//            longitudinalMeters: regionRadius)
//        setRegion(coordinateRegion, animated: true)
//    }
//}



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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        
        if annotationView == nil {
            //
            annotationView = MKAnnotationView(annotation: annotation,
                                              reuseIdentifier: "custom")
            annotationView?.canShowCallout = true
            
        }
        else {
            annotationView?.annotation = annotation
        }
        
        annotationView?.image = UIImage(named: "point")
        annotationView?.snp.makeConstraints({ make in
            make.size.equalTo(50)
        })
        
        let statistic = UIView()
        statistic.backgroundColor = .green
        statistic.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(100)
        }
        annotationView?.detailCalloutAccessoryView = statistic
        
        return annotationView
    }
    
    
}

