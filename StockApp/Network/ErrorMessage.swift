//
//  ErrorMessage.swift
//  StockApp
//
//  Created by Luka on 30.06.2022..
//

import Foundation

enum ErrorMessage: String, Error{
    case invalidSymbol = "This symbol created invalid request. Please try again."
    case unableToComplete = "Unable to complete your request. Please check your Internet connection"
    case invalidResponse = "Invalid response from the server. Please try again"
    case invalidData = "The data received from server was invalid. Please try again."
    //case unableFavorite = "There was an error putting user in favorites"
    //case alreadyInfav = "This user is already in favorites"
}
