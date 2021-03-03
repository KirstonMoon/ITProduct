//
//  Generator.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import Foundation

final class PrimeNumbersGenerator: NumbersGeneratorProtocol {
    
    func generateNumbers(withNumber: Int) -> [Double] {
        var testValue = 2
        var data = (2...withNumber * 2).map{$0}
        
        while (testValue * testValue <= withNumber * 2) {
            data.removeAll(where: {$0 >= testValue * testValue && $0.isMultiple(of: testValue)})
            guard let value = data.first(where: {$0 > testValue}) else { fatalError("Ошибка в генерации простых чисел") }
            testValue = value
        }
        return data.map{ Double($0) }
    }
}

