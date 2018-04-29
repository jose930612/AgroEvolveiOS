//
//  AnalizeViewController.swift
//  AgroEvo
//
//  Created by Jose Mejia on 4/27/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import UIKit

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
