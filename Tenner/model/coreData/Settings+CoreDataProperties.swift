//
//  Settings+CoreDataProperties.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/9/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//
//

import Foundation
import CoreData


extension Settings {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Settings> {
        return NSFetchRequest<Settings>(entityName: "Settings")
    }

    @NSManaged public var effect: Bool
    @NSManaged public var help: Bool
    @NSManaged public var language: String?
    @NSManaged public var sound: Bool

}
