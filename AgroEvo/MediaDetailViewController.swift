//
//  MediaDetailViewController.swift
//  AgroEvo
//
//  Created by Jose Mejia on 5/1/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import UIKit

class MediaDetailViewController: UIViewController {
    
    @IBOutlet weak var fullzise_img: UIImageView!
    var mediaInfo:ProcessImage = ProcessImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.fullzise_img.image = mediaInfo.image_url
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
