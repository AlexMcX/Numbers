//
//  ListItemRenderer.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

class ListItemRenderer: UIComponent {
    public var delegate: ListItemDelegate?
    
    override public func validate() {
        
    }
    
    override func onDispose() {
        delegate = nil
    }
}
