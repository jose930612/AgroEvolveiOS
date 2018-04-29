//
//  AnalizeViewController.swift
//  AgroEvo
//
//  Created by Jose Mejia on 4/27/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import UIKit
import Foundation

class AnalizeViewController: UIViewController {
    
    var newImage:UIImage?
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
        
        let imageData = UIImageJPEGRepresentation(newImage!, 0.8) as NSData?
        
        var error: NSError? = nil
        
        let request = NSMutableURLRequest(url: URL(string: "http://159.65.225.153:5000/api/guess-what/")!)
        request.httpMethod = "POST"
        request.cachePolicy = .reloadIgnoringLocalCacheData
        let boundary = "unique-consistent-string"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        let body = NSMutableData()
        
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: String.Encoding.utf8)!)
        body.append(imageData as! Data)
        body.append("\r\n".data(using: String.Encoding.utf8)!)
        
        body.append("--\(boundary)--\r\n".data(using: String.Encoding.utf8)!)
        request.httpBody = body as Data
        let session = URLSession.shared
        let task = session.dataTask(with: request as URLRequest) {
            (data, response, error) in
            guard let _:NSData = data as NSData?, let _:URLResponse = response, error == nil else {
                print("error")
                self.view.isUserInteractionEnabled = true
                return
            }
            if let httpResponse = response as? HTTPURLResponse {
                print(httpResponse.statusCode)
                if(httpResponse.statusCode == 200){
                    print("A-OK")
                }
            }
        }
        
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
