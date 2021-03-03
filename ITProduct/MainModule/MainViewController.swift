//
//  ViewController.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    override func loadView() {
        view = MainView()
    }
    
    private var mainView: MainView {
        guard let view = view as? MainView else { fatalError("Не удалось отобразить View")}
        return view
    }
    
    private var allNumbers = [Double]() {
        didSet {
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    var viewModel: MainViewModelProtocol?
    {
        didSet {
            self.viewModel?.getAllNumbers = { [weak self] viewModel in
                guard let recievedNumbers = viewModel.allNumbers else { return }
                self?.allNumbers = recievedNumbers
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAppearance()
        setupDelegatesAndDataSource()
        loadFirstNumbers()
    }
    
    private func setupAppearance() {
        title = "Генератор чисел"
        mainView.tabBar.selectedItem = mainView.tabBar.items?.first
    }
    
    private func setupDelegatesAndDataSource() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.tabBar.delegate = self
    }
    
    private func loadFirstNumbers() {
        viewModel?.showPrimeNumbers(withNumber: 150)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        allNumbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.cellId, for: indexPath) as? CustomCollectionViewCell else { fatalError("Не удалось создать ячейку") }
        
        cell.numberLabel.text = String(format: "%.0f", allNumbers[indexPath.row]).description
        
        if indexPath.row % 4 == 0 || indexPath.row % 4 == 3 {
            cell.backgroundColor = .systemBackground
        } else {
            cell.backgroundColor = .systemGray5
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == allNumbers.count - 30 {

            switch mainView.tabBar.selectedItem?.tag {
            case 1: // Если выбраны Простые числа
                DispatchQueue.global(qos: .userInitiated).async(flags: .barrier) {
                    guard let lastNumber = self.allNumbers.last else { return }
                    self.viewModel?.showPrimeNumbers(withNumber: Int(lastNumber))
                }
            case 2: // Если выбраны числа Фибоначчи
                DispatchQueue.global(qos: .userInitiated).async(flags: .barrier) {
                    self.viewModel?.showFibsNumbers(withNumber: self.allNumbers.count)
                }
            default:
                break
            }
        }
    }
}

extension MainViewController: UITabBarDelegate {
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        switch item.tag {
        case 1: // Если выбраны Простые числа
            mainView.collectionView.setContentOffset(.zero, animated: true)
            DispatchQueue.global(qos: .userInitiated).async {
                self.viewModel?.showPrimeNumbers(withNumber: 150)}
        case 2: // Если выбраны числа Фибоначчи
            mainView.collectionView.setContentOffset(.zero, animated: true)
            DispatchQueue.global(qos: .userInitiated).async {
                self.viewModel?.showFibsNumbers(withNumber: 10)}
        default:
            break
        }
    }
}


