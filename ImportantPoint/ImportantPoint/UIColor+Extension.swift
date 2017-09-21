//
//  UIColor+Extension.swift
//  BaiSiBuDeJie
//
//  Created by liuqing on 2017/9/20.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

extension UIColor {
    
    class var randomColor : UIColor {
        get{
            return UIColor(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1.0)
        }
    }
    
}
