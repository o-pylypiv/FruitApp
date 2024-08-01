//
//  FruitCell.swift
//  FruitApp
//
//  Created by Olha Pylypiv on 25.07.2024.
//

import UIKit

class FruitCell: UICollectionViewCell {
    static let reuseID = "FruitCell"
    let fruitLabel = FATitleLabel(textAlignment: .center, fontSize: 16)
    let fruitImageView = FAFruitImageView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        addSubview(fruitImageView)
        addSubview(fruitLabel)
        let padding: CGFloat = 8
        
        NSLayoutConstraint.activate([
            fruitImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            fruitImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            fruitImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            fruitImageView.heightAnchor.constraint(equalTo: fruitImageView.widthAnchor),
            
            fruitLabel.topAnchor.constraint(equalTo: fruitImageView.bottomAnchor, constant: 12),
            fruitLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            fruitLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            fruitLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    func set(fruit: Fruit) {
        let fruitName = fruit.name
        fruitLabel.text = fruitName
        //set the image
        let imageUrl = "https://en.wikipedia.org/wiki/\(fruitName.capitalized)#mediawiki/File:\(fruitName.capitalized).jpg|thumb|left"
        fruitImageView.downloadFruitImage(fromURL: imageUrl)
    }
}
