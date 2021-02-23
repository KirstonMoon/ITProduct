//
//  MainViewModel.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import UIKit

protocol MainViewModelProtocol: AnyObject {
    
    var allNumbers: [Double]? { get }
    
    var getAllNumbers: ((MainViewModelProtocol) -> Void)? { get set }
    
    func showSimpleNumbers(withNumber: Int)
    func showFibsNumbers(withNumber: Int)
    
    
    init(simpleGenerator: NumbersGenerator, fibsGenerator: NumbersGenerator)
}

class MainViewModel: MainViewModelProtocol {
    
    let simpleNumbersModel: NumbersGenerator
    let fibsNumbersModel: NumbersGenerator
    
    var allNumbers: [Double]? {
        didSet {
            self.getAllNumbers?(self)
        }
    }
    
    var getAllNumbers: ((MainViewModelProtocol) -> Void)?
    
    func showSimpleNumbers(withNumber: Int) {
        self.allNumbers = simpleNumbersModel.generateNumbers(withNumber: withNumber)
    }
    
    func showFibsNumbers(withNumber: Int) {
        self.allNumbers = fibsNumbersModel.generateNumbers(withNumber: withNumber)
    }

    required init(simpleGenerator: NumbersGenerator, fibsGenerator: NumbersGenerator) {
        self.simpleNumbersModel = simpleGenerator
        self.fibsNumbersModel = fibsGenerator
    }
}
