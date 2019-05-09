//
//  Scene.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/20/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import UI
import DependencyInjection

public enum Scene {
    case MainMenu
    case OptionMenu
    case BlocksMenu
    case LevelsMenu
    case SceneField
}

extension Scene: SceneIterable, Signalable {
    public var data: Any { return self }
    
    public var fileName: String {
        switch self {
            case .MainMenu: return "MainMenuScene"
            case .OptionMenu: return "OptionsMenuScene"
            case .BlocksMenu: return "BlocksMenuScene"
            case .LevelsMenu: return "LevelsMenuScene"
            case .SceneField: return "SceneField"
        }
    }
    
    public var viewClass: BaseView.Type {
        switch self {
            case .MainMenu: return MainMenuView.self
            case .OptionMenu: return OptionMenuView.self
            case .BlocksMenu: return BlocksMenuView.self
            case .LevelsMenu: return LevelsMenuView.self
            case .SceneField: return SceneFieldView.self
        }
    }
    
    public var controllerClass: BaseController.Type {
        switch self {
            case .MainMenu: return MainMenuController.self
            case .OptionMenu: return OptionMenuController.self
            case .BlocksMenu: return BlocksMenuController.self
            case .LevelsMenu: return LevelsMenuController.self
            case .SceneField: return SceneFieldController.self
        }
    }
}
