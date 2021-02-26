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
                guard let recievedNumbers = viewModel.allNumbers else { fatalError("Ошибка в получении чисел из viewModel")}
                self?.allNumbers = recievedNumbers
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDelegatesAndDataSource()
        loadFirstNumbers()
        addActionsToButtons()
    }
    
    private func setupDelegatesAndDataSource() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    private func loadFirstNumbers() {
        viewModel?.showPrimeNumbers(withNumber: 100)
    }
    
    private func addActionsToButtons() {
        mainView.primeNumbersButton.addTarget(self, action: #selector(switchToPrimeNumbes(sender:)), for: .touchUpInside)
        mainView.fibonacciNumbersButton.addTarget(self, action: #selector(switchToFibsNumbes(sender:)), for: .touchUpInside)
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
            cell.backgroundColor = .systemGray4
        } else {
            cell.backgroundColor = .systemGray
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if indexPath.row == allNumbers.count - 30 {
            if mainView.primeNumbersButton.backgroundColor == #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
                DispatchQueue.global(qos: .userInitiated).async(flags: .barrier) {
                    guard let lastNumber = self.allNumbers.last else { fatalError("Ошибка в массиве всех чисел в классе MainViewController")}
                    self.viewModel?.showPrimeNumbers(withNumber: Int(lastNumber))
                }
            } else if mainView.fibonacciNumbersButton.backgroundColor == #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
                DispatchQueue.global(qos: .userInitiated).async(flags: .barrier) {
                    self.viewModel?.showFibsNumbers(withNumber: self.allNumbers.count)
                }
            }
        }
    }
}

// MARK: - Buttons function

private extension MainViewController {
    
    @objc func switchToPrimeNumbes(sender: UIButton) {

        if mainView.primeNumbersButton.backgroundColor != #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
            mainView.primeNumbersButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            mainView.fibonacciNumbersButton.backgroundColor = .systemGray
            
            mainView.collectionView.setContentOffset(.zero, animated: true)
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.viewModel?.showPrimeNumbers(withNumber: 100)
            }
        }
    }
    
    @objc func switchToFibsNumbes(sender: UIButton) {
        
        if mainView.fibonacciNumbersButton.backgroundColor != #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1) {
            mainView.fibonacciNumbersButton.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
            mainView.primeNumbersButton.backgroundColor = .systemGray
            
            mainView.collectionView.setContentOffset(.zero, animated: true)
            
            DispatchQueue.global(qos: .userInitiated).async {
                self.viewModel?.showFibsNumbers(withNumber: 10)
            }
        }
    }
}
