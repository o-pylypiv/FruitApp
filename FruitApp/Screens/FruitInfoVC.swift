//
//  FruitInfoVC.swift
//  FruitApp
//
//  Created by Olha Pylypiv on 26.07.2024.
//

import UIKit

class FruitInfoVC: UIViewController {

    var fruit: Fruit!
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = fruit.name
        view.backgroundColor = .systemBackground
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: SFSymbols.toFavorite, style: .plain, target: self, action: #selector(favoriteFruit))
    }
    
    @objc func favoriteFruit() {
    }
    
    func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        
        NSLayoutConstraint.activate([
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            contentView.heightAnchor.constraint(equalToConstant: 1200)
        ])
    #warning ("Scroll view height")
    }
}
