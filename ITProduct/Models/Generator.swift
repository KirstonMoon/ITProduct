//
//  Generator.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import Foundation

final class Generator {
    
    func generateSimpleNumbers(startNumber: Int) -> [Int] {
        
        let max = startNumber
        var testValue = 2
        var data = (2...max * max).map{$0}
        
        while (testValue * testValue <= max) {
            data.removeAll(where: {$0 >= testValue * testValue && $0.isMultiple(of: testValue)})
            testValue = data.first(where: {$0 > testValue})!
        }
        print("генерация массив =  \(data.count) элементов")
        return data
    }
    
    func generateFibsNumbers(number: Int) -> [Double] {
        let toNumber = number + 50
        var array: [Double] = [0, 1]
        
        while array.count < toNumber {
            array.append(array[array.count - 1] + array[array.count - 2])
        }
        return array
    }
}
