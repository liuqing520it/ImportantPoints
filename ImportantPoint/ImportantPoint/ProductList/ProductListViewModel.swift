//
//  ProductListViewModel.swift
//  ProductListView
//
//  Created by liuqing on 2017/10/8.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class ProductListViewModel: NSObject {

    lazy var productList = Array<ProductListCellViewModel>()

    ///加载数据
    func loadData(){
        guard let path = Bundle.main.path(forResource: "data.json", ofType: nil)else{
            return
        }
        guard  let dataString = try? String.init(contentsOfFile: path) else{
            return
        }
        guard let dataInfo = dataString.data(using: .utf8)else{
            return
        }
        guard let json = try? JSONSerialization.jsonObject(with: dataInfo, options: .mutableContainers)else{
            return
        }
        guard let productInfo = (json as AnyObject).object(forKey: "info") as? Array<Dictionary<String,Any>> else{
            return
        }
        for data in productInfo{
            let model = ProductListModel.init(data)
            let cellModel = ProductListCellViewModel.init(model)
            productList.append(cellModel)
        }
    }
}
