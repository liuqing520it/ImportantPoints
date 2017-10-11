//
//  NSObject+KVO.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/10/11.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import Foundation

let observerKey = "observer"

extension NSObject{
    
    func LQ_addObserver(_ observer: NSObject, forKeyPath keyPath: String, options: NSKeyValueObservingOptions = [], context: UnsafeMutableRawPointer?){
        
        objc_setAssociatedObject(self, observerKey, observer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        object_setClass(self, NSKVONotifyingSon.self)
        
    }

}

