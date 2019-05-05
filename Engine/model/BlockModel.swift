//
//  BlockModel.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 4/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

open class BlockModel: Equatable {
    public var data: Block!
    public var config: ConfigModel.Block!    
    public var access: Bool = true
    public var unlockStars: Int = 0
    public var progressStars: Int = 0
    
    public static func == (lhs: BlockModel, rhs: BlockModel) -> Bool {
        return lhs.data.id == rhs.data.id
    }
}
