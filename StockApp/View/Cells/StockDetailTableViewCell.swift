//
//  StockDetailTableViewCell.swift
//  StockApp
//
//  Created by Luka on 30.06.2022..
//

import UIKit
import SnapKit

class StockDetailTableViewCell: UITableViewCell {

    static let reuseID = "StockDetailTableViewCell"
    var dateLabel: UILabel?
    var high: UILabel?
    var low: UILabel?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    func setValues(date: String, high: String, low: String) {
        self.dateLabel?.text = date.convertToDisplayFormat()
        self.high?.text = "\(roundValues(number: high)) ⬆️"
        self.low?.text = "\(roundValues(number: low)) ⬇️"
    }
    
    func roundValues(number: String) -> String {
        guard let number = Double(number) else { return "0"}
        let roundedNumber = round(number * 10) / 10.0
        return String(roundedNumber)
    }
    
    func configureUI() {
        let container = UIView()
        contentView.addSubview(container)
        container.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        let cloudView = UIView()
        cloudView.layer.borderWidth = 1
        cloudView.layer.borderColor = UIColor.black.cgColor
        cloudView.layer.cornerRadius = 7
        container.addSubview(cloudView)
        cloudView.snp.makeConstraints {
            $0.top.equalTo(10)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(350)
            $0.height.equalTo(85)
        }
    
        let dateLabelTwo = UILabel()
        cloudView.addSubview(dateLabelTwo)
        dateLabelTwo.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.centerX.equalToSuperview()
        }
        self.dateLabel = dateLabelTwo
        
        let newHighLabel = UILabel()
        newHighLabel.font = newHighLabel.font.withSize(25)
        newHighLabel.textColor = .green
        cloudView.addSubview(newHighLabel)
        newHighLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabelTwo).offset(30)
            $0.leading.equalTo(30)
        }
        self.high = newHighLabel
        
        let newLowLabel = UILabel()
        newLowLabel.font = newLowLabel.font.withSize(25)
        newLowLabel.textColor = .red
        cloudView.addSubview(newLowLabel)
        newLowLabel.snp.makeConstraints {
            $0.top.equalTo(dateLabelTwo).offset(30)
            $0.trailing.equalTo(-30)
        }
        self.low = newLowLabel
    }
}
