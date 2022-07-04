//
//  StocksTableViewCell.swift
//  StockApp
//
//  Created by Luka on 29.06.2022..
//

import UIKit
import SnapKit

class StocksTableViewCell: UITableViewCell {
    
    static let reuseID = "StockTableViewCell"
    
    lazy var symbolLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 25)
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var image: UIImageView = UIImageView(frame: .zero)
    
    func setValues(symbol: String, title: String, imgTitle: String){
        symbolLabel.text = symbol
        titleLabel.text = title
        image.image = UIImage(named: imgTitle)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        contentView.addSubview(symbolLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(image)
        
        symbolLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.height.equalTo(60)
            $0.width.equalTo(80)
        }
        
        titleLabel.snp.makeConstraints{
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(symbolLabel.snp.trailing).offset(30)
            $0.height.equalTo(60)
            $0.width.equalTo(170)
        }
        
        image.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(titleLabel.snp.trailing).offset(20)
            $0.height.equalTo(50)
            $0.width.equalTo(50)
        }
    }
}
