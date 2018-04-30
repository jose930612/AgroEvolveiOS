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

class AnalizeViewController: UIViewController {
    
    var newImage:UIImage?
    var imageName = "tmp-img.jpg"
    var imageData:Data?
    @IBOutlet weak var previewImg: UIImageView!
    @IBOutlet weak var analizeButton: SendButton!
    @IBOutlet weak var clearImage: SendButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if (newImage != nil) {
            self.previewImg.image = newImage
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
    
    
    @IBAction func sendImage(_ sender: Any) {
        print("Image Send")
        
        let REST_UPLOAD_API_URL = "http://159.65.225.153:5000/api/guess-what/"
        
        let headers = [
            "Content-Type": "multipart/form-data"
        ]
        
        let parameters: Parameters = ["name": "test_place",
                                      "description": "testing image upload from swift"]
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                let imageData = self.imageData
                multipartFormData.append(imageData!, withName: "image", fileName: "photo.jpg", mimeType: "jpg/png")
                    
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
                        //debugPrint(response)
                        print(response.result.value!)
                        let json_results = response.result.value as! NSDictionary
                        let string_img_url = "http://159.65.225.153:5000/\(json_results["img_url"]!)"
                        print(string_img_url)
                        let url = URL(string: string_img_url)
                        
                        let data = try? Data(contentsOf: url!)
                        self.previewImg.image = UIImage(data: data!)
                        
                    }
                case .failure(let encodingError):
                    print("encoding Error : \(encodingError)")
                }
        })
    }
    
    @IBAction func clearImageView(_ sender: Any) {
        print("Image Clear")
        analizeButton.isEnabled = false
        clearImage.isEnabled = false
        self.previewImg.image = nil
        newImage = nil
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
