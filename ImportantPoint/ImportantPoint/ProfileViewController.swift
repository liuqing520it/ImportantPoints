//
//  ProfileViewController.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/9/20.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

let headerViewHeight : CGFloat = 200

class ProfileViewController: UIViewController {

    fileprivate lazy var titleLabel : UILabel = {
        let label = UILabel()
        label.text = "个人中心"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = UIColor(white: 1.0, alpha: 0.0)
        label.sizeToFit()
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        setupUI()
    }
    
    //MARK: - 内部控制方法
    ///设置导航栏
    func setupNavigationBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        navigationItem.titleView = titleLabel
    }
    ///添加子视图
    func setupUI(){
        view.addSubview(tableView)
        
        view.addSubview(headerView)
        headerView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.height.equalTo(headerViewHeight)
        }
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        
        tableView.contentInset = UIEdgeInsets(top: headerViewHeight, left: 0, bottom: 0, right: 0)
    }
    
    //MARK: - 懒加载
    fileprivate lazy var headerView : HeaderView = HeaderView()
    
    private lazy var tableView : UITableView = {
       let tv = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
}

//MARK: - tableView代理方法和数据源方法
extension ProfileViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(UITableViewCell.self)", for: indexPath)
        cell.textLabel?.text = "\(ProfileViewController.self)----\(indexPath.row)"
        cell.backgroundColor = UIColor.randomColor
        return cell
    }
    
    ///监听滚动
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //1.取出 tableview的内边距
        let contentOffset = scrollView.contentOffset.y
        //2.取出差值
        let delatOffset  = contentOffset - (-headerViewHeight)
        //3.计算头部视图的高度
        var h = headerViewHeight - delatOffset
        
        if h < navigationStatusBarHeight {
            h = navigationStatusBarHeight
        }

        //4.更改头部视图的高度
        headerView.snp.updateConstraints { (make) in
            make.height.equalTo(h)
        }
        
        //计算alpha值
        var alpha = delatOffset / (headerViewHeight - navigationStatusBarHeight)
        
        if alpha > 1.0 {
            alpha = 1.0
        }
        
        setNavigationBackButton(alpha >= 1.0)
        
        navigationController?.navigationBar
        .setBackgroundImage(UIImage.imageWithColor(color: UIColor(white: 1.0, alpha: alpha)), for: .default)
        titleLabel.textColor = UIColor(white: 0.0, alpha: alpha)
    }
    
    ///设置导航栏返回按钮
    func setNavigationBackButton(_ isSelected : Bool){
        let navi = navigationController as? IPNavigationViewController
        navi?.backButton.isSelected = isSelected
    }
    
}
