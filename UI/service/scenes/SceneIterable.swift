//
//  Scene.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/20/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

public protocol SceneIterable {
    var fileName: String { get }
    var viewClass: BaseView.Type { get }
    var controllerClass: BaseController.Type { get }
}
