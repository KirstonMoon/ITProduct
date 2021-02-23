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
    
    var collectionView: UICollectionView!
    
    private func setupAppearance() {
        backgroundColor = .systemBackground
        setupGeneratorLabel()
        setupSimpleNumbersButton()
        setupFibonacciNumbersButton()
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
    
    let simpleNumbersButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
        bt.setTitle("Простые числа", for: .normal)
        return bt
    }()
    
    let fibonacciNumbersButton: UIButton = {
        let bt = UIButton()
        bt.translatesAutoresizingMaskIntoConstraints = false
        bt.backgroundColor = .gray
        bt.setTitle("Числа Фибоначчи", for: .normal)
        return bt
    }()

    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.height = 100
        layout.itemSize.width = UIScreen.main.bounds.width / 2 - UIScreen.main.bounds.width * 0.1
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.cellId)
        //collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: fibonacciNumbersButton.bottomAnchor, constant: 20),
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
    
    private func setupSimpleNumbersButton() {
        addSubview(simpleNumbersButton)
        simpleNumbersButton.layer.cornerRadius = 25
        NSLayoutConstraint.activate([
            simpleNumbersButton.topAnchor.constraint(equalTo: generatorLabel.bottomAnchor, constant: 35),
            simpleNumbersButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            simpleNumbersButton.heightAnchor.constraint(equalToConstant: 50),
            simpleNumbersButton.widthAnchor.constraint(equalToConstant: 175)
        ])
    }
    
    private func setupFibonacciNumbersButton() {
        addSubview(fibonacciNumbersButton)
        fibonacciNumbersButton.layer.cornerRadius = 25
        NSLayoutConstraint.activate([
            fibonacciNumbersButton.topAnchor.constraint(equalTo: simpleNumbersButton.bottomAnchor, constant: 5),
            fibonacciNumbersButton.centerXAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
            fibonacciNumbersButton.heightAnchor.constraint(equalToConstant: 50),
            fibonacciNumbersButton.widthAnchor.constraint(equalToConstant: 175)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
