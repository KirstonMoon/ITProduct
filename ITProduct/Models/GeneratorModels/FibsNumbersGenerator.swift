//
//  FibsNumbersModel.swift
//  ITProduct
//
//  Created by Kirill Magerya on 26.02.2021.
//

import Foundation

final class FibsNumbersGenerator: NumbersGeneratorProtocol {
    
    func generateNumbers(withNumber: Int) -> [Double] {
        let toNumber = withNumber + 100
        var array: [Double] = [0, 1]
        
        while array.count < toNumber {
            array.append(array[array.count - 1] + array[array.count - 2])
        }
        return array
    }
}
