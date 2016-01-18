//
//  MainViewController.swift
//  TakePhoto
//
//  Created by Sebastiao Gazolla Costa Junior on 11/01/16.
//  Copyright © 2016 Sebastiao Gazolla Costa Junior. All rights reserved.
//

import UIKit
import MobileCoreServices

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var takePhotoButton:UIButton?
    var listPhotoButton:UIButton?
    var imageView: UIImageView?
    var newMedia: Bool?

    override func viewDidLoad() {
        super.viewDidLoad()

        NSNotificationCenter.defaultCenter().addObserver(self, selector: "selectedPhoto:", name: "selectedPhoto", object: nil)
        
        self.takePhotoButton = UIButton.makeButton("Take Photo", tag: 222, hasBackground: true, target: self)
        self.view.addSubview(self.takePhotoButton!)
        self.view.addConstraints(takePhotoButton!.constrainToTopOfSuperView(200))
        self.view.addConstraints(takePhotoButton!.centerHorizontallyTo(self.view))
        self.view.addConstraints(takePhotoButton!.constrainWidth(200))
        self.view.addConstraints(takePhotoButton!.constrainHeight(50))
        
        self.listPhotoButton = UIButton.makeButton("List Photo", tag: 221, hasBackground: true, target: self)
        self.view.addSubview(self.listPhotoButton!)
        self.view.addConstraints(listPhotoButton!.anchorToBottom(self.takePhotoButton!, padding: 50))
        self.view.addConstraints(listPhotoButton!.centerHorizontallyTo(self.view))
        self.view.addConstraints(listPhotoButton!.constrainWidth(200))
        self.view.addConstraints(listPhotoButton!.constrainHeight(50))
        
    }
    
    func selectedPhoto(notification:NSNotification){
        
    }
    
    func btnTapped(sender:UIButton){
        
        if sender.tag == 222 {
            self.showImagePicker()
        } else if sender.tag == 221 {
            self.showImageList()
        }
     }

    func showImageList(){
        let imageList = ImageListController()
        let navCtrl = UINavigationController(rootViewController: imageList)
        self.presentViewController(navCtrl, animated: true) {}
    }
    
    func showImagePicker(){
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
                
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.Camera
                imagePicker.allowsEditing = false
                imagePicker.mediaTypes = [kUTTypeImage as String]
                self.presentViewController(imagePicker, animated: true,
                    completion: nil)
                newMedia = true
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo:UnsafePointer<Void>) {
        if error == nil {
            let ac = UIAlertController(title: "Saved!", message: "Your altered image has been saved to your photos.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        } else {
            let ac = UIAlertController(title: "Save error", message: error?.localizedDescription, preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
       
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType == (kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
           // picker.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                    "image:didFinishSavingWithError:contextInfo:", nil)
            } else if mediaType == (kUTTypeMovie as String) {
                // Code to support video here
            }
            
        }

        
    }

 
}
