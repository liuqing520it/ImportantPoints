//
//  Person.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/10/11.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class Person: NSObject {
    ///在写swift的KVO的过程中，被监听的属性必须用“dynamic”修饰，否则监听的代理方法不走。
    @objc dynamic var name : String?
    
}
