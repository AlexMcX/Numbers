//
//  UserDataJSONProtocol.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/1/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import Foundation

class UserData: NSObject, Decodable {
    private enum UserDataError: Error {
        case customDecodeError(String)
    }
    
    override init() {
        super.init()
    }
    
    func customDecode(value: String) throws {
        throw UserDataError.customDecodeError(" ⛔️ Don't decode data: \(value)")
    }
}
