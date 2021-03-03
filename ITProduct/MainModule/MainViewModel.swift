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
    
    init(primeGenerator: NumbersGeneratorProtocol, fibsGenerator: NumbersGeneratorProtocol)
}

final class MainViewModel: MainViewModelProtocol {
    
    var allNumbers: [Double]? {
        didSet {
            self.getAllNumbers?(self)
        }
    }
    
    var getAllNumbers: ((MainViewModelProtocol) -> Void)?
    
    let primeNumbersModel: NumbersGeneratorProtocol
    let fibsNumbersModel: NumbersGeneratorProtocol
    
    func showPrimeNumbers(withNumber: Int) {
        self.allNumbers = primeNumbersModel.generateNumbers(withNumber: withNumber)
    }
    
    func showFibsNumbers(withNumber: Int) {
        self.allNumbers = fibsNumbersModel.generateNumbers(withNumber: withNumber)
    }

    required init(primeGenerator: NumbersGeneratorProtocol, fibsGenerator: NumbersGeneratorProtocol) {
        self.primeNumbersModel = primeGenerator
        self.fibsNumbersModel = fibsGenerator
    }
}
