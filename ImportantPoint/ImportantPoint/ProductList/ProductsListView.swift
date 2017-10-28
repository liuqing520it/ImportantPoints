//
//  ProductsListView.swift
//  ProductListView
//
//  Created by liuqing on 2017/10/2.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class ProductsListView: UIView {
    ///是否是单列 默认情况下是单列展示
    var isSigleRow : Bool = true{
        didSet{
            collectionView.reloadData()
            if isSigleRow {//切换layout, 展示单列
                collectionView.setCollectionViewLayout(flowLayoutSigle, animated: false)
            }else{//切换layout, 展示双列
                collectionView.setCollectionViewLayout(flowLayoutDouble, animated: false)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViewAndLayout()
        setupCollectionView()
        loadProductListData()
    }
    
    //MARK: - 内部控制方法
    private func setupCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SigleRowCollectionViewCell.self, forCellWithReuseIdentifier: "\(SigleRowCollectionViewCell.self)")
        collectionView.register(DoubleRowCollectionViewCell.self, forCellWithReuseIdentifier: "\(DoubleRowCollectionViewCell.self)")
    }
    
    private func addSubViewAndLayout(){
        addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    //MARK: - loadData
    private func loadProductListData(){
        viewModel.loadData()
        collectionView.reloadData()
    }
    
    //MARK: - 懒加载
    private lazy var collectionView : UICollectionView = {
       let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayoutSigle)
        collection.backgroundColor = UIColor.lightGray
        return collection
    }()

    ///单列布局
    private lazy var flowLayoutSigle : UICollectionViewFlowLayout = {
       let fly = UICollectionViewFlowLayout()
        fly.itemSize = CGSize(width: UIScreen.main.bounds.size.width, height: 125)
        fly.sectionInset = .zero
        fly.minimumLineSpacing = 10
        fly.minimumInteritemSpacing = 0
        return fly
    }()
    
    ///双列布局
    private lazy var flowLayoutDouble : UICollectionViewFlowLayout = {
       let fly = UICollectionViewFlowLayout()
        fly.itemSize = CGSize(width: (UIScreen.main.bounds.size.width - 40) * 0.5, height: 260)
        fly.sectionInset = UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15)
        fly.minimumLineSpacing = 10
        fly.minimumInteritemSpacing = 10
        return fly
    }()
    
    ///viewModel
    private lazy var viewModel = ProductListViewModel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - UICollectionView 数据源及代理方法
extension ProductsListView : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.productList.count 
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        ///根据不同的类型展示不同的cell
        if isSigleRow {
            let sigleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(SigleRowCollectionViewCell.self)", for: indexPath) as! SigleRowCollectionViewCell
            sigleCell.viewModel = viewModel.productList[indexPath.item]
            return sigleCell
        }
        else{
            let doubleCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(DoubleRowCollectionViewCell.self)", for: indexPath) as! DoubleRowCollectionViewCell
            doubleCell.viewModel = viewModel.productList[indexPath.item]
            return doubleCell
        }
    }
    
}
