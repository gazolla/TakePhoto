//
//  MainViewController.swift
//  TakePhoto
//
//  Created by Sebastiao Gazolla Costa Junior on 11/01/16.
//  Copyright © 2016 Sebastiao Gazolla Costa Junior. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var takePhotoButton:UIButton?
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

    }
    
    func selectedPhoto(notification:NSNotification){
        
    }
    
    func btnTapped(sender:UIButton){
        
        if UIImagePickerController.isSourceTypeAvailable(
            UIImagePickerControllerSourceType.Camera) {
                
                let imagePicker = UIImagePickerController()
                
                imagePicker.delegate = self
                imagePicker.sourceType =
                    UIImagePickerControllerSourceType.Camera
                imagePicker.allowsEditing = false
                
                self.presentViewController(imagePicker, animated: true, 
                    completion: nil)
                newMedia = true
        }
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
       
        let mediaType = info[UIImagePickerControllerMediaType] as! String
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        if mediaType.isEqualToString(kUTTypeImage as! String) {
            let image = info[UIImagePickerControllerOriginalImage]
                as! UIImage
            
            imageView.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self,
                    "image:didFinishSavingWithError:contextInfo:", nil)
            } else if mediaType.isEqualToString(kUTTypeMovie as! String) {
                // Code to support video here
            }
            
        }

        
    }

 
}
