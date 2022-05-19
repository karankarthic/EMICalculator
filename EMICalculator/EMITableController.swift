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


class EMIGridController:UIViewController{
    
    var data:EMITableChartValues = .init(values: [])
    
    private var width:[CGFloat] = []
    
    private lazy var tableScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = false
        scrollView.delegate = self
        return scrollView
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.isScrollEnabled = false
        tableView.clipsToBounds = false
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(EMITableCell.self, forCellReuseIdentifier: "EMITableCell")
        self.tableView.separatorStyle = .none
        
        self.view.backgroundColor = .white
        tableScrollView.addSubview(tableView)
        
        self.view.addSubview(tableScrollView)
        
        tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        
        
        NSLayoutConstraint.activate([
            tableScrollView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableScrollView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableScrollView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            tableScrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
            
        ])
        
    }

}

extension EMIGridController {
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        guard let tableViewObject = object as? UITableView else {
            return
        }
        
        if tableViewObject == self.tableView && keyPath == "contentSize"{
            
            var tableFrame = tableView.frame
            let screenWidth = UIScreen.main.bounds.width
            
            tableFrame.size.height = tableView.contentSize.height
            
            if width.isEmpty{
                
                tableFrame.size.width = screenWidth
                
            }else{
                
                if (width.max() ?? 0) > screenWidth {
                    
                    tableFrame.size.width = width.max() ?? 0
                    
                }
                
            }
            tableView.frame = tableFrame
            
            tableScrollView.contentSize = tableView.contentSize
        }
    }
}

extension EMIGridController : UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.values.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "EMITableCell") as? EMITableCell else{
            return UITableViewCell()}
        cell.configureCellValues(value: data.values[indexPath.row])
        if (indexPath.row % 2) != 0{
            cell.backgroundColor = .lightGray
        }else{
            cell.backgroundColor = .white
        }
        
        width.append(cell.returnSizeOfStack())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

}


