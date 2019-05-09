//
//  SettingsService.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/9/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import DependencyInjection

class SettingsService: INJDataService {
    public lazy var settings: Settings = { return getSettings() }()
    
    override open func onInit() {
        initModel(containerName: "SettingsData", entityName: "Settings", managedObjectClass: Settings.self)
    }
    
    private func getSettings() -> Settings {
        if let base = fetch() {
            if (base.count > 0) {
                return base[0] as! Settings
            }
        }
        
        return generateObject() as! Settings
    }
}
