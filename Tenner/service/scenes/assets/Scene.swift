//
//  Scene.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/20/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection

public enum Scene {
    case MainMenu
    case OptionMenu
    case BlockMenu
    case LevelsMenu
}

extension Scene: SceneIterable, Signalable {
    public var data: Any { return self }
    
    var fileName: String {
        switch self {
            case .MainMenu: return "MainMenuScene"
            case .OptionMenu: return "OptionsMenuScene"
            case .BlockMenu: return "BlocksMenuScene"
            case .LevelsMenu: return "LevelsMenuScene"
        }
    }
    
    var viewClass: BaseView.Type {
        switch self {
            case .MainMenu: return MainMenuView.self
            case .OptionMenu: return OptionMenuView.self
            case .BlockMenu: return BlockMenuView.self
            case .LevelsMenu: return LevelsMenuView.self
        }
    }
    
    var controllerClass: BaseController.Type {
        switch self {
            case .MainMenu: return MainMenuController.self
            case .OptionMenu: return OptionMenuController.self
            case .BlockMenu: return BlockMenuController.self
            case .LevelsMenu: return LevelsMenuController.self
        }
    }
}
