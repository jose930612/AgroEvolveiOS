//
//  MainViewController.swift
//  AgroEvo
//
//  Created by Jose Mejia on 4/27/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import UIKit
import MobileCoreServices
import Photos

class MainViewController: UITabBarController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    let cameraButton = UIButton.init(type: .custom)
    var passImage:UIImage?
    var postMedia = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBar.barTintColor = UIColor(red:29/255, green:59/255, blue:112/255, alpha:1)
        self.tabBar.tintColor = UIColor(red:1, green:1, blue:1, alpha:1)
        //self.tabBar.unselectedItemTintColor = UIColor(red:1, green:1, blue:1, alpha:0.7)
        checkPermission()
        
    }
    
    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            print("Access is granted by user")
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization({
                (newStatus) in
                print("status is \(newStatus)")
                if newStatus ==  PHAuthorizationStatus.authorized {
                    /* do stuff here */
                    print("success")
                }
            })
            print("It is not determined until now")
        case .restricted:
            // same same
            print("User do not have access to photo album.")
        case .denied:
            // same same
            print("User has denied the permission.")
        }
    }

}
