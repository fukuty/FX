//
//  TimeLineTableViewController.swift
//  FX
//
//  Created by 福田 翔 on 2016/07/01.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit

class TimeLineTableViewController: UITableViewController {

    let tweetManager = TweetManager.sharedInstance
    let Mytext = UITextView()
    let myView = UIView()
    var postImages : [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.registerNib(UINib(nibName: "TweetTableViewCell", bundle: nil), forCellReuseIdentifier: "TweetTableViewCell")
        tweetManager.fetchTweets { () in
            self.tableView.reloadData()
        }
    }
    override func viewWillAppear(animated: Bool) {
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "投稿", style: .Plain, target: self, action: #selector(TimeLineTableViewController.post))
        
            }
    
    func post() {
        let tweet = Tweet(text: Mytext.text!)
        tweet.save { () in
            self.tweetManager.fetchTweets { () in
                self.tableView.reloadData()
            }
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
        return 75
    }
    func makeTextView() {
        Mytext
    }
}