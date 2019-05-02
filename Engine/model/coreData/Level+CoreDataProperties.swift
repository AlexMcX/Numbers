//
//  Level+CoreDataProperties.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/1/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//
//

import Foundation
import CoreData


extension Level {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Level> {
        return NSFetchRequest<Level>(entityName: "Level")
    }

    @NSManaged public var id: String?
    @NSManaged public var blockID: String?
    @NSManaged public var receivedStars: Int16

}
