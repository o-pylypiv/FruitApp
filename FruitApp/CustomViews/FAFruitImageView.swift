//
//  FAFruitImageView.swift
//  FruitApp
//
//  Created by Olha Pylypiv on 25.07.2024.
//

import UIKit

class FAFruitImageView: UIImageView {

    let placeholderImage = UIImage(resource: .imagePlaceholder)
    let cache = NetworkManager.shared.cache
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        layer.cornerRadius = 50
        clipsToBounds = true
        image = placeholderImage
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func downloadFruitImage(fromURL url: String) {
        Task { image = await NetworkManager.shared.downloadImage(from: url) ?? placeholderImage }
    }
}
