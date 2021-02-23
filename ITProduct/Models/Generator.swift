//
//  Generator.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import Foundation

protocol NumbersGenerator {
    func generateNumbers(withNumber: Int) -> [Double]
}

final class GeneratorSimpleNumbers: NumbersGenerator {
    
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

final class GeneratorFibsNumbers: NumbersGenerator {
    
    func generateNumbers(withNumber: Int) -> [Double] {
        let toNumber = withNumber + 20
        var array: [Double] = [0, 1]
        
        while array.count < toNumber {
            array.append(array[array.count - 1] + array[array.count - 2])
        }
        return array
    }
}
