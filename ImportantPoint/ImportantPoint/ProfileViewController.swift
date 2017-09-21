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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false
        
        setupNavigationBar()
        
        setupUI()
    }

//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        print(tableView.contentInset)
//    }
    
    //MARK: - 内部控制方法
    
    func setupNavigationBar(){
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupUI(){
        view.addSubview(tableView)
        
        view.addSubview(headerView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "\(UITableViewCell.self)")
        
        tableView.contentInset = UIEdgeInsets(top: headerViewHeight, left: 0, bottom: 0, right: 0)
    }
    
    //MARK: - 懒加载
    fileprivate lazy var headerView = HeaderView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: headerViewHeight))
    
    private lazy var tableView : UITableView = {
       let tv = UITableView(frame: UIScreen.main.bounds, style: .plain)
        tv.delegate = self
        tv.dataSource = self
        return tv
    }()
}

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
        //4.设置头部视图的高度
        headerView.frame.size.height = h
        
        print(h)
        
    }
}
