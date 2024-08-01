//
//  FruitInfoHeaderVC.swift
//  FruitApp
//
//  Created by Olha Pylypiv on 26.07.2024.
//

import UIKit

class FruitInfoHeaderVC: UIViewController {
    
    var fruit: Fruit!
    
    let fruitImageView = FAFruitImageView(frame: .zero)
    let genusLabel = FATitleLabel(textAlignment: .left, fontSize: 20)
    let familyLabel = FATitleLabel(textAlignment: .left, fontSize: 20)
    let orderLabel = FATitleLabel(textAlignment: .left, fontSize: 20)
    var labels: [FATitleLabel] = []
    
    let genusButton = FAButton(style: .plain(), title: "")
    let familyButton = FAButton(style: .plain(), title: "")
    let orderButton = FAButton(style: .plain(), title: "")
    var buttons: [FAButton] = []
    
    let padding: CGFloat = 20
    let minSpacing: CGFloat = 8

    init(fruit: Fruit!) {
        super.init(nibName: nil, bundle: nil)
        self.fruit = fruit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        configureImageView()
        configureLabels()
        configureButtons()
        //configureUIElements
    }

    func addSubviews() {
        view.addSubview(fruitImageView)
        view.addSubview(genusLabel)
        view.addSubview(familyLabel)
        view.addSubview(orderLabel)
        view.addSubview(genusButton)
        view.addSubview(familyButton)
        view.addSubview(orderButton)
    }
    
    func configureImageView() {
        let imageUrl = "https://en.wikipedia.org/wiki/\(fruit.name.capitalized)#mediawiki/File:\(fruit.name.capitalized).jpg|thumb|left"
        fruitImageView.downloadFruitImage(fromURL: imageUrl)
        
        NSLayoutConstraint.activate([
            fruitImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            fruitImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: padding),
            fruitImageView.widthAnchor.constraint(equalTo: fruitImageView.heightAnchor),
            fruitImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func configureLabels() {
        genusLabel.text = "Genus:"
        labels = [genusLabel, familyLabel, orderLabel]
        
        for label in labels {
            NSLayoutConstraint.activate([
                label.heightAnchor.constraint(equalToConstant: 50),
                label.widthAnchor.constraint(equalToConstant: 200),
            ])
        }
        
        NSLayoutConstraint.activate([
            genusLabel.topAnchor.constraint(equalTo: fruitImageView.bottomAnchor, constant: padding),
            genusLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: padding),
            
            familyLabel.topAnchor.constraint(equalTo: genusLabel.bottomAnchor, constant: minSpacing),
            familyLabel.leadingAnchor.constraint(equalTo: genusLabel.leadingAnchor),
            
            orderLabel.topAnchor.constraint(equalTo: familyLabel.bottomAnchor, constant: minSpacing),
            orderLabel.leadingAnchor.constraint(equalTo: familyLabel.leadingAnchor),
        ])
    }
    
    func configureButtons() {
        buttons = [genusButton, familyButton, orderButton]
        
        for button in buttons {
            NSLayoutConstraint.activate([
                button.heightAnchor.constraint(equalToConstant: 50),
                button.widthAnchor.constraint(equalToConstant: 200),
            ])
        }
        
        NSLayoutConstraint.activate([
            genusButton.topAnchor.constraint(equalTo: fruitImageView.bottomAnchor, constant: padding),
            genusButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -padding),
            
            familyButton.topAnchor.constraint(equalTo: genusButton.bottomAnchor, constant: minSpacing),
            familyButton.trailingAnchor.constraint(equalTo: genusButton.trailingAnchor),
            
            orderButton.topAnchor.constraint(equalTo: familyButton.bottomAnchor, constant: minSpacing),
            orderButton.trailingAnchor.constraint(equalTo: familyButton.trailingAnchor)
        ])
    }
}
