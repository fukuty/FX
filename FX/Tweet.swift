//
//  Tweet.swift
//  FX
//
//  Created by 福田 翔 on 2016/07/01.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit

class Tweet: NSObject {
    var text: String
    
    init(text: String) {
        self.text = text
    }
    func save() {
        let tweetObject = NCMBObject(className: "Tweet")
        tweetObject.setObject(text, forKey: "text")
        tweetObject.saveInBackgroundWithBlock{ (error) in
            if error == nil {
        
            }
        }
    }
    
}

