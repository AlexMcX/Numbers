//
//  BaseView.swift
//  Shopping
//
//  Created by Alexey Oleksandrovich on 3/23/19.
//  Copyright © 2019 Alexey Oleksandrovich. All rights reserved.
//

import UIKit

open class INJView: UIViewController, INJInjectable, INJInjectableHandler {
    public convenience init() {
        self.init(nibName: nil, bundle: nil);
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
        
        initialize()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        
        initialize();
    }
    
    private func initialize() {
        injection()
        
        onInit();
    }
    
    open func onInit() {

    }
    
    open func onInjection() {
        
    }
    
    open func dispose() {
        
    }
}
