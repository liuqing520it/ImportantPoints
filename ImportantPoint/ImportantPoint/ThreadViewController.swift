//
//  ThreadViewController.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/9/17.
//  Copyright © 2017年 liuqing. All rights reserved.
//
//实际开发中经常遇到这样一种情况: 一个页面有好几个请求,打个比方首页 需要请求头部广告, 促销,精选推荐; 需要这三个模块都请求完了才进行下一步刷新操作
//这里没有实际后台 就拿下载图片为例

import UIKit

class ThreadViewController: UIViewController {

    //最终要显示的图片大小
    private lazy var showSize = CGSize(width: UIScreen.main.bounds.size.width - 20, height: UIScreen.main.bounds.size.height - 100)
    
    private lazy var image1 = UIImage()
    private lazy var image2 = UIImage()
    
    private lazy var imageView : UIImageView = {
        let imageV = UIImageView()
        imageV.frame = CGRect(x: 10, y: 80, width: UIScreen.main.bounds.size.width - 20, height: UIScreen.main.bounds.size.height - 100)
        return imageV
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        
        view.addSubview(imageView)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        gcdGroup1()
        operation()
    
    }
    
    //MARK: - 使用GCD实现 第一种方式
    private func gcdGroup1(){
        //创建组
        let group = DispatchGroup()
        //创建队列
        let globalQueue = DispatchQueue.global()
        //下载第一张图片
        __dispatch_group_async(group, globalQueue) { 
            guard let url = URL(string: "http://img2.ph.126.net/REHyw0wOVk-u6bqS0JsrMA==/6598211059727802272.jpg") else{
                return
            }
            //耗时操作
            guard let data = try? Data.init(contentsOf: url)else{
                return
            }
            self.image1 = UIImage.init(data: data)!
            
            printCtm(Thread.current)
        }
        
        //下载第二张图片
        __dispatch_group_async(group, globalQueue) {
            guard let url = URL(string: "http://s4.sinaimg.cn/mw690/4298e839gde2ed6a111e3&690") else{
                return
            }
            //耗时操作
            guard let data = try? Data.init(contentsOf: url)else{
                return
            }
            self.image2 = UIImage.init(data: data)!
            
            printCtm(Thread.current)
        }
        
        //下载完成之后合成一张新的图片
        __dispatch_group_notify(group, globalQueue) {
             printCtm(Thread.current)
            //获取图形上下文
            UIGraphicsBeginImageContext(self.showSize)
            //图片1
            self.image1.draw(in: CGRect(x: 0, y: 0, width: self.showSize.width, height: self.showSize.height * 0.5))
            //图片2
            self.image2.draw(in: CGRect(x: 0, y: self.showSize.height * 0.5, width: self.showSize.width, height: self.showSize.height * 0.5))
            //通过上下文得到一张图片
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            //关闭图形上下文
            UIGraphicsEndImageContext()
            //回到主线程显示图片
            DispatchQueue.main.async {
                self.imageView.image = resultImage
                 printCtm(Thread.current)
            }
        }
    
    }
    
    //MARK: - 使用GCD的第二种方法
    private func gcdGroup2(){
        //创建组
        let group = DispatchGroup()
        //创建队列
        let globalQueue = DispatchQueue.global()
        //下载第一张图片
        group.enter()
        
        globalQueue.async {

            guard let url = URL(string: "http://s3.sinaimg.cn/mw690/003CgyILty6SBlnlRvQf2&690") else{
                return
            }
            //耗时操作
            guard let data = try? Data.init(contentsOf: url)else{
                return
            }
            self.image1 = UIImage.init(data: data)!
            
            printCtm(Thread.current)
            
            group.leave()
        }
        
        //下载第二张图片
        group.enter()
        
        globalQueue.async {
            
            guard let url = URL(string: "http://4493bz.1985t.com/uploads/allimg/151219/1-151219104536.jpg") else{
                return
            }
            //耗时操作
            guard let data = try? Data.init(contentsOf: url)else{
                return
            }
            self.image2 = UIImage.init(data: data)!
            
            printCtm(Thread.current)
            
            group.leave()
        }
        
        //下载完成之后合成一张新的图片
        group.notify(queue: globalQueue) { 
            printCtm(Thread.current)
            //获取图形上下文
            UIGraphicsBeginImageContext(self.showSize)
            //下载图片1
            self.image1.draw(in: CGRect(x: 0, y: 0, width: self.showSize.width, height: self.showSize.height * 0.5))
            //下载图片2
            self.image2.draw(in: CGRect(x: 0, y: self.showSize.height * 0.5, width: self.showSize.width, height: self.showSize.height * 0.5))
            //通过上下文得到一张图片
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            //关闭图形上下文
            UIGraphicsEndImageContext()
            //回到主线程显示图片
            DispatchQueue.main.async {
                self.imageView.image = resultImage
                printCtm(Thread.current)
            }
        }
    }
    
    ///MARK: - 使用NSOpretion
    private func operation(){
        //创建队列 全局队列
        let operaQueue = OperationQueue()
        //设置队列的maxConcurren 如果是1 则串行队列 大于1则为并发队列
        operaQueue.maxConcurrentOperationCount = 3;
        
        //下载图片1
        let blockOperation1 = BlockOperation {
            guard let url = URL(string: "http://s3.sinaimg.cn/mw690/003CgyILty6SBlnlRvQf2&690") else{
                return
            }
            //耗时操作
            guard let data = try? Data.init(contentsOf: url)else{
                return
            }
            self.image1 = UIImage.init(data: data)!
            
            printCtm(Thread.current)
        }
        
        //下载图片2
        let blockOperation2 = BlockOperation {
            guard let url = URL(string: "http://4493bz.1985t.com/uploads/allimg/151219/1-151219104536.jpg") else{
                return
            }
            //耗时操作
            guard let data = try? Data.init(contentsOf: url)else{
                return
            }
            self.image2 = UIImage.init(data: data)!
            
            printCtm(Thread.current)
        }
       
        //将操作添加到队列
        operaQueue.addOperation(blockOperation1)
        operaQueue.addOperation(blockOperation2)
        
        //添加依赖 图片2依赖于图片1  即图片1下载完了之后才能下载图片2
        blockOperation2.addDependency(blockOperation1)
        
        //图片2 下载操作执行完之后
        blockOperation2.completionBlock = { () in
            printCtm(Thread.current)
            //获取图形上下文
            UIGraphicsBeginImageContext(self.showSize)
            //图片1
            self.image1.draw(in: CGRect(x: 0, y: 0, width: self.showSize.width, height: self.showSize.height * 0.5))
            //图片2
            self.image2.draw(in: CGRect(x: 0, y: self.showSize.height * 0.5, width: self.showSize.width, height: self.showSize.height * 0.5))
            //通过上下文得到一张图片
            let resultImage = UIGraphicsGetImageFromCurrentImageContext()
            //关闭图形上下文
            UIGraphicsEndImageContext()
            //回到主线程显示图片
            OperationQueue.main.addOperation{
                self.imageView.image = resultImage
                printCtm(Thread.current)
            }
        }
    }
}
