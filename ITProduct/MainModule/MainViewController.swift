//
//  ViewController.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import UIKit

class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    override func loadView() {
        view = MainView()
    }
    
    private var mainView: MainView {
        guard let view = view as? MainView else { fatalError("Не удалось отобразить View")}
        return view
    }
    
    private var simpleNumbers = [Int]() {
        didSet {
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    private var fibsNumbers = [Double]() {
        didSet {
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    var viewModel: MainViewModelProtocol? {
        didSet {
            self.viewModel?.getSimpleNumbers = { [weak self] viewModel in
                guard let numbers = viewModel.simpleNumbers else { fatalError("Сбой при генерации простых чисел")}
                self?.simpleNumbers = numbers
            }
            self.viewModel?.getFibsNumbers = { [weak self] viewModel in
                guard let numbers = viewModel.fibsNumbers else { fatalError("Сбой при генерации чисел Фибоначчи")}
                self?.fibsNumbers = numbers
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegatesAndDataSource()
        loadFirstNumbers()
    }
    
    private func setupDelegatesAndDataSource() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        mainView.collectionView.myDelegate = self
    }
    
    private func loadFirstNumbers() {
        viewModel?.showSimpleNumbers(startNumber: 2)
        viewModel?.showFibsNumbers(number: 100)
    }
    
}

extension MainViewController: CustomCollectionViewDelegate {
    
    func didTapped(_ picker: CustomCollectionView) {
        
        DispatchQueue.global(qos: .userInitiated).async(flags: .barrier) {
            guard let simpleNumber = self.simpleNumbers.last else { fatalError("Сбой при генерации простых чисел")}
            
            self.viewModel?.showSimpleNumbers(startNumber: simpleNumber)
            self.viewModel?.showFibsNumbers(number: Double(self.fibsNumbers.count))
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        simpleNumbers.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.cellId, for: indexPath) as? CustomCollectionViewCell else { fatalError("Не удалось создать ячейку") }
        cell.numberLabel.text = simpleNumbers[indexPath.row].description
        
        switch indexPath.row {
        case let x where x % 4 == 0: cell.backgroundColor = .gray
        case let y where y % 4 == 3: cell.backgroundColor = .gray
        default: cell.backgroundColor = .white
        }
        return cell
    }
}

extension Int {
    func square() -> Int {
        return self * self
    }
}
