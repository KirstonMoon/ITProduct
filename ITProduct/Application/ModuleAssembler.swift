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

class ModuleAssembler: Assembler {
    
    static func createMain() -> UIViewController {
        
        let generator = Generator()
        let view = MainViewController()
        let viewModel = MainViewModel(generator: generator)
        view.viewModel = viewModel
        return view
    }
}
