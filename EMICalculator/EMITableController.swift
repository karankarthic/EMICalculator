//
//  EMITableController.swift
//  EMICalculator
//
//  Created by Karan Karthic Neelamegan on 16/05/22.
//

import UIKit

class EMITableController:UITableViewController {
    
    var data:EMITableChartValues = .init(values: [])
    
    override init(style: UITableView.Style) {
        super.init(style: .plain)
        self.tableView.register(EMITableCell.self, forCellReuseIdentifier: "EMITableCell")
        self.tableView.separatorStyle = .none
    
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension EMITableController{
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.values.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EMITableCell") as? EMITableCell else{return UITableViewCell()}
        cell.configureCellValues(value: data.values[indexPath.row])
        
        if (indexPath.row % 2) != 0{
            cell.backgroundColor = .lightGray
        }else{
            cell.backgroundColor = .white
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}
