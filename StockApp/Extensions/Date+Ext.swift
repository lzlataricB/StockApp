//
//  Date+Ext.swift
//  StockApp
//
//  Created by Luka on 30.06.2022..
//

import Foundation

extension Date{
    
    func convertFormat() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy"
        return dateFormatter.string(from: self)
    }
    
}
