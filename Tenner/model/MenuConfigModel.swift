//
//  ConfigModel.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation
import DependencyInjection

class MenuConfigModel: INJInstanceModel, Codable {
    var language: [String]
}
