//
//  LevelModel.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 4/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

open class LevelModel: Equatable {
    public var data: Level!
    public var config: ConfigModel.Level!
    public var access: Bool = true
    public var progressStars: Int = 0
    
    public static func == (lhs: LevelModel, rhs: LevelModel) -> Bool {
        return lhs.data.id == rhs.data.id
    }
}
