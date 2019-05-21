//
//  ListItemDelegate.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 5/5/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

public protocol ListItemDelegate: class {
    func selectItem(item: ListItemRenderer)
}
