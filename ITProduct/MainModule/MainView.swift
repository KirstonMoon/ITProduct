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
    
    let tabBar: UITabBar = {
        let tb = UITabBar()
        tb.translatesAutoresizingMaskIntoConstraints = false
        tb.setItems([UITabBarItem(title: "Простые", image: UIImage(systemName: "p.square.fill"), tag: 1),
                     UITabBarItem(title: "Фибоначчи", image: UIImage(systemName: "f.square.fill"), tag: 2)], animated: true)
        
        return tb
    }()
    
    private func setupAppearance() {
        backgroundColor = .systemBackground
        setupCollectionView()
        setupTabBar()
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize.height = 100
        layout.itemSize.width = UIScreen.main.bounds.width / 2
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.cellId)
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .systemBackground
        addSubview(collectionView)
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTabBar() {
        addSubview(tabBar)
        tabBar.showsLargeContentViewer = true
        NSLayoutConstraint.activate([
            tabBar.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tabBar.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            tabBar.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
