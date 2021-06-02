//
//  Calculation.swift
//  CountOnMe
//
//  Created by Rémi Demeaux on 02/06/2021.
//  Copyright © 2021 Vincent Saluzzo. All rights reserved.
//

import Foundation

class Calculation {
    
    // Function to remove zeros after the comma
    func clearResult(number : Double) -> String {
        let stringNumber = String(number)
        let index = stringNumber.count - 1
        let cleanArray = Array(stringNumber)
        let lastNumber = cleanArray[index]
        if lastNumber != "0" {
            return "\(number)"
        }
        let result = Int(number)
        return "\(result)"
    }
    
    //MARK: - Test Phase
    

    
}

