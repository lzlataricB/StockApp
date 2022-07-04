//
//  String+Ext.swift
//  StockApp
//
//  Created by Luka on 30.06.2022..
//

import Foundation

extension String{
    
    func convertToDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        return dateFormatter.date(from: self)
    }
    
    func convertToDisplayFormat() -> String{
        guard let date = self.convertToDate() else { return "N/A" }
        return date.convertFormat()
    }
    
}
