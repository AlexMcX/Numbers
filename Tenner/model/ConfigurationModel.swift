//
//  InfoModel.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/22/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import DependencyInjection

class ConfigurationModel: INJInstanceModel, Codable {
    var levelStarsMax: Int
    var blockConfig: [Block]
    
    enum CodingKeys: String, CodingKey {
        case levelStarsMax = "Max level stars"
        case blockConfig = "Block Configuration"
    }
    
    struct Block: Codable {
        let title: String
        let levels: [Level]
        
        enum CodingKeys : String, CodingKey {
            case title = "Title"
            case levels = "Levels"
        }
    }
    
    struct Level: Codable {
        let rows: Int
        let cols: Int
        
        enum CodingKeys : String, CodingKey {
            case rows = "Rows"
            case cols = "Cols"
        }
    }
}
