//
//  ViewController.swift
//  c
//
//  Created by Servin Asanov on 10.01.2022.
//

import UIKit
import SnapKit

class CountryListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var model = Country.getCity()
    var progressModel = ProgressCountry.myProgress()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupView()
        setupSegmentedControl()
    }
    
    func setupView() {
        self.view.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
    }
    
    func setupSegmentedControl() {
        let segmentedC = UISegmentedControl(items: ["1", "2"])
        segmentedC.setImage(UIImage(named: "1"), forSegmentAt: 0)
        segmentedC.setImage(UIImage(named: "2"), forSegmentAt: 1)
        segmentedC.selectedSegmentIndex = 1
        segmentedC.backgroundColor = UIColor(red: 0.925, green: 0.925, blue: 0.925, alpha: 1)
        view.addSubview(segmentedC)
        
        segmentedC.translatesAutoresizingMaskIntoConstraints = false
        
        segmentedC.snp.makeConstraints { make in
            make.width.equalTo(200)
            make.height.equalTo(38)
            make.left.equalTo(self.view.snp.left).offset(88)
            make.right.equalTo(self.view.snp.right).offset(-87)
            make.top.equalTo(self.view.snp.topMargin).offset(38)
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
    
    func setupTableView() {
        let tableV = UITableView()
        
        tableV.register(CellCountry.self, forCellReuseIdentifier: "CountryCell")
        tableV.dataSource = self
        tableV.delegate = self
        
        tableV.separatorStyle = .none
        tableV.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        
        view.addSubview(tableV)
        
        tableV.translatesAutoresizingMaskIntoConstraints = false
        
        tableV.snp.makeConstraints { make in
            make.left.equalTo(self.view.snp.left)
            make.right.equalTo(self.view.snp.right)
            make.bottom.equalTo(self.view.snp.bottomMargin)
            make.top.equalTo(self.view.snp.topMargin).offset(126)
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryCell", for: indexPath) as! CellCountry
        
        cell.countryName.text = model[indexPath.row].countryName
        cell.statusLabel.text = model[indexPath.row].statusLabel
        cell.countryImage.image = UIImage(named: model[indexPath.row].countryImage)
        cell.infectedPeople.text = model[indexPath.row].infected
        cell.newInfected.text = model[indexPath.row].countPeople
        
        cell.progressView.setProgress(Float(model[indexPath.row].infectedProgress), animated: false)
        
        return cell
    }
    
}

