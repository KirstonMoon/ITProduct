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
    
    private var simpleNumbers = [Int]()
    {
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
    
    var viewModel: MainViewModelProtocol?
    {
        didSet {
            self.viewModel?.getSimpleNumbers = { [weak self] viewModel in
                guard let recievedNumbers = viewModel.simpleNumbers else { fatalError("Сбой при получение простых чисел")}
                self?.simpleNumbers = recievedNumbers
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
        addTargetToButtons()
    }
    
    private func setupDelegatesAndDataSource() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    private func loadFirstNumbers() {
        viewModel?.showSimpleNumbers(startNumber: 100)
        viewModel?.showFibsNumbers(number: 300)
    }
    
    private func addTargetToButtons() {
        mainView.simpleNumbersButton.addTarget(self, action: #selector(switchToSimpleNumbes(sender:)), for: .touchUpInside)
        mainView.fibonacciNumbersButton.addTarget(self, action: #selector(switchToFibsNumbes(sender:)), for: .touchUpInside)
    }
    
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if mainView.simpleNumbersButton.backgroundColor == #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
            return simpleNumbers.count
        } else if mainView.fibonacciNumbersButton.backgroundColor == #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
            return fibsNumbers.count
        }
        fatalError("Сбой при высчитывании количества элементов в массиве чисел")
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = mainView.collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.cellId, for: indexPath) as? CustomCollectionViewCell else { fatalError("Не удалось создать ячейку") }
        
        if mainView.simpleNumbersButton.backgroundColor == #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
            cell.numberLabel.text = simpleNumbers[indexPath.row].description
            
        } else if mainView.fibonacciNumbersButton.backgroundColor == #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
            cell.numberLabel.text = String(format: "%.0f", fibsNumbers[indexPath.row]).description
        }
        
        if indexPath.row % 4 == 0 || indexPath.row % 4 == 3 {
            cell.backgroundColor = .systemGray4
        } else {
            cell.backgroundColor = .systemGray
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == simpleNumbers.count - 30 {
            if mainView.simpleNumbersButton.backgroundColor == #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
                
                DispatchQueue.global(qos: .userInitiated).async {
                    guard let lastSimpleNumber = self.simpleNumbers.last else { return }
                    self.viewModel?.showSimpleNumbers(startNumber: lastSimpleNumber)
                }
            }
        } else if indexPath.row == fibsNumbers.count - 30 {
            if mainView.fibonacciNumbersButton.backgroundColor == #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
                
                DispatchQueue.global(qos: .userInitiated).async {
                    self.viewModel?.showFibsNumbers(number: Double(self.fibsNumbers.count))
                }
            }
        }
    }
}

// MARK: - Buttons function

extension MainViewController {
    
    @objc func switchToSimpleNumbes(sender: UIButton) {
        
        if mainView.simpleNumbersButton.backgroundColor != #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
            
            mainView.simpleNumbersButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            mainView.fibonacciNumbersButton.backgroundColor = .gray
            
            let updatedNumbers = simpleNumbers.prefix(50).map{$0}
            simpleNumbers = updatedNumbers
            
            mainView.collectionView.setContentOffset(CGPoint.zero, animated: true)
            
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
    
    @objc func switchToFibsNumbes(sender: UIButton) {
        if mainView.fibonacciNumbersButton.backgroundColor != #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
            
            mainView.fibonacciNumbersButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            mainView.simpleNumbersButton.backgroundColor = .gray
            
            let updatedNumbers = fibsNumbers.prefix(100).map{ $0 }
            fibsNumbers = updatedNumbers
            
            mainView.collectionView.setContentOffset(CGPoint.zero, animated: true)
            
            DispatchQueue.main.async {
                self.mainView.collectionView.reloadData()
            }
        }
    }
}
