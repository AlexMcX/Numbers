//
//  GamePlay.swift
//  Engine
//
//  Created by Alexey Oleksandrovich on 5/15/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

enum GamePlay: String {
    case Classic
    case Random
}

extension GamePlay {
    var field: Field.Type {
        switch self {
        case .Classic:
            return ClassicField.self
        case .Random:
            return RandomField.self
        }
    }
    
    var fieldModel: FieldModel.Type {
        switch self {
        case .Classic:
            return ClassicFieldModel.self
        case .Random:
            return RandomFieldModel.self
        }
    }
    
    var sceneModel: SceneModel.Type {
        switch self {
        case .Classic:
            return ClassicSceneModel.self
        case .Random:
            return RandomSceneModel.self
        }
    }
}
