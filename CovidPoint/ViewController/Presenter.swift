//
//  Presenter.swift
//  CovidPoint
//
//  Created by Vladislav on 03.01.2022.
//

import UIKit

class Presenter: NSObject {
    
    let zoomView = UIView()
    let zoomPlus = UIButton()
    let zoomMinus = UIButton()
    
    func ZoomButton(){
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
    }
}
