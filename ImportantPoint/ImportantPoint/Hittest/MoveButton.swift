//
//  MoveButton.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/9/16.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class MoveButton: UIButton {
    
    ///移动按钮的子类
    var childButton : UIButton = {
        let btn = UIButton(type: .custom)
        let path = Bundle.main.path(forResource: "12.png", ofType: nil)
        let imageN = UIImage(contentsOfFile: path!)
        let pathHighlighted = Bundle.main.path(forResource: "qiuqiu.jpeg", ofType: nil)
        let imageH = UIImage(contentsOfFile: pathHighlighted!)
        btn.setImage(imageN, for: .normal)
        btn.setImage(imageH, for: .highlighted)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(childButton)
    }
    
    //在这个方法中 frame才会有准确的值
    override func layoutSubviews() {
        super.layoutSubviews()
        childButton.frame = CGRect(x: 0, y: frame.height, width: 200, height: 200)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        ///将点击的点转换为子控件所在的坐标系
        let childPoint = convert(point, to: childButton)

        ///判断点击的这个点是否在 子控件的身上 
        ///如果在 就返回子类
        if childButton.point(inside: childPoint, with: event) {
            return childButton
        }
        else{///如果不在 就按系统的做法
            return super.hitTest(point, with: event)
        }
    }
    
    
    //拖动按钮
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = (touches as NSSet).allObjects.last
         // 获取当前点
        let curP = (touch as! UITouch).location(in: self)
        // 获取上一个点
        let preP = (touch as! UITouch).previousLocation(in: self)
        
        transform = self.transform.translatedBy(x: curP.x - preP.x, y: curP.y - preP.y)
        
    }

}
