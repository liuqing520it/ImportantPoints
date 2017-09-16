//
//  HittestViewController.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/9/16.
//  Copyright © 2017年 liuqing. All rights reserved.
//

//需求: 屏幕上有一个button 可拖动; 点击按钮添加一个子控件(超出父类范围的)使自控件也可点击

import UIKit

class HittestViewController: UIViewController {

    //自定义控制器的view
    override func loadView() {
        view = hitTestView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(moveButton)
        
        moveButton.frame = CGRect(x: 0, y: 0, width: 200, height: 50)
        
        moveButton.center = view.center
        
        moveButton.addTarget(self, action: #selector(btnClick(sender:)), for: .touchUpInside)
    }
    
    func btnClick(sender:UIButton){
        
        let btn = UIButton(type: .custom)
        let path = Bundle.main.path(forResource: "12.png", ofType: nil)
        let imageN = UIImage(contentsOfFile: path!)
        let pathHighlighted = Bundle.main.path(forResource: "qiuqiu.jpeg", ofType: nil)
        let imageH = UIImage(contentsOfFile: pathHighlighted!)
        btn.setImage(imageN, for: .normal)
        btn.setImage(imageH, for: .highlighted)

        btn.frame = CGRect(x: 0, y: moveButton.frame.height, width: 200, height: 200)
        
        moveButton.childButton = btn
        
        sender.addSubview(btn)
    }
    
    //MARK: - 懒加载
    private lazy var moveButton : MoveButton = {
        let btn = MoveButton(type: .custom)
        btn.setTitleColor(UIColor.brown, for: .normal)
        btn.setTitle("点我拖动", for: .normal)
        btn.backgroundColor = UIColor.red
        return btn
    }()

    private lazy var hitTestView = HittestView(frame: UIScreen.main.bounds)
    
}
