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
        
        /*
         // 1.自定义NSKVONotifyingSon子类
         // 2.重写setName,在内部恢复父类做法,通知观察者
         // 3.如何让外界调用自定义Person类的子类方法: - 修改当前对象的isa指针,指向NSKVONotifyingSon
         */
        
        //保存观察者对象
        objc_setAssociatedObject(self, observerKey, observer, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        
        //修改isa指针 让其指向子类
        object_setClass(self, NSKVONotifyingSon.self)
        
    }

}

