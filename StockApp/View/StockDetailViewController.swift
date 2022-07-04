//
//  StockDetailViewController.swift
//  StockApp
//
//  Created by Luka on 30.06.2022..
//

import UIKit
import SnapKit

class StockDetailViewController: UIViewController {
    
    var stockInfo : MetaData?
    var stockrecords: [String: TimeSeriesDaily]?
    var companyTitle: String?
    var picture: String?
    var sortedStocks : [SortedStocks] = []
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StockDetailTableViewCell.self, forCellReuseIdentifier: "StockDetailTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sortStocks()
        configureUI()
    }
    
    func setValues(stockInfo: MetaData, stockRecods: [String: TimeSeriesDaily], companyTitle: String, picture: String){
        self.stockInfo = stockInfo
        self.stockrecords = stockRecods
        self.companyTitle = companyTitle
        self.picture = picture
    }
    
    func sortStocks(){
        guard let stockrecords = stockrecords else {
            return
        }
        for data in stockrecords{
            sortedStocks.append(SortedStocks(high: data.value.high, low: data.value.low, date: data.key))
        }
        sortedStocks = sortedStocks.sorted(by: { $0.date > $1.date})
    }
    
    func configureUI(){
        view.backgroundColor = .white
        guard let picture = picture else {
            return
        }
        let img = UIImage(named: picture)
        let imgView = UIImageView(image: img)
        view.addSubview(imgView)
        imgView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.centerX.equalToSuperview()
            $0.width.height.equalTo(160)
        }
        
        let titleLabel = UILabel()
        titleLabel.text = companyTitle
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30)
        titleLabel.textColor = .black
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(imgView.snp.bottom).offset(20)
        }
        
        let lastRfrshLabel = UILabel()
        guard let stockInfo = stockInfo else {
            return
        }
        lastRfrshLabel.text = "Last refreshed: \(stockInfo.lastRefreshed.convertToDisplayFormat())"
        lastRfrshLabel.font = UIFont(name: "Arial", size: 15)
        lastRfrshLabel.textColor = .gray
        view.addSubview(lastRfrshLabel)
        lastRfrshLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(lastRfrshLabel).offset(20)
            $0.width.equalToSuperview()
            $0.height.equalTo(500)
        }
    }
}

extension StockDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sortedStocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockDetailTableViewCell") as? StockDetailTableViewCell else{
            return UITableViewCell()
        }
        cell.setValues(date: sortedStocks[indexPath.row].date, high: sortedStocks[indexPath.row].high, low: sortedStocks[indexPath.row].low)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
}
