//
//  Network.swift
//  StockApp
//
//  Created by Luka on 28.06.2022..
//

import UIKit
import FirebaseAuth

class Network{
    static let shared = Network()
    let urlBase = "https://alpha-vantage.p.rapidapi.com/query?function=TIME_SERIES_DAILY&"
    private let headers = [
        "X-RapidAPI-Key": "f5976a868bmsh5e3c0a809bc678bp120b47jsn5afdd8ad5c31",
        "X-RapidAPI-Host": "alpha-vantage.p.rapidapi.com"
    ]
    
    private init() {}
    
    func signIn(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().signIn(withEmail: email, password: pass) { (result, error) in
            if let error = error{
                print(error)
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func signUp(email: String, pass: String, completionBlock: @escaping (_ success: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: pass){ (result, error) in
            if let error = error{
                print(error)
                completionBlock(false)
            } else {
                completionBlock(true)
            }
        }
    }
    
    func getStockData(symbol: String, completionBlock: @escaping (Result<StockAPI, ErrorMessage>) -> Void) {
        let fullURL = urlBase + "symbol=\(symbol)&outputsize=compact&datatype=json"
        guard let url = URL(string: fullURL) else {
            completionBlock(.failure(.invalidSymbol))
            return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let _ = error{
                completionBlock(.failure(.unableToComplete))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionBlock(.failure(.invalidResponse))
                return
            }
            
            guard let data = data else {
                completionBlock(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let stocks = try decoder.decode(StockAPI.self, from: data)
                completionBlock(.success(stocks))
            }
            catch {
                completionBlock(.failure(.invalidData))
            }
        }.resume()
    }
}
