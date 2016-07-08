//
//  TweetManager.swift
//  FX
//
//  Created by 福田 翔 on 2016/07/01.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit

class TweetManager: NSObject {
    static let sharedInstance = TweetManager()
    var tweets = Array<Tweet>() //(2)プロパティとして、複数のツイートを保持する配列tweetsを定義
    
    func fetchTweets(callback: () -> Void) {
        
        let query = NCMBQuery(className: "Tweet")
        
        query.orderByDescending("createDate")
        
        query.findObjectsInBackgroundWithBlock { (objects, error) in
            if error == nil {
                
                self.tweets = []
                
                for object in objects {
                    
                    let text = object.objectForKey("text") as! String
                    let tweet = Tweet(text: text)
                    self.tweets.append(tweet)
                    callback()
                    
                }
                
            }
            
            
            
            
        }
    }
}
