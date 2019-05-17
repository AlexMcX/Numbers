//
//  RandomField.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/15/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

class RandomField: Field, ClassicFieldProtocol {
    
    private var fieldModel: RandomFieldModel { return fieldBaseModel as! RandomFieldModel }
    
    override func generateScene(value: [[Int]]?) {
        var index: Int
        var startIndex: [[Int]] = []
        
        for rowIndex in 0..<fieldModel.startRows {
            startIndex.append([])
            
            for _ in 0..<fieldModel.cols {
                index = randomIndex()
                
                startIndex[rowIndex].append(index)
            }
        }
        
        super.generateScene(value: startIndex)
    }
    
    private func randomIndex() -> Int {
        guard let ranges = fieldModel.rangeValue else {
            return Int.randomRange(min: fieldModel.minimum, max: fieldModel.maximum)
        }
        
        let random = Int.randomRange(min: 0, max: 100)
        
        for probability in ranges {
            if (probability.probability > random) {
                return probability.value
            }
        }
        
        return -1
    }
}
