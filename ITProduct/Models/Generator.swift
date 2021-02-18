//
//  Generator.swift
//  ITProduct
//
//  Created by Kirill Magerya on 18.02.2021.
//

import Foundation

class Generator {
    
    func generateSimpleNumbers(startNumber: Int) -> [Int] {
        
        var startInt = startNumber
        var data = (startInt...startInt+500).map{$0}
        
        while (startInt.powerOf2() <= startInt+1000) {
            data.removeAll(where: {$0 >= startInt.powerOf2() && $0.isMultiple(of: startInt)})
            startInt = data.first(where: {$0 > startInt})!
        }
        
        
        return data
    }
}

