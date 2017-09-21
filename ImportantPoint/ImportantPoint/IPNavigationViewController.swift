//
//  IPNavigationViewController.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/9/21.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class IPNavigationViewController: UINavigationController {

    var backButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    ///重写push方法 设置导航栏返回按钮
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {

        if childViewControllers.count >= 1 {
            let btn = UIButton(type: .custom)
            btn.setImage(UIImage(named:"commend_back_11x17_"), for: .normal)
            btn.setImage(UIImage(named:"capture_nav_back_highlight_14x17_"), for: .highlighted)
            btn.setImage(UIImage(named:"capture_nav_back_normal_14x17_"), for: .selected)
            btn.sizeToFit()
            btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
            let buttonItem = UIBarButtonItem(customView: btn)
            backButton = btn
            viewController.navigationItem.leftBarButtonItem = buttonItem
        }
        super.pushViewController(viewController, animated: true)
    }
    
    ///返回 按钮点击 pop
    @objc private func btnClick(){
        popViewController(animated: true)
    }
    
}
