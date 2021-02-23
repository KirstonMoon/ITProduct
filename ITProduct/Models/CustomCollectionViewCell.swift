//
//  CustomCollectionViewCell.swift
//  ITProduct
//
//  Created by Kirill Magerya on 19.02.2021.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    static let cellId = "customCell"
    
    private func setupAppearance() {
        setupNumberLabel()
    }
    
    let numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    private func setupNumberLabel() {
        addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            numberLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            numberLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
