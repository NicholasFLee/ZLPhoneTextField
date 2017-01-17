//
//  ViewController.swift
//  PhoneTextField
//
//  Created by Nicholas Lee on 2017/1/15.
//  Copyright © 2017年 Nicholas Lee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let textField = ZLPhoneTextField.init(separator: .hyphen)
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.view.addSubview(textField)
        textField.frame = CGRect.init(x: 20, y: 20, width: 200, height: 40)
        textField.borderStyle = .roundedRect
        textField.placeholder = "Phone number here"
        
        
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }


}

