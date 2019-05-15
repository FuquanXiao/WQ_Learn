//
//  ViewController.swift
//  BoundsFrame
//
//  Created by apple on 2019/5/10.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

     var redView:UIView!;
     var cyanView:UIView!;
     var orangeView:UIView!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redView = UIView.init(frame: CGRect.init(x: 100, y: 100, width: 300, height: 300));
        redView.backgroundColor = UIColor.red;
        self.view.addSubview(redView);
        
        orangeView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 200, height: 200));
        orangeView.backgroundColor = UIColor.orange;
        redView.addSubview(orangeView);
        
        cyanView = UIView.init(frame: CGRect.init(x: 20, y: 20, width: 100, height: 100));
        cyanView.backgroundColor = UIColor.cyan;
        orangeView.addSubview(cyanView);
        
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        redView.bounds = CGRect.init(x: 20, y: 20, width: 300, height: 300);
        
//        cyanToRedRect    CGRect    (origin = (x = 20, y = 20), size = (width = 100, height = 100))    redView
        
//        cyanToRedRect    CGRect    (origin = (x = -80, y = -80), size = (width = 100, height = 100))  self.view.
        
        var  cyanToRedRect = self.orangeView.convert(cyanView.frame, to: redView);
        
        
        
        
        
    }


}

