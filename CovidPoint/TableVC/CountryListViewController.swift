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
    var infectedModel = InfectedCovid.getInfected()
    var countModel = CountPeople.getCount()
    
    

    lazy var myView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        let width = UIScreen.main.bounds.width
        
        view.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.width.equalTo(width)
        }
        
        return view
    }()



    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        self.tableView.backgroundColor = UIColor(red: 0.898, green: 0.898, blue: 0.898, alpha: 1)
        self.tableView.register(CountryViewCell.self, forCellReuseIdentifier: "cellCovid")
        
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        
        self.tableView.tableHeaderView = myView
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellCovid", for: indexPath) as! CountryViewCell
    
        cell.countryName.text = model[indexPath.row].countryName
        cell.statusLabel.text = model[indexPath.row].statusLabel
        cell.countryImage.image = UIImage(named: model[indexPath.row].countryImage)
        
        cell.infectedPeople.text = infectedModel[indexPath.row].infected
        cell.newInfected.text = countModel[indexPath.row].countPeople
        
        return cell
    }

}

