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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        self.tableView.register(CountryViewCell.self, forCellReuseIdentifier: "cellCovid")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
    }
    
    


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCovid", for: indexPath) as! CountryViewCell
    
        cell.countryName.text = model[indexPath.row].countryName
        cell.statusLabel.text = model[indexPath.row].statusLabel
        cell.countryImage.image = UIImage(named: model[indexPath.row].countryImage)
        
        return cell
    }
    
}

