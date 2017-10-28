//
//  ProductListViewController.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/10/28.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addSubViewsAndLayout()
        
        setupNavigationRightBar()
    }
    
    
    private func setupNavigationRightBar(){
        let btn = UIButton(type: .custom)
        btn.setTitle("单列", for: .normal)
        btn.setTitle("双列", for: .selected)
        btn.setTitleColor(UIColor.gray, for: .normal)
        btn.setTitleColor(UIColor.red, for: .selected)
        btn.addTarget(self, action: #selector(btnClick(btn:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: btn)
    }
    
    @objc private func btnClick(btn: UIButton){
        btn.isSelected = !btn.isSelected
        listView.isSigleRow = !btn.isSelected
    }
    
    private func addSubViewsAndLayout(){
        view.addSubview(listView)
        listView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - 懒加载
    private lazy var listView : ProductsListView = {
        let view = ProductsListView(frame: CGRect.zero)
        return view
    }()
    
  
}
