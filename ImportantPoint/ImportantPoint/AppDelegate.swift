//
//  AppDelegate.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/9/16.
//  Copyright © 2017年 liuqing. All rights reserved.
//

/**
    ### 本人习惯: 不喜欢用xib或storyboard 
 
    对一些重要知识点的总结,实际开发中可能用到的地方非常少,但是确实很重要,很重要!面试的时候经常问到.
 **/

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.white
        window?.rootViewController = UINavigationController(rootViewController: RootViewController())
        
        //让window显示
        window?.makeKeyAndVisible()
        
        return true
    }
}

//全局变量
//随机色
let randomColor = UIColor(red:CGFloat(arc4random()%255) / 255.0, green: CGFloat(arc4random()%255) / 255.0, blue: CGFloat(arc4random()%255) / 255.0, alpha: 1.0)


