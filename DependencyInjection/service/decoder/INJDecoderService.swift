//
//  INJDecoderService.swift
//  DependencyInjection
//
//  Created by Alexey Oleksandrovich on 4/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

open class INJDecoderService: INJService {
    open func create<T: Codable>(plist: String, type: T.Type, register:Bool = true) -> Codable? {
        if let url:URL = Bundle.main.url(forResource: plist, withExtension: "plist") {
            var result: Codable?
            
            if let data = try? Data(contentsOf: url) {
                let decoder = PropertyListDecoder()
                
                result = try? decoder.decode(type.self, from: data)
                
                if (result is INJInstanceModel) {
                    (result as! INJInstanceModel).register()
                }
                
                return result
            }
        }
        
        return nil
    }
}
