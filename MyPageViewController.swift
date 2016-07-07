//
//  MyPageViewController.swift
//  FX
//
//  Created by 福田 翔 on 2016/07/01.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit

class MyPageViewController: UIViewController {
    let backgroundView = UIView()
    let shareView = UIView()
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: #selector(MyPageViewController.showActionMenu))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    func showActionMenu() {
        setBackgroundView()
        setShareView()
        setShareBtn(self.view.frame.width/8 * 3, tag: 1, imageName: "facebook_icon.png")
        setShareBtn(self.view.frame.width/8 * 5, tag: 2, imageName: "twitter_icon.png")
        
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            self.shareView.frame.origin = CGPointMake(0, self.view.frame.height - 100)
        })
    }
    func setBackgroundView() {
        backgroundView.frame.size = self.view.frame.size
        backgroundView.frame.origin = CGPointMake(0, 0)
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.6)
        self.view.addSubview(backgroundView)
        let gesture = UITapGestureRecognizer(target: self, action: #selector(MyPageViewController.tapBackgroundView))
        backgroundView.addGestureRecognizer(gesture)
    }
    func setShareView(){
        shareView.frame = CGRectMake(0, self.view.frame.height, self.view.frame.width, 100)
        shareView.backgroundColor = UIColor.whiteColor()
        shareView.layer.cornerRadius = 3
        backgroundView.addSubview(shareView)
    }
    func setShareBtn(x: CGFloat, tag: Int, imageName: String){
        let shareBtn = UIButton()
        shareBtn.frame.size = CGSizeMake(60, 60)
        shareBtn.center = CGPointMake(x, 50)
        shareBtn.setBackgroundImage(UIImage(named: imageName), forState: UIControlState.Normal)
        shareBtn.layer.cornerRadius = 3
        shareBtn.tag = tag
        shareBtn.addTarget(self, action: #selector(MyPageViewController.tapSharebtn(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        shareView.addSubview(shareBtn)
    }
    func tapSharebtn(sender: UIButton) {
    }
    func tapBackgroundView(){
        backgroundView.removeFromSuperview()
    }
    
}
