//
//  TimeLineTableViewController.swift
//  FX
//
//  Created by 福田 翔 on 2016/07/01.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {

    @IBAction func pencilBtn(sender: UIButton) {
    }
    
    let tweetManager = TweetManager.sharedInstance
    let Mytext = UITextView()
    let myView = UIView()
    var postImages : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        
        
    }
    override func viewWillAppear(animated: Bool) {
        tweetManager.fetchTweets { () in
            self.tableView.reloadData()
    }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return tweetManager.tweets.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TweetTableViewCell", forIndexPath: indexPath) as! TweetTableViewCell
        let tweet = tweetManager.tweets[indexPath.row]
        cell.nameLabel.text = "テスト"
        cell.tweetLabel.text = tweet.text
        
        return cell
    }
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func post() {
        let tweet = Tweet(text: Mytext.text!)
    
    }
    
    func  NSfetchRequest(callback: () -> Void) {
        var tempImage : UIImage?
        let query = NCMBQuery(className: "test")
        query.orderByDescending("createDate")
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil {
                for object in  objects! {
                    let fileName : String = (object.objectForKey("filename") as? String)!
                    
                    let fileData = NCMBFile.fileWithName(fileName, data: nil) as! NCMBFile
                    
                    fileData.getDataInBackgroundWithBlock({ (imageData: NSData?, error) in
                        if error != nil {
                        } else {
                            tempImage = UIImage(data: imageData!)
                            self.postImages.append(tempImage!)
                            
                            for num in 0..<self.postImages.count {
                                let niftyImage = UIImageView()
                                niftyImage.image = self.postImages[num]
                                
//                                niftyImage.frame = CGRectMake(self.selectImageView.frame.width * CGFloat(num), 0, self.selectImageView.frame.height, self.selectImageView.frame.height)
//                                self.selectImageView.addSubview(niftyImage)
                            }
                            callback()
                        }
                    })
                }
                
            }
            
        }
    }

}