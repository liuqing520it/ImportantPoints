//
//  HittestView.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/9/16.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class HittestView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.orange
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        return super.hitTest(point, with: event)
    }
}
