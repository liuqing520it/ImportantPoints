//
//  KVOViewController.swift
//  ImportantPoint
//
//  Created by liuqing on 2017/10/11.
//  Copyright © 2017年 liuqing. All rights reserved.
//

import UIKit

class KVOViewController: UIViewController {

    @objc var person = Person()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.randomColor

        person.LQ_addObserver(self, forKeyPath: "name", options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(person.name!)
    }
    
    static var i = 0
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        KVOViewController.i += 1
        
        person.name = String(format: "%d",KVOViewController.i)
    }
    
}
