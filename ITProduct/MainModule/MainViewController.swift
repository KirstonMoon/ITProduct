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
    
    private var numbers = [Int]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        numbersPicker.delegate = self
        numbersPicker.dataSource = self
        
        numbers.append(3)
        numbers.append(5)
        numbers.append(30)
        numbers.append(341)
        numbers.append(3427)
    }


}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        numbers.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        numbers[row].description
    }
}
