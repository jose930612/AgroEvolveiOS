//
//  SelectGalleryViewController.swift
//  AgroEvo
//
//  Created by Jose Mejia on 4/30/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import UIKit

class SelectGalleryViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.navigationItem.title = "Galerias"
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "image_g_segue" {
            let galleryImgs = segue.destination as! GalleryViewController
            galleryImgs.galleryType = "images"
        }
    }
    

}
