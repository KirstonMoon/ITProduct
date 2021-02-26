//
//  ModuleAssembler.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import UIKit

protocol Assembler {
    
    static func createMain() -> UIViewController
}

final class ModuleAssembler: Assembler {
    
    static func createMain() -> UIViewController {
        
        let primeGenerator = GeneratorPrimeNumbers()
        let fibsGenerator = GeneratorFibsNumbers()
        
        let view = MainViewController()
        let viewModel = MainViewModel(primeGenerator: primeGenerator, fibsGenerator: fibsGenerator)
        view.viewModel = viewModel
        return view
    }
}
