//
//  Generator.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import Foundation

class Generator {
    
    func generateSimpleNumbers(startNumber: Int) -> [Int] {
        
        let max = startNumber + 1000
        var testValue = 2
        var data = (2...max).map{$0}
        
        while (testValue.powerOf2() <= max) {
            data.removeAll(where: {$0 >= testValue.powerOf2() && $0.isMultiple(of: testValue)})
            testValue = data.first(where: {$0 > testValue})!
        }
        
        return data
    }
    
    func generateFibsNumbers(number: Double) -> [Double] {
        var arrayOfNumbers = [Double]()
        getFibsNumbers(through: number * number).forEach{arrayOfNumbers.append($0)}
        return arrayOfNumbers
    }
    
    func getFibsNumbers(through: Double) -> UnfoldSequence<Double, (Double, Double)> {
        return sequence(state: (0, 1),
                        next: { (pair: inout (Double, Double)) -> Double? in
                            guard pair.1 <= through else { return nil }
                            defer { pair = (pair.1, pair.0 + pair.1) }
                            return pair.1
                        })
    }
    
    
}

