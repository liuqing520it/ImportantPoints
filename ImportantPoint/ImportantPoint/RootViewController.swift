//
//  RootViewController.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/9/16.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    let btnTag = 328492
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            btn.backgroundColor = randomColor;
            btn.setTitle(titleArray[i], for: .normal)
            btn.setTitleColor(UIColor.red, for: .normal)
            btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
            btn.tag = i + btnTag
            btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
            view.addSubview(btn)
        }
    }
    
    @objc private func btnClick(btn : UIButton){
     
        if btn.tag == btnTag{
            navigationController?.pushViewController(HittestViewController(), animated: true)
        }
        else if btn.tag == btnTag + 1{
            navigationController?.pushViewController(ThreadViewController(), animated: true)
        }
        else if btn.tag == btnTag + 2{
            navigationController?.pushViewController(ProfileViewController(), animated: true)
        }
    }
    
}
