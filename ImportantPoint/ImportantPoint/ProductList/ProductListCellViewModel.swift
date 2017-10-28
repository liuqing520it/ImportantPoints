//
//  ProductListCellViewModel.swift
//  ProductListView
//
//  Created by liuqing on 2017/10/8.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class ProductListCellViewModel: NSObject {
    
    var listModel : ProductListModel?
    
    init(_ model : ProductListModel) {
  
        listModel = model
        
        imageUrl = URL.init(string: (model.good_img!))
        
        let saleString = model.sale_price! as NSString
        
        salePrice = "￥" + String(format:"%0.2f",saleString.floatValue)
        
        payCount = "销量:" + model.pay_count!
    }
    
    ///图片的url
    var imageUrl : URL?
    ///销售价
    var salePrice : String = ""
    ///销量
    var payCount : String = ""
    
}
