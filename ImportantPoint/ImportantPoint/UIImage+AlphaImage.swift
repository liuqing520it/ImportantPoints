//
//  UIImage+AlphaImage.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/9/21.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

extension UIImage{
    
    class func imageWithColor(color : UIColor) -> UIImage {
        
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        //开启图形上下文
        UIGraphicsBeginImageContext(rect.size)
        //获取位图上下文
        let context = UIGraphicsGetCurrentContext()
        //设置填充颜色
        context?.setFillColor(color.cgColor)
        //渲染上下文
        context?.fill(rect)
        //获取渲染后的图片
        let image = UIGraphicsGetImageFromCurrentImageContext()
        //关闭图形上下文
        UIGraphicsEndImageContext()
        
        return image!
    }
    
}
