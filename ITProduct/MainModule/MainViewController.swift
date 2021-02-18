//
//  ViewController.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var generatorLabel: UILabel!
    @IBOutlet weak var numbersPicker: UIPickerView!
    
    private var numbers = [Int]() {
        didSet {
            print(numbers)
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
        numbersPicker.delegate = self
        numbersPicker.dataSource = self
        
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
