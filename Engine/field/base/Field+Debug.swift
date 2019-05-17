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
//        simulateStep()
    }
    
    private func simulateStep() {
        if isEndGame { return }
        
        let tiles = help()
        
        if tiles.count > 0 {
            step(tiles: tiles)
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                self.simulateStep()
            }
            
            printFull("STEP - [\(tiles[0].id), \(tiles[1].id)]")
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
        var row:Array<Tile?>
        
        result = "************* Field Engine *************";
        result += prefix != "" ? "\n \(prefix)" : "";
        
        positions = ""
        
        for i in 0..<sceneBaseModel.field.count {
             result += "\n";
            
            if let viewRow = sceneBaseModel.view.firstIndex(of: i) {
                result += "v:\(viewRow)"
            }else {
                result += "v:-"
            }
            
            result += "|f:\(i)"
            
            row = sceneBaseModel.field[i]
            
            for tile in row {
                if tile != nil {
                    if (tile!.isSuccess) {
                        result += "|✅id:\(tile!.id) idx:\(tile!.index) (\(tile!.position.row),\(tile!.position.col))"
                    }else{
                        result += "|  id:\(tile!.id) idx:\(tile!.index) (\(tile!.position.row),\(tile!.position.col))"
                    }
                    
                    result += tile!.id < 10 ? " |" : "|"
                    
                    positions += "{id:\(tile!.id), r:\(tile!.position.row), c:\(tile!.position.col)}, ";
                }else{
                    result += "|       null        |";
                }
            }
        }
        
        result += "\n*****************************************";
        
        print(result);
    }

    
    
    
    
    
    
    
//    internal func printField(_ prefix: String = "") {
//        var positions:String
//        var result:String
//        var row:Array<Tile?>?
//        var viewRow:Int
//
//        result = "************* Field Engine *************";
//        result += prefix != "" ? "\n \(prefix)" : "";
//
//        positions = ""
//
//        for i in 0..<sceneBaseModel.view.count {
//            viewRow = sceneBaseModel.view[i];
//
//            result += "\n";
//            result += "v:\(i)|f:\(sceneBaseModel.view[i])) "
//
//            if viewRow < sceneBaseModel.field.count {
//                row = sceneBaseModel.field[viewRow];
//
//
//
//                for j in 0..<row!.count {
//                    if row![j] != nil {
//                        if (row![j]!.isSuccess) {
//                            result += "|✅id:\(row![j]!.id) idx:\(row![j]!.index) (\(row![j]!.position.row),\(row![j]!.position.col))"
//                        }else{
//                             result += "|  id:\(row![j]!.id) idx:\(row![j]!.index) (\(row![j]!.position.row),\(row![j]!.position.col))"
//                        }
//
//                        result += row![j]!.id < 10 ? " |" : "|"
//
//                        positions += "{id:\(row![j]!.id), r:\(row![j]!.position.row), c:\(row![j]!.position.col)}, ";
//                    }else{
//                        result += "|       null        |";
//                    }
//                }
//            }else {
//                result += "NULL IN FIELD";
//            }
//        }
//
//        result += "\n*****************************************";
//
//        print(result);
//    }
    
    internal func printView(_ prefix: String = "") {        
        print("\(prefix) FieldEngine::view: \(sceneBaseModel.view.description)");
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
