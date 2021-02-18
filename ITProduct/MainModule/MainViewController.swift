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
    
    private var numbers = [Int]() {
        didSet {
            DispatchQueue.main.async {
                self.mainView.picker.reloadAllComponents()
            }
        }
    }
    
    var viewModel: MainViewModelProtocol? {
        didSet {
            self.viewModel?.numbersDidChange = { [weak self] viewModel in
                guard let numbers = viewModel.numbers else { return }
                self?.numbers = numbers
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.picker.delegate = self
        mainView.picker.dataSource = self
        mainView.picker.myDelegate = self
        viewModel?.showNumbers(startNumber: 2)
    }


}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        numbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        numbers[row].description
    }
}

extension MainViewController: CustomPickerViewDelegate {
    
    func didTapped(_ picker: CustomPickerView) {
        
        DispatchQueue.global(qos: .userInitiated).async {
            guard let number = self.numbers.last else { fatalError("Сбой при генерации простых чисел")}
            self.viewModel?.showNumbers(startNumber: number)
        }
    }
}
