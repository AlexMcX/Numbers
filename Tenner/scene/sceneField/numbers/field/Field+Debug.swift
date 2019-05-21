//
//  Field+Debug.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/18/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

extension Field {
    internal func startDebug() {
        //        simulateStep()
    }
    
    private func simulateStep() {
        let tiles = engineField.help()
        
        if tiles.count > 0 {
            engineField.step(tiles: tiles)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.simulateStep()
            }
            
            printFull("STEP - [\(tiles[0].id), \(tiles[1].id)]")
        }
    }
    
    internal func printFull(_ prefix: String = "") {
        print("\n************************* \(prefix) *************************")
        printField()
        print("\n")
    }
    
    internal func printField(_ prefix: String = "") {
        var positions:String
        var result:String
        var row:Array<Tile?>
        
        result = "************* Field Engine *************";
        result += prefix != "" ? "\n \(prefix)" : "";
        
        positions = ""
        
        for i in 0..<field.count {
            result += "\n";
            
            result += "\(i))"
            
            row = field[i]
            
            for tile in row {
                if tile != nil {
                    if (tile!.model!.isSuccess) {
                        result += "|✅id:\(tile!.model!.id) idx:\(tile!.model!.index) (\(tile!.model!.position.row),\(tile!.model!.position.col))"
                    }else{
                        result += "|  id:\(tile!.model!.id) idx:\(tile!.model!.index) (\(tile!.model!.position.row),\(tile!.model!.position.col))"
                    }
                    
                    result += tile!.model!.id < 10 ? " |" : "|"
                    
                    positions += "{id:\(tile!.model!.id), r:\(tile!.model!.position.row), c:\(tile!.model!.position.col)}, ";
                }else{
                    result += "|       null        |";
                }
            }
        }
        
        result += "\n*****************************************";
        
        print(result);
    }
}
