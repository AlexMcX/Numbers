//
//  UDDirection.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/2/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

class UDDirection: UserData {
    var value: Direction = Direction.none
    
    enum Direction: String, Codable {
        case none = ""
        case vertical = "vertical"
        case horizontal = "horizontal"
    }

    override func customDecode(value: String) throws {
        self.value = Direction(rawValue: value)!
    }
}
