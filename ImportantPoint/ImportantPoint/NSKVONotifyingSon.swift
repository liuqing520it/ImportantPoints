//
//  NSKVONotifyingSon.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/10/11.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class NSKVONotifyingSon: Person {

    override var name: String?{
        didSet{
            let obs = objc_getAssociatedObject(self, observerKey) as? NSObject
            obs?.observeValue(forKeyPath: "name", of: self, change: nil, context: nil)
        }
    }
    
}
