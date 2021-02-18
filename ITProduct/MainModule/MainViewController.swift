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
                self?.simpleNumbers = viewModel.simpleNumbers!
            }
            self.viewModel?.getFibsNumbers = { [weak self] viewModel in
                self?.fibsNumbers = viewModel.fibsNumbers!
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.picker.delegate = self
        mainView.picker.dataSource = self
        mainView.picker.myDelegate = self
        viewModel?.showSimpleNumbers(startNumber: 2)
        viewModel?.showFibsNumbers(number: 1000)
    }
    
    
}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if component == 0 {
            return simpleNumbers.count
        } else if component == 1 {
            return fibsNumbers.count
        } else {
            fatalError("Сбой при генерации чисел")
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        if component == 0 {
            let label = UILabel()
            label.text = simpleNumbers[row].description
            label.font = .systemFont(ofSize: 22)
            label.textAlignment = .center
            
            if row % 2 == 1 {
                label.backgroundColor = .gray
            } else if row % 2 == 0 {
                label.backgroundColor = .systemBackground
            }
            
            return label
        } else if component == 1 {
            let label = UILabel()
            label.text = fibsNumbers[row].description
            label.font = .systemFont(ofSize: 22)
            label.textAlignment = .center
            
            if row % 2 == 1 {
                label.backgroundColor = .systemBackground
            } else if row % 2 == 0 {
                label.backgroundColor = .gray
            }
            return label
        }
        return UILabel()
    }
}

extension MainViewController: CustomPickerViewDelegate {
    
    func didTapped(_ picker: CustomPickerView) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let simpleNumber = self.simpleNumbers.last,
                  let fibsNumber = self.fibsNumbers.last else { fatalError("Сбой при генерации")}
            self.viewModel?.showSimpleNumbers(startNumber: simpleNumber)
            self.viewModel?.showFibsNumbers(number: fibsNumber)
        }
    }
}
