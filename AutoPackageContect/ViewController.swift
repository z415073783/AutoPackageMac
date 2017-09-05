//
//  ViewController.swift
//  AutoPackageContect
//
//  Created by zlm on 2017/9/4.
//  Copyright © 2017年 Yealink. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let label = NSTextField()
        label.stringValue = "打包系统运行中..."
        view.addSubview(label)
        
        
        
        
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

