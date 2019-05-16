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
                index = fieldModel.rangeValue != nil ? fieldModel.rangeValue![Int.randomRange(min: 0, max: fieldModel.rangeValue!.count - 1)] : Int.randomRange(min: fieldModel.minimum, max: fieldModel.maximum)
                    
                
                startIndex[rowIndex].append(index)
            }
        }
        
        super.generateScene(value: startIndex)
    }
}
