//
//  toukouViewController.swift
//  FX
//
//  Created by 福田 翔 on 2016/07/02.
//  Copyright © 2016年 sho. All rights reserved.
//

import UIKit

class toukouViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, UITextViewDelegate {

    @IBOutlet weak var selectImageView: UIImageView!
    @IBOutlet weak var myText: UITextView!
    
        override func viewDidLoad() {
        super.viewDidLoad()
            self.myText.delegate = self
            
            let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
            kbToolBar.barStyle = UIBarStyle.Default  // スタイルを設定
            
            kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
            
            // スペーサー
            let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
            
            // 閉じるボタン
            let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "commitButtonTapped")
            
            
            kbToolBar.items = [spacer, commitButton]
            
            
            myText.inputAccessoryView = kbToolBar

            
            
//            let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(toukouViewController.tapGesture(_:)))
//            self.view.addGestureRecognizer(tapRecognizer)

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
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        let image = info[UIImagePickerControllerEditedImage] as? UIImage
        let imageView = UIImageView()
        imageView.image = image
        selectImageView.addSubview(imageView)
        let imageData: NSData = UIImagePNGRepresentation(image!)!
        let targetFile = NCMBFile.fileWithData(imageData)
        
        var saveError: NSError? = nil
        let obj: NCMBObject = NCMBObject(className: "test")
        obj.setObject(targetFile.name, forKey: "filename")
        obj.save(&saveError)
        
        //ファイルはバックグラウンド実行をする
        targetFile.saveInBackgroundWithBlock({ (error: NSError!) -> Void in
            
            if error == nil {
                //                print("画像データ保存完了: \(targetFile.name!)")
            } else {
                print("アップロード中にエラーが発生しました: \(error)")
            }
            
            }, progressBlock: { (percentDone: Int32) -> Void in
                
                // 進捗状況を取得します。保存完了まで何度も呼ばれます
                //                print("進捗状況: \(percentDone)% アップロード済み")
        })
        
        if saveError == nil {
            
        } else {
            
        }
        
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toukouBtn(sender: UIButton) {
    }
    //mytextキーボードを閉じるメソッド
    func commitButtonTapped (){
        self.view.endEditing(true)
    }
    
    
}
