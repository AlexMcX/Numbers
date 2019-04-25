//
//  Block+CoreDataProperties.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//
//

import Foundation
import CoreData


extension Block {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Block> {
        return NSFetchRequest<Block>(entityName: "Block")
    }

    @NSManaged public var id: String
    @NSManaged public var receivedStars: Int16

}
