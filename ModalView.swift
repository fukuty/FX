//
//  ModalView.swift
//  FX
//
//  Created by 福田 翔 on 2016/07/01.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit
@objc protocol ModalViewDelegate {
    func modalView(view: UIImageView)
}
class ModalView: UIView, UITextFieldDelegate {
    weak var customDelegate: ModalViewDelegate?
    
    let MyVIew = UIView()
    let TextField = UITextField()
    let Image = UIImage()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        makeMyView()
        makeTextField()
        TextField.delegate = self
        
    }
    
    func makeMyView() {
        MyVIew.frame.size = CGSizeMake(300, 300)
        MyVIew.center = self.center
        MyVIew.backgroundColor = UIColor.greenColor()
        self.addSubview(MyVIew)
    }
    func makeTextField() {
        TextField.placeholder = "投稿する"
        TextField.textAlignment = NSTextAlignment.Center
        TextField.frame = CGRectMake(65, 50, 170, 30)
        MyVIew.addSubview(TextField)
    }
    func makeUIImage() {
        
    }
    func makeCloseBtn() {
        let button = UIButton()
        button.setTitle("Close", forState: UIControlState.Normal)
        button.setTitleColor(UIColor.blueColor(), forState: UIControlState.Normal)
        button.addTarget(self, action: #selector(ModalView.tappedBtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        MyVIew.addSubview(button)
    }
    func tappedBtn(sender: UIButton) {
        customDelegate?.modalView(.text!)
        self.removeFromSuperview()
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
   
}
