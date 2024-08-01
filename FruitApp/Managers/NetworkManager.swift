//
//  NetworkManager.swift
//  FruitApp
//
//  Created by Olha Pylypiv on 25.07.2024.
//
import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "https://www.fruityvice.com/api/fruit/"
    let cache = NSCache<NSString, UIImage>()
    let decoder = JSONDecoder()
    
    func getFruits() async throws -> [Fruit] {
        let endpoint = baseURL + "all"
        
        guard let url = URL(string: endpoint) else {
            throw FAError.unableToComplete
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw FAError.invalidResponse
        }
        
        do {
            return try decoder.decode([Fruit].self, from: data)
        } catch {
            throw FAError.invalidData
        }
    }
    
    func downloadImage(from urlString: String) async -> UIImage? {
        let cacheKey = NSString(string: urlString)
        if let image = cache.object(forKey: cacheKey) { return image }
        
        guard let url = URL(string: urlString) else { return nil }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            guard let image = UIImage(data: data) else { return nil }
            cache.setObject(image, forKey: cacheKey)
            return image
        } catch {
            return nil
        }
    }
}
