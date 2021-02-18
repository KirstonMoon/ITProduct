//
//  Generator.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import Foundation

class Generator {
    
    func generateSimpleNumbers(startNumber: Int) -> [Int] {
        
        let max = startNumber + 300
        var testValue = 2
        var data = (2...max).map{$0}

        while (testValue.powerOf2() <= max) {
            data.removeAll(where: {$0 >= testValue.powerOf2() && $0.isMultiple(of: testValue)})
            testValue = data.first(where: {$0 > testValue})!
        }
        
        return data
    }
}

