//
//  TableViewCell.swift
//  CovidPoint
//
//  Created by Servin Asanov on 28.12.2021.
//

import UIKit
import SnapKit

class CountryViewCell: UITableViewCell {

    lazy var containterView: UIView  = {
//        let view = UIView(frame: .zero)
//        view.translatesAutoresizingMaskIntoConstraints = false
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 323, height: 198)
        self.contentView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        view.backgroundColor = .white
        view.addShadow(color: .darkGray)
        view.cornerRadius(radius: 20)
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
        line.cornerRadius(radius: 1)
        line.trackTintColor = .lightGray
        line.progressTintColor = .darkGray
        
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
