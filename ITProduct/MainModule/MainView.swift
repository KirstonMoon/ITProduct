//
//  MainView.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import UIKit


class MainView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupAppearance()
    }
    
    var collectionView: CustomCollectionView!
    
    private func setupAppearance() {
        backgroundColor = .systemBackground
        setupGeneratorLabel()
        setupSimpleNumbersLabel()
        setupFibonacciNumbersLabel()
        setupCollectionView()
    }
    
    let generatorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 30)
        label.text = "Генератор"
        return label
    }()
    
    let simpleNumbersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22)
        label.text = "Простые числа"
        return label
    }()
    
    let fibonacciNumbersLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 22)
        label.text = "Числа Фибоначчи"
        return label
    }()
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.height = 100
        layout.itemSize.width = UIScreen.main.bounds.width / 2 - UIScreen.main.bounds.width * 0.1
        
        collectionView = CustomCollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: simpleNumbersLabel.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupGeneratorLabel() {
        addSubview(generatorLabel)
        NSLayoutConstraint.activate([
            generatorLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            generatorLabel.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor)
        ])
    }
    
    private func setupSimpleNumbersLabel() {
        addSubview(simpleNumbersLabel)
        NSLayoutConstraint.activate([
            simpleNumbersLabel.topAnchor.constraint(equalTo: generatorLabel.bottomAnchor, constant: 35),
            simpleNumbersLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor,constant: 20),
        ])
    }
    
    private func setupFibonacciNumbersLabel() {
        addSubview(fibonacciNumbersLabel)
        NSLayoutConstraint.activate([
            fibonacciNumbersLabel.topAnchor.constraint(equalTo: generatorLabel.bottomAnchor, constant: 35),
            fibonacciNumbersLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
