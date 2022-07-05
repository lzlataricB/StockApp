//
//  StocksViewController.swift
//  StockApp
//
//  Created by Luka on 28.06.2022..
//

import UIKit
import SnapKit
import KeychainSwift


class StocksViewController: UIViewController {
    
    let keychain = KeychainSwift()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(StocksTableViewCell.self, forCellReuseIdentifier: "StockTableViewCell")
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.setHidesBackButton(true, animated: true)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(logOut))
        configureUI()
    }
    
    @objc func logOut(){
        self.keychain.set("false", forKey: "loggedIn")
        navigationController?.popViewController(animated: true)
    }
    
    func configureUI() {
        
        view.addSubview(titleLabel)
        titleLabel.text = "Stocks"
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(100)
            $0.height.equalTo(60)
        }
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.width.equalToSuperview()
            $0.height.equalTo(700)
        }
    }
}

extension StocksViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Stocks.stocks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StockTableViewCell") as? StocksTableViewCell else {
            return UITableViewCell()
        }
        cell.setValues(symbol: Stocks.stocks[indexPath.row].code, title: Stocks.stocks[indexPath.row].name, imgTitle: Stocks.stocks[indexPath.row].picture)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Network.shared.getStockData(symbol: Stocks.stocks[indexPath.row].code) { [weak self] result in
            guard let self = self else { return }
            switch result{
            case .success(let data):
                DispatchQueue.main.async {
                    let detailVC = StockDetailViewController()
                    detailVC.setValues(stockInfo: data.metaData, stockRecods: data.timeSeriesDaily, companyTitle: Stocks.stocks[indexPath.row].name, picture: Stocks.stocks[indexPath.row].picture)
                    self.navigationController?.pushViewController(detailVC, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
