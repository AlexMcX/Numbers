//
//  SceneModel.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/11/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

class SceneModel: Codable {
    @objc dynamic public var id:Int
//    @objc dynamic public var totalTime:Int
//    @objc dynamic public var currentTime:Int
    @objc dynamic public var price:Int
//    @objc dynamic public var rows:Int
//    @objc dynamic public var cols:Int
//    @objc dynamic public var comparisonWin:Int
//    @objc dynamic public var minValue:Int
//    @objc dynamic public var maxValue:Int
//    @objc dynamic public var startRows:Int
    @objc dynamic public var view:Array<Int>        // visible rows indexes
    @objc dynamic public var tilesIDS:Int           // last created tile id
    
    var field:Array<Array<EGTileModel?>>
    
    init() {
        id = 0
//        totalTime = 0
//        currentTime = 0
        price = 0
        view = []
        field = []
        tilesIDS = 0
    }
}
