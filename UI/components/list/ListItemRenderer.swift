//
//  ListItemRenderer.swift
//  Tenner
//
//  Created by Alexey Oleksandrovich on 4/21/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

open class ListItemRenderer: UIComponent {
    public var delegate: ListItemDelegate?
    
    override open func validate() {
        
    }
    
    override open func onDispose() {
        delegate = nil
    }
}
