//
//  toukouViewController.swift
//  FX
//
//  Created by 福田 翔 on 2016/07/02.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit

class toukouViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    var postImages : [UIImageView] = []
    var imageViews : [UIImageView] = []
    let backgroundView = UIView()
    let shareView = UIView()
    
    
    let niftyImage = UIImageView()
    
    
    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var myText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myText.delegate = self
        
        //textviewを閉じる
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.Default
        kbToolBar.sizeToFit()
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "commitButtonTapped")
        kbToolBar.items = [spacer, commitButton]
        myText.inputAccessoryView = kbToolBar

        
//        NSfetchRequest() {
//            
//        }
        
        
    }
    //mytextキーボードを閉じるメソッド
    func commitButtonTapped (){
        self.view.endEditing(true)
    }
    
    
    @IBAction func tapPhotoBtn(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let camera = UIImagePickerController()
            camera.sourceType = UIImagePickerControllerSourceType.Camera
            camera.delegate = self
            camera.allowsEditing = true
            self .presentViewController(camera, animated: true, completion: nil)
        }
    }
    
    @IBAction func tapAlbumBtn(sender: UIButton) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let album = UIImagePickerController()
            album.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            album.delegate = self
            album.allowsEditing = true
            self.presentViewController(album, animated: true, completion: nil)
        }
    }
    
    
    //カメラ画像をselectImageViewに表示・Niftyに保存
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        selectImageView.image = info[UIImagePickerControllerEditedImage] as? UIImage

        let imageView = info[UIImagePickerControllerEditedImage] as? UIImage
        let selectImageView1 = UIImageView()
        selectImageView.image = imageView
        
        let imageData: NSData = UIImagePNGRepresentation(imageView!)!
        let targetFile = NCMBFile.fileWithData(imageData)
        
        var saveError: NSError? = nil
        let obj: NCMBObject = NCMBObject(className: "test")
        obj.setObject(targetFile.name, forKey: "filename")
        obj.save(&saveError)
        
        //ファイルはバックグラウンド実行をする
        targetFile.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
            
            if error == nil {
                                print("画像データ保存完了: \(targetFile.name!)")
            } else {
                print("アップロード中にエラーが発生しました: \(error)")
            }
            
            }, progressBlock: { (percentDone: Int32) -> Void in
                
        })
        
        if saveError == nil {
            
        } else {
            
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
//    func post() {
//        let tweet = Tweet(text: myText.text!)
//        tweet.save()
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    
//    func fetchTweets(callback: () -> Void) {
//        let query = NCMBQuery(className: "Tweet")
//        query.orderByDescending("createDate")
//        query.findObjectsInBackgroundWithBlock { (objects, error) in
//            if error == nil {
//                self.tweets = []
//                for object in objects {
//                    let text = object.objectForKey("text") as! String
//                    let tweet = Tweet(text: text)
//                    self.tweets.append(tweet)
//                    callback()
//                }
//            }
//        }
//    }
    

    
//    //niftyから画像取得
//    func  NSfetchRequest(callback: () -> Void) {
//        var tempImageView : UIImageView?
//        let query = NCMBQuery(className: "test")
//        query.orderByDescending("createDate")
//        query.findObjectsInBackgroundWithBlock { (objects, error) in
//            if error == nil {
//                for object in  objects! {
//                    let fileName : String = (object.objectForKey("filename") as? String)!
//                    
//                    let fileData = NCMBFile.fileWithName(fileName, data: nil) as! NCMBFile
//                    
//                    fileData.getDataInBackgroundWithBlock({ (imageData: NSData?, error) in
//                        if error != nil {
//                        } else {
//                            let image = UIImage(data: imageData!)//データ型変換
//                            tempImageView = UIImageView(image: image)
//                            print(tempImageView)
//                            self.postImages.append(tempImageView!)
//                            print("-----------")
//                        }
//                        callback()
//                    })
//                }
//                
//                
//            }
//        }
//        
//    }
   }
