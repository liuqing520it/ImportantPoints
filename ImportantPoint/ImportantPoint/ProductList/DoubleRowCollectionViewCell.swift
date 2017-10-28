//
//  DoubleRowCollectionViewCell.swift
//  ProductListView
//
//  Created by liuqing on 2017/10/3.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class DoubleRowCollectionViewCell: UICollectionViewCell {
    
    var viewModel : ProductListCellViewModel? {
        didSet{
            goodsImageView.kf.setImage(with: viewModel?.imageUrl)
            goodsTitleLabel.text = viewModel?.listModel?.good_title
            salePriceLabel.text = viewModel?.salePrice
            payCountLabel.text = viewModel?.payCount
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        addSubViewAndLayout()
    }
    
    //MARK: - 内部控制方法
    private func addSubViewAndLayout(){
        contentView.addSubview(goodsImageView)
        goodsImageView.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(200)
        }
        contentView.addSubview(goodsTitleLabel)
        goodsTitleLabel.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalTo(goodsImageView.snp.bottom).offset(8)
            make.right.lessThanOrEqualTo(contentView.snp.right).offset(-8)
        }
        contentView.addSubview(salePriceLabel)
        salePriceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(goodsTitleLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(8)
        }
        contentView.addSubview(payCountLabel)
        payCountLabel.snp.makeConstraints { (make) in
            make.bottom.equalTo(salePriceLabel)
            make.right.equalToSuperview().offset(-8)
        }
    }
    
    //MARK: - 懒加载
    private lazy var goodsImageView : UIImageView = {
        let imageV = UIImageView()
        imageV.contentMode = .scaleAspectFill
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    private lazy var goodsTitleLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = UIColor.gray
        label.numberOfLines = 2
        label.sizeToFit()
        return label
    }()
    
    private lazy var salePriceLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = UIColor.red
        label.sizeToFit()
        return label
    }()
    
    private lazy var payCountLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.darkText
        label.sizeToFit()
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

