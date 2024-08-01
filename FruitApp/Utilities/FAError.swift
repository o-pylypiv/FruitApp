//
//  FAError.swift
//  FruitApp
//
//  Created by Olha Pylypiv on 25.07.2024.
//

import Foundation

enum FAError: String, Error {
    case unableToComplete = "Unable to complete your request. Please chack you internet connection."
    case invalidResponse = "Invalid response from the server. Please try again."
    case invalidData = "The data from the server was invalid. Please try again."
    case unableToFavorite = "There was an error favoriting this fruit. Please try again."
    case alreadyInFavorites = "You've already favorited this fruit :)"
}
