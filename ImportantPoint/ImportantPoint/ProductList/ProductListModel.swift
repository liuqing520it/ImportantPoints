//
//  ProductListModel.swift
//  ProductListView
//
//  Created by liuqing on 2017/10/8.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class ProductListModel: NSObject {

    @objc var goods_id : String?
    @objc var good_img : String?
    @objc var sale_price : String?
    @objc var cost_price : String?
    @objc var good_title : String?
    @objc var pay_count : String?
    
    init(_ dic : [String: Any]) {
        super.init()
        setValuesForKeys(dic)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        print(key)
    }
    
}
