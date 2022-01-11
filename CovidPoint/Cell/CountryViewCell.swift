//
//  TableViewCell.swift
//  CovidPoint
//
//  Created by Servin Asanov on 10.01.2022.
//

import UIKit
import SnapKit

class CountryViewCell: UITableViewCell {

    lazy var containterView: UIView  = {
//        view.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 323, height: 198)
        self.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        
        
        self.contentView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.width.equalTo(323)
            make.height.equalTo(198)
            make.left.equalTo(self.contentView.snp.left).offset(26)
            
            make.top.equalTo(self.contentView.snp.topMargin).offset(0)
            make.bottom.equalTo(self.contentView.snp.bottomMargin).offset(0)

            make.right.equalTo(self.contentView.snp.right).offset(-26)
        }
        return view
    }()
    
    lazy var countryName: UILabel = {
        let label = UILabel()
        label.text = "USA"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        self.containterView.addSubview(label)

        label.snp.makeConstraints { make in
            make.left.equalTo(self.containterView.snp.left).offset(20)
            make.top.equalTo(self.containterView.snp.top).offset(30)
            make.bottom.equalTo(self.containterView.snp.bottom).offset(-139)

        }
        return label
    }()
    
    lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.text = "Подтвержденно"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1)
        label.numberOfLines = 0
        self.containterView.addSubview(label)

        label.snp.makeConstraints { make in
            make.top.equalTo(self.countryName.snp.bottom).offset(14)
            make.left.equalTo(self.containterView.snp.left).offset(20)
            make.bottom.equalTo(self.containterView.snp.bottom).offset(-108)
        }
        return label
    }()
    
    lazy var infectedPeople: UILabel = {
        let label = UILabel()
        label.text = "45"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = .black
        self.containterView.addSubview(label)

        label.snp.makeConstraints { make in
            make.top.equalTo(self.statusLabel.snp.bottom).offset(7)
            make.left.equalTo(self.containterView.snp.left).offset(20)
            make.right.equalTo(self.containterView.snp.right).offset(-174)
        }
        return label
    }()
    
    lazy var countryImage: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "usa")
        self.containterView.addSubview(view)
        
        view.snp.makeConstraints { make in
            make.width.equalTo(58)
            make.height.equalTo(58)
            make.top.equalTo(self.containterView.snp.topMargin).offset(15)
            make.right.equalTo(self.containterView.snp.right).offset(-20)
            make.bottom.equalTo(self.containterView.snp.bottom).offset(-125)
        }
        
        return view
    }()
    
    lazy var progressView: UIProgressView = {
        let line = UIProgressView()
        line.backgroundColor = .white
        line.trackTintColor = .lightGray
        line.progressTintColor = .darkGray
        
        
        let layer0 = CAGradientLayer()
        layer0.colors = [
          UIColor(red: 0.525, green: 0.525, blue: 0.525, alpha: 1).cgColor,
          UIColor(red: 0.28, green: 0.293, blue: 0.3, alpha: 1).cgColor ]
        layer0.locations = [0, 1]
        layer0.startPoint = CGPoint(x: 0.25, y: 0.5)
        layer0.endPoint = CGPoint(x: 0.75, y: 0.5)
        layer0.transform = CATransform3DMakeAffineTransform(CGAffineTransform(a: 0.54, b: 0, c: 0, d: 192.29, tx: -0.04, ty: -95.14))
        layer0.bounds = line.bounds.insetBy(dx: -0.5*line.bounds.size.width, dy: -0.5*line.bounds.size.height)
        layer0.position = line.center
        line.layer.addSublayer(layer0)
     
        
        self.containterView.addSubview(line)
        
        line.snp.makeConstraints { make in
            make.width.equalTo(283)
            make.height.equalTo(5)
            make.top.equalTo(self.containterView.snp.top).offset(134)
            make.left.equalTo(self.containterView.snp.left).offset(20)
            make.right.equalTo(self.containterView.snp.right).offset(-20)
            make.bottom.equalTo(self.containterView.snp.bottom).offset(-59)
        }
        
        return line
    }()
    
    lazy var aboutLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(red: 0.525, green: 0.525, blue: 0.525, alpha: 1)
        label.font = UIFont(name: "SFProDisplay-Medium", size: 14)
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.text = "Подробнее"
        self.containterView.addSubview(label)

        label.snp.makeConstraints { make in
            make.top.equalTo(self.progressView.snp.bottom).offset(23)
            make.bottom.equalTo(self.containterView.snp.bottom).offset(-19)
            make.right.equalTo(self.containterView.snp.right).offset(-44)
        }
        
        return label
    }()
    
    lazy var newInfected: UILabel = {
        let count = UILabel()
        count.textColor = UIColor(red: 0.525, green: 0.525, blue: 0.525, alpha: 1)
        count.font = .systemFont(ofSize: 16, weight: .bold)
        count.text = "+86 759"
        self.containterView.addSubview(count)
        
        count.snp.makeConstraints { make in
            make.right.equalTo(self.containterView.snp.right).offset(-20)
            make.top.equalTo(self.containterView.snp.top).offset(105)
            make.bottom.equalTo(self.containterView.snp.bottom).offset(-74)
        }
        
        return count
    }()
    
    lazy var vectorImage: UIImageView = {
        let vector = UIImageView()
        vector.image = UIImage(named: "Vector")
        self.containterView.addSubview(vector)
        
        vector.snp.makeConstraints { make in
            make.bottom.equalTo(self.containterView.snp.bottom).offset(-22)
            make.right.equalTo(self.containterView.snp.right).offset(-20)

        }
        
        return vector
    }()
    

    override func didMoveToSuperview() {
        _ = containterView
        _ = infectedPeople
        _ = countryImage
        _ = progressView
        _ = aboutLabel
        _ = newInfected
        _ = vectorImage
    }

    override func awakeFromNib() {
        super.awakeFromNib()

    }

}
