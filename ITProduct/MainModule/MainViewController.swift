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
    
    private var simpleNumbers = [Int]() {
        didSet {
            DispatchQueue.main.async {
                self.mainView.picker.reloadAllComponents()
            }
        }
    }
    
    private var fibsNumbers = [Double]() {
        didSet {
            DispatchQueue.main.async {
                self.mainView.picker.reloadAllComponents()
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
        mainView.picker.delegate = self
        mainView.picker.dataSource = self
        mainView.picker.myDelegate = self
    }
    
    private func loadFirstNumbers() {
        viewModel?.showSimpleNumbers(startNumber: 2)
        viewModel?.showFibsNumbers(number: 100)
    }
}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch component {
        
        case 0:
            return simpleNumbers.count
        case 1:
            return fibsNumbers.count
        default:
            fatalError("Сбой при генерации чисел")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        switch component {
        case 0:
            let label = UILabel()
            label.text = simpleNumbers[row].description
            label.textAlignment = .center
            
            if row % 2 == 1 {
                label.backgroundColor = .systemGray4
            } else if row % 2 == 0 {
                label.backgroundColor = .systemBackground
            }
            return label
            
        case 1:
            let label = UILabel()
            label.text = String(format: "%.f", fibsNumbers[row]).description
            label.textAlignment = .center
            
            if row % 2 == 1 {
                label.backgroundColor = .systemBackground
            } else if row % 2 == 0 {
                label.backgroundColor = .systemGray4
            }
            return label
        default:
            fatalError("Сбой при отображение ячеек")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        120
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        70
    }
}

extension MainViewController: CustomPickerViewDelegate {
    
    func didTapped(_ picker: CustomPickerView) {
        
        DispatchQueue.global(qos: .userInitiated).async(flags: .barrier) {
            guard let simpleNumber = self.simpleNumbers.last,
                  let fibsNumber = self.fibsNumbers.last else { fatalError("Сбой при генерации чисел")}
            self.viewModel?.showSimpleNumbers(startNumber: simpleNumber)
            self.viewModel?.showFibsNumbers(number: fibsNumber)
        }
    }
}
