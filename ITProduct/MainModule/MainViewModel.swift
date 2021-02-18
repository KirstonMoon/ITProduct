//
//  MainViewModel.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import UIKit

protocol MainViewModelProtocol: AnyObject {
    
    var numbers: [Int]? { get }
    var numbersDidChange: ((MainViewModelProtocol) -> Void)? { get set }
    
    init(generator: Generator)
    func showNumbers(startNumber: Int)
}

class MainViewModel: MainViewModelProtocol {
    
    let generator: Generator
    
    var numbers: [Int]? {
        didSet {
            self.numbersDidChange?(self)
        }
    }
    
    var numbersDidChange: ((MainViewModelProtocol) -> Void)?
    
    required init(generator: Generator) {
        self.generator = generator
    }
    
    func showNumbers(startNumber: Int) {
        self.numbers = self.generator.generateSimpleNumbers(startNumber: startNumber)
    }
}
