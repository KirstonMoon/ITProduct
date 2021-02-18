//
//  MainViewModel.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import UIKit

protocol MainViewModelProtocol: AnyObject {
    
    var simpleNumbers: [Int]? { get }
    var fibsNumbers: [Double]? { get }
    var getSimpleNumbers: ((MainViewModelProtocol) -> Void)? { get set }
    var getFibsNumbers: ((MainViewModelProtocol) -> Void)? { get set }
    
    func showSimpleNumbers(startNumber: Int)
    func showFibsNumbers(number: Double)
    
    init(generator: Generator)
}

class MainViewModel: MainViewModelProtocol {
    
    let generator: Generator
    
    var simpleNumbers: [Int]? {
        didSet {
            self.getSimpleNumbers?(self)
        }
    }
    
    var fibsNumbers: [Double]? {
        didSet {
            self.getFibsNumbers?(self)
        }
    }
    
    var getSimpleNumbers: ((MainViewModelProtocol) -> Void)?
    var getFibsNumbers: ((MainViewModelProtocol) -> Void)?
    
    required init(generator: Generator) {
        self.generator = generator
    }
    
    func showSimpleNumbers(startNumber: Int) {
        self.simpleNumbers = self.generator.generateSimpleNumbers(startNumber: startNumber)
    }
    
    func showFibsNumbers(number: Double) {
        self.fibsNumbers = self.generator.generateFibsNumbers(number: number)
    }
}
