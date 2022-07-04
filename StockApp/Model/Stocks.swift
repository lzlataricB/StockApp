//
//  Stocks.swift
//  StockApp
//
//  Created by Luka on 29.06.2022..
//

import Foundation


struct Stock {
    var name : String
    var code: String
    var picture: String
}

struct Stocks {
    static let stocks : [Stock] = [
        Stock(name: "Amazon.com, Inc.", code: "AMZN", picture: "amazon"),
        Stock(name: "Apple Inc.", code: "AAPL", picture: "apple"),
        Stock(name: "NVIDIA Corporation", code: "NVDA", picture: "nvidia"),
        Stock(name: "Ford motor company", code: "F", picture: "ford"),
        Stock(name: "Intel corporation", code: "INTC", picture: "intel"),
        Stock(name: "Nike Inc.", code: "NKE", picture: "nike"),
        Stock(name: "Tesla Inc.", code: "TSLA", picture: "tesla"),
        Stock(name: "Nokia Oyj", code: "NOK", picture: "nokia")
    ]
}

struct StockDetailed {
    let lastRefreshed: String
    let open, high, low, close: String
}

struct StockAPI : Codable {
    let metaData: MetaData
    let timeSeriesDaily: [String: TimeSeriesDaily]
    
    enum CodingKeys: String, CodingKey {
        case metaData = "Meta Data"
        case timeSeriesDaily = "Time Series (Daily)"
    }
}

struct MetaData: Codable {
    let information, symbol, lastRefreshed, outputSize: String
    let timeZone: String
    
    enum CodingKeys: String, CodingKey {
        case information = "1. Information"
        case symbol = "2. Symbol"
        case lastRefreshed = "3. Last Refreshed"
        case outputSize = "4. Output Size"
        case timeZone = "5. Time Zone"
    }
}

struct TimeSeriesDaily: Codable {
    let open, high, low, close, volume: String
    
    enum CodingKeys: String, CodingKey {
        case open = "1. open"
        case high = "2. high"
        case low = "3. low"
        case close = "4. close"
        case volume = "5. volume"
    }
}

struct SortedStocks {
    let high, low: String
    let date: String
}
