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
    
    let dataCity = CovidPointViewModel().dataCovidPointCity
    let dataCountry = CovidPointViewModel().dataCovidPointCountry
    
    let segmentControlView = UIView()
    let conteiner = UIView()
    
    let startPoint = CovidPointData(title: "Moscow",
                                    latitude: 55.755819,
                                    longitude: 37.617644,
                                    numberOfInfected: "2055824")
    
    let zoomView = UIView()
    let zoomPlus = UIButton()
    let zoomMinus = UIButton()
    
    let geolocationCircle = UIView()
    
    let table = UIView()
    
    let segmentControl = UISegmentedControl(items: ["Map", "Table"])
    
    var scale = CLLocationDistance()
    
    
    
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
                                                  span: MKCoordinateSpan(latitudeDelta: 8,
                                                                         longitudeDelta: 8)),
                               animated: true)
        
        cityAnnotation()
    }
    
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
    
    func circleGradient(){
        
        let circleGrad = UIView()
        self.view.addSubview(circleGrad)
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
            gradient.endPoint = CGPoint(x: 1, y: 1)
            gradient.cornerRadius = 25
            return gradient
        }()
        
        gradient.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        circleGrad.layer.addSublayer(gradient)
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
            if (scale > 10){
                self.mapView.removeAnnotations(self.mapView.annotations)
                cityAnnotation()
            }
            else if (scale < 10){
                self.mapView.removeAnnotations(self.mapView.annotations)
                countryAnnotation()
            }
            let region: MKCoordinateRegion = mapView.region
            mapView.setRegion(region, animated: false)
            
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
    
    
    
    func cityAnnotation(){
        for i in dataCity {
            mapView.addAnnotation(i)
        }
    }
    
    
    
    func countryAnnotation(){
        for i in dataCountry {
            mapView.addAnnotation(i)
        }
    }
    
    
    
    @objc func buttonAction(sender: UIButton!) {
        let btnsendertag: UIButton = sender
        self.scale = self.mapView.region.span.longitudeDelta
        switch btnsendertag.tag{
        case 1:
            var region: MKCoordinateRegion = mapView.region
            region.span.latitudeDelta /= 2.0
            region.span.longitudeDelta /= 2.0
            mapView.setRegion(region, animated: true)
            if (scale > 10) && ((scale / 2.0) < 10){
                self.mapView.removeAnnotations(self.mapView.annotations)
                cityAnnotation()
            }
            print(self.scale)
            print(self.mapView.region)
            
        case 2:
            var region: MKCoordinateRegion = mapView.region
            region.span.latitudeDelta = min(region.span.latitudeDelta * 2.0, 180.0)
            region.span.longitudeDelta = min(region.span.longitudeDelta * 2.0, 180.0)
            mapView.setRegion(region, animated: true)
            if (scale < 10) && ((scale * 2.0) > 10) {
                self.mapView.removeAnnotations(self.mapView.annotations)
                countryAnnotation()
            }
            
            print(self.scale)
            
            
        default:
            break
        }
        
        //        if (scale > 10) && ((scale / 2.0) < 10){
        //            self.mapView.removeAnnotations(self.mapView.annotations)
        //            cityAnnotation()
        //        }
        //        else if (scale < 10) && ((scale * 2.0) > 10){
        //            self.mapView.removeAnnotations(self.mapView.annotations)
        //            countryAnnotation()
        //        }
        print(self.mapView.region.span.longitudeDelta)
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
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard !(annotation is MKUserLocation) else {
            return nil
        }
        var annotationView = self.mapView.dequeueReusableAnnotationView(withIdentifier: "custom")
        
        
        if annotationView == nil {
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
        
        let stat = UILabel()
        stat.font = UIFont(name: "Helvetica", size: 14)
        
        let font = UIFont(name: "Helvetica", size: 17)
        var fontAttributes = [NSAttributedString.Key.font: font]
        //        let myText = annotation.subtitle!!
        var myText = annotation.title!!
        let sizeTitle = (myText as NSString).size(withAttributes: fontAttributes)
        //print(sizeLable.width)
        
        fontAttributes = [NSAttributedString.Key.font: stat.font]
        myText = annotation.subtitle!!
        let sizeSubtitle = (myText as NSString).size(withAttributes: fontAttributes)
        
        var sizeLable = sizeSubtitle
        var sizeLableLow = sizeTitle
        
        if sizeTitle.width > sizeSubtitle.width {
            sizeLable = sizeTitle
            sizeLableLow = sizeSubtitle
        }
        
        
        
        let statistic = UIView()
//        statistic.backgroundColor = .green
        statistic.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalTo(sizeLable.width)
        }
        
        let centerLable = UIView()
        statistic.addSubview(centerLable)
//        centerLable.backgroundColor = .red
        centerLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(-10)
            
        }
        
        let line = UIView()
        statistic.addSubview(line)
        line.backgroundColor = .systemGray
        
        line.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.left.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(-13)
        }
        
        centerLable.addSubview(stat)
        stat.text = annotation.subtitle!!
//        stat.text = annotation.title!!
        stat.snp.makeConstraints { make in
            make.edges.equalToSuperview().offset(0)
            make.centerX.equalToSuperview()
            
        }
        
        annotationView?.detailCalloutAccessoryView = statistic
        
        return annotationView
    }
    
    
}
//
//extension UIImage{
//    convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)){
//        let rect = CGRect(origin: .zero, size: size)
//        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
//        color.setFill()
//        let circleRed = UIView()
//        
//        UIRectFill(rect)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        
//        guard let cgImage = image?.cgImage else { return nil }
//        self.init(cgImage: cgImage)
//    }
//}
