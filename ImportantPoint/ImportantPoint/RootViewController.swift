//
//  RootViewController.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/9/16.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

enum ControllersTag : Int{
    case hitTestController = 234
    case threadController
    case profileController
}

class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = UIColor.randomColor
        
        addSubView()
    }
    
    private func addSubView(){
        let btnH : CGFloat = 50
        var originY: CGFloat = 0
        let originX : CGFloat = 20
        let btnW = UIScreen.main.bounds.size.width - originX * 2
        
        let titleArray = ["hittest应用","多线程应用","个人中心展示"]
        
        for i in 0..<titleArray.count {
            originY = 84 + (btnH + 20) * CGFloat(i)
            
            let btn = UIButton(type: .custom)
            btn.frame = CGRect(x: originX, y: originY, width: btnW, height: btnH)
            btn.backgroundColor = UIColor.randomColor;
            btn.setTitle(titleArray[i], for: .normal)
            btn.setTitleColor(UIColor.red, for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            btn.tag = i + ControllersTag.hitTestController.rawValue
            btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
            view.addSubview(btn)
        }
    }
    
    @objc private func btnClick(btn : UIButton){
     
        if btn.tag == ControllersTag.hitTestController.rawValue{
            navigationController?.pushViewController(HittestViewController(), animated: true)
        }
        else if btn.tag == ControllersTag.threadController.rawValue{
            navigationController?.pushViewController(ThreadViewController(), animated: true)
        }
        else if btn.tag == ControllersTag.profileController.rawValue{
            navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }
    
}
