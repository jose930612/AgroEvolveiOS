//
//  AnalizeViewController.swift
//  AgroEvo
//
//  Created by Jose Mejia on 4/27/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import UIKit
import Foundation
import Alamofire
import MobileCoreServices
import Photos

class AnalizeViewController: UIViewController, UIScrollViewDelegate,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    //let cameraButton = UIButton.init(type: .custom)
    
    var newImage:UIImage?
    var imageData:Data?
    var contentWidth:CGFloat = 0.0
    var x_coord:Double = 0.0
    var y_coord:Double = 0.0
    var responseTitles:[String] = []
    // @IBOutlet weak var previewImg: UIImageView!
    
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var imgPageControl: UIPageControl!
    @IBOutlet weak var ScrollImages: UIScrollView!
    @IBOutlet weak var analizeButton: SendButton!
    @IBOutlet weak var clearImage: SendButton!
    @IBOutlet weak var springLoad: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ScrollImages.delegate = self
        self.cameraButton.addTarget(self, action: #selector(self.chooseSourceOption), for: .touchUpInside)
        
        imgPageControl.numberOfPages = 0
        
        imgPageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        
        self.springLoad.stopAnimating()
        self.springLoad.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (newImage != nil) {
            // self.previewImg.image = newImage
            analizeButton.isEnabled = true
            clearImage.isEnabled = true
        }else{
            analizeButton.isEnabled = false
            clearImage.isEnabled = false
            //analizeButton.isUserInteractionEnabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func sendImage() {
        print("Image Send")
        
        self.springLoad.startAnimating()
        self.springLoad.isHidden = false
        
        let random_img_name = randomString(length: 10)
        
        let REST_UPLOAD_API_URL = "http://159.65.225.153/api/guess-what/"
        
        let headers = [
            "Content-Type": "multipart/form-data"
        ]
        
        let parameters: Parameters = ["x_coord": String(self.x_coord),
                                      "y_coord": String(self.y_coord)]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                let imageData = self.imageData
                multipartFormData.append(imageData!, withName: "image", fileName: "\(random_img_name).jpg", mimeType: "jpg/png")
                    
                for (key, value) in parameters {
                    if value is String || value is Int {
                        multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                    }
                }
        },
            to: REST_UPLOAD_API_URL,
            headers: headers,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.responseJSON { response in
                        debugPrint(response)
                        //print(response.result.value!)
                        self.springLoad.stopAnimating()
                        self.springLoad.isHidden = true
                        if (response.result.value != nil) {
                            let json_results = response.result.value as! NSDictionary
                            
                            // print(json_results["img_url"] as Any)
                            
                            let resultImages = (json_results["img_url"] as! String).components(separatedBy:",")
                            
                            for view in self.ScrollImages.subviews {
                                view.removeFromSuperview()
                            }
                            
                            self.contentWidth = CGFloat(0.0)
                            
                            for (index, img_name) in resultImages.enumerated() {
                                let escape_string = (img_name as String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
                                let img_url_string = "http://159.65.225.153/media/tensor/\(escape_string!)"
                                let img_url = URL(string: img_url_string)!
                                let data = try? Data(contentsOf: img_url)
                                
                                let new_img = UIImage(data: data!)
                                let imageView = UIImageView(image: new_img)
                                imageView.transform = imageView.transform.rotated(by: CGFloat.pi/2)
                                
                                self.contentWidth += self.ScrollImages.frame.width
                                
                                let xCoordinate = self.ScrollImages.frame.width * CGFloat(index)
                                
                                self.ScrollImages.addSubview(imageView)
                                
                                let soulName = img_name.split(separator: "-")[1].split(separator: ".")[0]
                                self.responseTitles.append(String(soulName))
                                
                                imageView.frame = CGRect(x: xCoordinate, y: 0, width: self.ScrollImages.frame.width, height: self.ScrollImages.frame.height)
                                
                            }
                            
                            self.navigationItem.title = self.responseTitles[0]
                            self.imgPageControl.numberOfPages = resultImages.count
                            
                            self.ScrollImages.contentSize = CGSize(width: self.contentWidth, height: self.ScrollImages.frame.height)
                            
                            /*
                            let string_img_url = "http://159.65.225.153/media/\(json_results["img_url"]!)"
                            print(string_img_url)
                            let url = URL(string: string_img_url)
                            
                            let data = try? Data(contentsOf: url!)
                            self.previewImg.image = UIImage(data: data!)
                            */
                            
                            self.analizeButton.isEnabled = false
                        }
                        
                    }
                case .failure(let encodingError):
                    print("encoding Error : \(encodingError)")
                }
        })
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = Int(self.ScrollImages.contentOffset.x / CGFloat(self.ScrollImages.frame.width))
        self.imgPageControl.currentPage = x
        self.navigationItem.title = self.responseTitles[x]
        
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(imgPageControl.currentPage) * ScrollImages.frame.size.width
        ScrollImages.setContentOffset(CGPoint(x: x,y :0), animated: true)
        self.navigationItem.title = self.responseTitles[imgPageControl.currentPage]
    }
    
    @IBAction func clearImageView(_ sender: Any) {
        print("Image Clear")
        analizeButton.isEnabled = false
        clearImage.isEnabled = false
        
        for view in self.ScrollImages.subviews {
            view.removeFromSuperview()
        }
        
        self.contentWidth = CGFloat(0.0)
        // self.previewImg.image = nil
        // newImage = nil
    }
    
    func randomString(length: Int) -> String {
        
        let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        let len = UInt32(letters.length)
        
        var randomString = ""
        
        for _ in 0 ..< length {
            let rand = arc4random_uniform(len)
            var nextChar = letters.character(at: Int(rand))
            randomString += NSString(characters: &nextChar, length: 1) as String
        }
        
        return randomString
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
        
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            print("Image selected")
            
            for view in self.ScrollImages.subviews {
                view.removeFromSuperview()
            }
            
            self.newImage = image
            
            let imageView = UIImageView(image: image)
            
            self.contentWidth += self.ScrollImages.frame.width
            
            self.ScrollImages.addSubview(imageView)
            
            imageView.frame = CGRect(x: 0, y: 0, width: self.ScrollImages.frame.width, height: self.ScrollImages.frame.height)
            
            self.imageData = UIImageJPEGRepresentation(image, 0.60)
            imgPageControl.numberOfPages = 1
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
        if segue.identifier == "prepare_for_analysis" {
            let sendImageVc = segue.destination as! SendImageViewController
            sendImageVc.flowerImage = self.newImage!
            sendImageVc.imageData = self.imageData!
            sendImageVc.delegate = self;
            sendImageVc.dismissVCCompletion(){ () in
                    self.sendImage()
            }
        }
    }
    

}
