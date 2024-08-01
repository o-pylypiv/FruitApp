//
//  FAButton.swift
//  FruitApp
//
//  Created by Olha Pylypiv on 24.07.2024.
//

import UIKit

class FAButton: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(style: UIButton.Configuration? = .filled(),title: String) {
        super.init(frame: .zero)
        if let configuration = style {
            self.configuration = configuration
        }
        self.configuration?.title = title
        configure()
    }
    
    private func configure() {
        configuration?.cornerStyle = .medium
        translatesAutoresizingMaskIntoConstraints = false
        configuration?.baseBackgroundColor = .systemPurple
        configuration?.baseForegroundColor = .white
    }
}

#Preview {
    FAButton(title: "Learn more")
}
