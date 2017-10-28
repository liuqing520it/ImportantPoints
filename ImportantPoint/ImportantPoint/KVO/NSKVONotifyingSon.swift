//
//  NSKVONotifyingSon.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/10/11.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class NSKVONotifyingSon: Person {

    override dynamic var name: String?{
        didSet{
            // 获取观察者
            let obs = objc_getAssociatedObject(self, observerKey) as? NSObject
            // 通知观察者调用observeValueForKeyPath
            obs?.observeValue(forKeyPath: "name", of: self, change: nil, context: nil)
        }
    }
    
}
