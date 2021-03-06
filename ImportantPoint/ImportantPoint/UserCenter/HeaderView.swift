//
//  HeaderView.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/9/20.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit
import SnapKit

class HeaderView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubViewAndLayout()
    }
    
    //MARK: - 添加子控件
    private func addSubViewAndLayout(){
        
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
       
        addSubview(avatarImageView)
        avatarImageView.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80, height: 80))
            make.bottom.equalToSuperview().offset(-navigationStatusBarHeight)
        }
        
        addSubview(useNameLabel)
        useNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(avatarImageView.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
        }
    }

    //MARK: - 懒加载
    ///背景图片
    private lazy var bgImageView : UIImageView = {
       let imageV = UIImageView()
        let path = Bundle.main.path(forResource: "qiuqiu.jpeg", ofType: nil)
        imageV.image = UIImage(contentsOfFile: path!)
        imageV.contentMode = UIViewContentMode.scaleAspectFill
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    ///头像imageView
    private lazy var avatarImageView : UIImageView = {
        let imageV = UIImageView()
        let path = Bundle.main.path(forResource: "12.png", ofType: nil)
        imageV.image = UIImage(contentsOfFile: path!)
        imageV.layer.cornerRadius = 40
        imageV.layer.masksToBounds = true
        return imageV
    }()
    
    ///用户名
    private lazy var useNameLabel : UILabel = {
       let label = UILabel()
        label.text = "趁时光还在"
        label.textColor = UIColor.darkGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.sizeToFit()
        return label
    }()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
