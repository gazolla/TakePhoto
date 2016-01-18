//
//  PhotoHandler.swift
//  TakePhoto
//
//  Created by Gazolla on 17/01/16.
//  Copyright © 2016 Sebastiao Gazolla Costa Junior. All rights reserved.
//

import UIKit

class PhotoHandler: NSObject {
    
    func getDocumentDirectory()->AnyObject{
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory: AnyObject = paths[0]
        return documentsDirectory
    }
    
    func nameGenerator()->String{
        let prefix = "Photo"
        let guid = NSProcessInfo.processInfo().globallyUniqueString
        let filename = "\(prefix)-\(guid).jpg"
        return filename
    }
    
    func savePhoto(image:UIImage){
        let imgData = UIImageJPEGRepresentation(image, 1.0)
        let documentsDirectory: AnyObject = self.getDocumentDirectory()
        let dataPath = documentsDirectory.stringByAppendingPathComponent(self.nameGenerator())
        imgData?.writeToFile(dataPath, atomically: false)
    }
    
    func loadPhoto(filename:String)->UIImage?{
        let documentsDirectory: AnyObject = self.getDocumentDirectory()
        let dataPath = documentsDirectory.stringByAppendingPathComponent(filename)
        let img = UIImage(contentsOfFile: dataPath)
        return img
    }
    
    func removePhoto(filename:String){
        let documentsDirectory: AnyObject = self.getDocumentDirectory()
        let dataPath = documentsDirectory.stringByAppendingPathComponent(self.nameGenerator())
        do {
            try NSFileManager.defaultManager().removeItemAtPath(dataPath)
        } catch {
            print("Something went wrong!")
        }
    }
    
    func listPhotos()->[String]{
        var list:[String] = []
        let documentsDirectory = self.getDocumentDirectory() as! String
        do {
            let content = try NSFileManager.defaultManager().contentsOfDirectoryAtPath(documentsDirectory)
            for c in content{
                list.append("\(c)")
            }
        } catch {
            print("Something went wrong!")
        }
        return list
    }

}
