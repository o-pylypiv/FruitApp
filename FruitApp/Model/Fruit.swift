//
//  Fruit.swift
//  FruitApp
//
//  Created by Olha Pylypiv on 25.07.2024.
//

import Foundation

struct Fruit: Codable, Hashable {
    
    let genus: String
    let name: String
    let id: Int
    let family: String
    let order: String
    let nutritions: Nutritions
}
