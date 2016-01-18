//
//  ImageListController.swift
//  TakePhoto
//
//  Created by Sebastiao Gazolla Costa Junior on 13/01/16.
//  Copyright © 2016 Sebastiao Gazolla Costa Junior. All rights reserved.
//

import UIKit

class ImageListController: UIViewController , UICollectionViewDataSource, UICollectionViewDelegate,UIGestureRecognizerDelegate {

    var leftButton:  UIBarButtonItem?

    lazy var collectionView:UICollectionView = {
        var cv = UICollectionView(frame: self.view.bounds, collectionViewLayout: self.flowLayout)
        cv.delegate = self
        cv.dataSource = self
        cv.bounces = true
        cv.alwaysBounceVertical = true
        cv.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        cv.registerClass(CustomCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        cv.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)
        return cv
    }()
    
    lazy var flowLayout:UICollectionViewFlowLayout = {
        var flow = UICollectionViewFlowLayout()
        flow.sectionInset = UIEdgeInsetsMake(2.0, 20.0, 2.0, 20.0)
        return flow
    }()
    
    lazy var imgNameItems:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.collectionView)
        
        self.setupNavBar()
        self.loadImages()
    }
    
    func setupNavBar(){
        self.title = "Images:"
        self.leftButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Stop, target: self, action: "dismissTapped:")
        self.navigationItem.leftBarButtonItem = self.leftButton
    }
    
    func loadImages(){
       let ph = PhotoHandler()
       self.imgNameItems = ph.listPhotos()
       self.collectionView.reloadData()
    }
    
    func dismissTapped(sender:UIButton){
        self.dismissViewControllerAnimated(true) {}
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
        
        let ph = PhotoHandler()
        let imgName = self.imgNameItems[indexPath.row]
        let img = ph.loadPhoto(imgName)
      
        let imgDimension = (self.view.bounds.width/2) - 20
 
        let width:CGFloat = (img?.size.width < img?.size.height) ? (imgDimension * 0.74 ) : imgDimension
        let height:CGFloat = (img?.size.width < img?.size.height) ? imgDimension  : (imgDimension * 0.74)
        
        return CGSizeMake(width, height)
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.flowLayout.invalidateLayout()
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
        return self.imgNameItems.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CustomCollectionViewCell
        
        let ph = PhotoHandler()
        let imgName = self.imgNameItems[indexPath.row]
        let img = ph.loadPhoto(imgName)
        
        cell.imageView.image = img
        print(cell.imageView.image!.imageOrientation)
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = UIButton().tintColor?.CGColor
        cell.layer.cornerRadius = 4
        cell.backgroundColor = UIColor.whiteColor()
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
       let imgName = self.imgNameItems[indexPath.row]
        
   
        
        
    }

}
