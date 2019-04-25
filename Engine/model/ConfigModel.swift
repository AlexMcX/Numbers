//
//  InfoModel.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/22/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import DependencyInjection

public class ConfigModel: INJInstanceModel, Codable {
    var levelStarsMax: Int
    var blockConfig: [Block]
    
    enum CodingKeys: String, CodingKey {
        case levelStarsMax = "Max level stars"
        case blockConfig = "Block Configuration"
    }
    
    public struct Block: Codable {
        let id: String
        let title: String
        let levels: [Level]
        let availableStars: Int
        let unlockStars: Int
        
        enum CodingKeys : String, CodingKey {
            case id = "ID"
            case title = "Title"
            case levels = "Levels"
            case availableStars = "Available stars"
            case unlockStars = "Unlock stars"
        }
    }
    
    public struct Level: Codable {
        let id: String
        let title: String
        let rows: Int
        let cols: Int
        
        enum CodingKeys : String, CodingKey {
            case id = "ID"
            case title = "Title"
            case rows = "Rows"
            case cols = "Cols"
        }
    }
}
