//
//  TableViewController.swift
//  CovidPoint
//
//  Created by Servin Asanov on 28.12.2021.
//

import UIKit
import SnapKit

class CountryListViewController: UITableViewController {
        
    var model = Country.getCity()
    var progressModel = ProgressCountry.myProgress()
    var myView = UISegmentedControl()
    
    
    lazy var frame: UISegmentedControl = {
        let frame = UISegmentedControl(items: ["1", "2"])
        frame.setImage(UIImage(named: "1"), forSegmentAt: 0)
        frame.setImage(UIImage(named: "2"), forSegmentAt: 1)
        frame.selectedSegmentIndex = 0
        frame.tintColor = .gray
        frame.layer.borderColor = UIColor.red.cgColor
        
        return frame
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        self.tableView.register(CountryViewCell.self, forCellReuseIdentifier: "cellCovid")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.tableView.tableHeaderView = frame
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCovid", for: indexPath) as! CountryViewCell

        cell.countryName.text = model[indexPath.row].countryName
        cell.statusLabel.text = model[indexPath.row].statusLabel
        cell.countryImage.image = UIImage(named: model[indexPath.row].countryImage)
        cell.infectedPeople.text = model[indexPath.row].infected
        cell.newInfected.text = model[indexPath.row].countPeople
        
        cell.progressView.setProgress(Float(progressModel[indexPath.row].infectedProgress), animated: false)
            
        return cell
    }
}

