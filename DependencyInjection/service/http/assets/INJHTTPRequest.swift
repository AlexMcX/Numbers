//
//  HTTPRequest.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 4/2/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

public class INJHTTPRequest {
    private var _route:INJRoute
    
    var route:INJRoute { return self._route };
    var parameters: [String: String]? = nil
    var headerValues: [String: String]? = nil
    
    public init(_ route: INJRoute) {
        self._route = route
    }
}
