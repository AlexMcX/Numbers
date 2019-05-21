//
//  Route.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/24/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

var HOST: String = "http://localhost:4201"

public enum INJRoute {
    case AUTH
    case LOGOUT
}

public extension INJRoute {
    var method: INJRest {
        switch self {
            case .AUTH: return INJRest.GET
            case .LOGOUT: return INJRest.POST
        }
    }
    
    var path: String {
        switch self {
            case .AUTH: return HOST + "/auth"
            case .LOGOUT: return HOST + "/logout"
        }
    }
}
