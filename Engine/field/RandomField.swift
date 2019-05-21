//
//  RandomField.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/15/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

class RandomField: Field {
    
    private var fieldModel: RandomFieldModel { return fieldBaseModel as! RandomFieldModel }
    
    override func generateScene(value: [[Int]]?) {        
        var index: Int
        var startIndex: [[Int]] = []
        
        for rowIndex in 0..<fieldModel.startRows {
            startIndex.append([])
            
            for _ in 0..<fieldModel.cols {
                index = fieldModel.generateIndex()
                
                startIndex[rowIndex].append(index)
            }
        }
        
        super.generateScene(value: startIndex)
    }
}
