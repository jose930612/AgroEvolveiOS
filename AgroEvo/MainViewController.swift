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
        
        checkPermission()
        
        cameraButton.setTitle("Cam", for: .normal)
        cameraButton.frame = CGRect(x: self.tabBar.center.x - 32, y: self.view.bounds.height - 100, width: 74, height: 74)
        cameraButton.backgroundColor = .orange
        cameraButton.layer.borderWidth = 4
        cameraButton.layer.borderColor = UIColor.black.cgColor
        cameraButton.layer.cornerRadius = 36
        cameraButton.addTarget(self, action: #selector(self.chooseSourceOption), for: .touchUpInside)
        self.view.insertSubview(cameraButton, aboveSubview: self.tabBar)
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func chooseSourceOption(sender: AnyObject!) {
        let alertController = UIAlertController(title: "Action Sheet", message: nil, preferredStyle: .actionSheet)
        
        let cameraButton = UIAlertAction(title: "Camara", style: .default, handler: { (action) -> Void in
            print("Camera button tapped")
            if UIImagePickerController.isSourceTypeAvailable(.camera){
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self;
                myPickerController.sourceType = .camera
                self.present(myPickerController, animated: true, completion: nil)
            }
        })
        
        let libraryPhotosButton = UIAlertAction(title: "Libreria Fotos", style: .default, handler: { (action) -> Void in
            print("Photo Library button tapped")
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary;
                // imagePicker.allowsEditing = true
                self.present(imagePicker, animated: true, completion: nil)
            }
        })
        
        let libraryVideoButton = UIAlertAction(title: "Libreria Videos", style: .default, handler: { (action) -> Void in
            print("Video Library button tapped")
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
                let myPickerController = UIImagePickerController()
                myPickerController.delegate = self
                myPickerController.sourceType = .photoLibrary
                myPickerController.mediaTypes = [kUTTypeMovie as String, kUTTypeVideo as String]
                self.present(myPickerController, animated: true, completion: nil)
            }
        })
        
//        let  deleteButton = UIAlertAction(title: "Delete forever", style: .destructive, handler: { (action) -> Void in
//            print("Delete button tapped")
//        })
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        alertController.addAction(cameraButton)
        alertController.addAction(libraryPhotosButton)
        alertController.addAction(libraryVideoButton)
        alertController.addAction(cancelButton)
        
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let analizeView = self.viewControllers![0] as! AnalizeViewController
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.passImage = image
            self.postMedia = true
            print("Image selected")
            
            analizeView.newImage = image
            analizeView.imageData = UIImageJPEGRepresentation(image, 0.65) //as NSData!
            
            self.selectedIndex = 0
        }
        /*
        if let videoUrl = info[UIImagePickerControllerMediaURL] as? NSURL{
            print("videourl: ", videoUrl)
            let data = NSData(contentsOf: videoUrl as URL)!
            print("File size before compression: \(Double(data.length / 1048576)) mb")
            compressWithSessionStatusFunc(videoUrl)
        }
        */
        dismiss(animated:true, completion: nil)
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
//        print("\(String(describing: segue.identifier))")
//        if segue.identifier == "tabBar" {
//            if (postMedia == true){
//                let imgAnalyzer = segue.destination as! AnalizeViewController
//                imgAnalyzer.newImage = self.passImage
//            }
//        }
    }
    

}
