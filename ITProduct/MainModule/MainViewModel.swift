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
    
    func showPrimeNumbers(withNumber: Int)
    func showFibsNumbers(withNumber: Int)
    
    
    init(primeGenerator: NumbersGenerator, fibsGenerator: NumbersGenerator)
}

final class MainViewModel: MainViewModelProtocol {
    
    let primeNumbersModel: NumbersGenerator
    let fibsNumbersModel: NumbersGenerator
    
    var allNumbers: [Double]? {
        didSet {
            self.getAllNumbers?(self)
        }
    }
    
    var getAllNumbers: ((MainViewModelProtocol) -> Void)?
    
    func showPrimeNumbers(withNumber: Int) {
        self.allNumbers = primeNumbersModel.generateNumbers(withNumber: withNumber)
    }
    
    func showFibsNumbers(withNumber: Int) {
        self.allNumbers = fibsNumbersModel.generateNumbers(withNumber: withNumber)
    }

    required init(primeGenerator: NumbersGenerator, fibsGenerator: NumbersGenerator) {
        self.primeNumbersModel = primeGenerator
        self.fibsNumbersModel = fibsGenerator
    }
}
