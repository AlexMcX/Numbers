//
//  InfoModel.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/22/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import DependencyInjection

public class ConfigModel: NSObject, Codable, INJInjectableInstance {
    public let levelStarsMax: Int
    public let blockStarsMax: Int
    public let blockConfig: [Block]
    
    enum CodingKeys: String, CodingKey {
        case levelStarsMax = "Max level stars"
        case blockStarsMax = "Max block stars"
        case blockConfig = "Block Configuration"
    }
    
    public struct Block: Codable {
        public let id: String
        public let title: String
        public let levels: [Level]
        public let unlockStars: Int
        
        enum CodingKeys : String, CodingKey {
            case id = "ID"
            case title = "Title"
            case levels = "Levels"
            case unlockStars = "Unlock stars"
        }
    }
    
    public struct Level: Codable {
        public let id: String
        public let title: String
        public let gamePlay: String
        
        enum CodingKeys : String, CodingKey {
            case id = "ID"
            case title = "Title"
            case gamePlay = "Gameplay type"
        }
    }
    
    public func onInitialize(){}
    public func onDeinitialize(){}
}
