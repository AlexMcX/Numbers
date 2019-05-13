//
//  Field+D.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/12/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

#if DEBUG
extension Field {
    internal func startDebug() {
        simulateStep()
    }
    
    private func simulateStep() {
        let tiles = help()
        
        if tiles.count > 0 {
            step(tiles: tiles)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                self.simulateStep()
            }
        }
    }
    
    internal func printFull(_ prefix: String = "") {
        print("\n************************* \(prefix) *************************")
        printField()
        printView()
        prinHelp()
        print("\n")
    }
    
    internal func printField(_ prefix: String = "") {
        var positions:String
        var result:String
        var row:Array<Tile?>?
        var viewRow:Int
        
        result = "************* Field Engine *************";
        result += prefix != "" ? "\n \(prefix)" : "";
        
        positions = ""
        
        for i in 0..<sceneModel.view.count {
            viewRow = sceneModel.view[i];
            
            result += "\n";
            result += i < 10 ? "\(i)) " : "\(i))"
            
            if viewRow < sceneModel.field.count {
                row = sceneModel.field[viewRow];
                
                
                
                for j in 0..<row!.count {
                    if row![j] != nil {
                        if (row![j]!.isSuccess) {
                            result += "|✅id:\(row![j]!.id) index:\(row![j]!.index)"
                        }else{
                             result += "|  id:\(row![j]!.id) index:\(row![j]!.index)"
                        }
                        
                        result += row![j]!.id < 10 ? " |" : "|"
                        
                        positions += "{id:\(row![j]!.id), r:\(row![j]!.position.row), c:\(row![j]!.position.col)}, ";
                    }else{
                        result += "|     null      |";
                    }
                }
            }else {
                result += "NULL IN FIELD";
            }
        }
        
        result += "\n*****************************************";
        
        print(result);
    }
    
    internal func printView(_ prefix: String = "") {        
        print("\(prefix) FieldEngine::view: \(sceneModel.view.description)");
    }
    
    internal func prinHelp(_ prefix: String = "") {
        var test:String = "";
        for i in 0..<success.value.count {
            test += "[";
            
            for j in 0..<success.value[i].count {
                test += String(success.value[i][j].id) + (j < success.value[i].count - 1 ? " " : "");
            }
            
            test += "] ";
        }
        
        print("\(prefix) FieldEngine::success steps: \(test)");
    }
}
#endif
