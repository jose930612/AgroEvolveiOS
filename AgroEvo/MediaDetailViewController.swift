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
    @IBOutlet weak var hoja_sana: UILabel!
    @IBOutlet weak var roya_blanca: UILabel!
    @IBOutlet weak var minador: UILabel!
    @IBOutlet weak var hoja_quimico: UILabel!
    @IBOutlet weak var hoja_quemada: UILabel!
    @IBOutlet weak var flor_cerrada: UILabel!
    @IBOutlet weak var flor_abierta: UILabel!
    @IBOutlet weak var maleza: UILabel!
    
    var mediaInfo:ProcessImage = ProcessImage()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let data = try? Data(contentsOf: mediaInfo.img_url!)
        self.fullzise_img.image = UIImage(data: data!)
        
        self.hoja_sana.text = "\(Int(mediaInfo.hoja_sana))%"
        self.roya_blanca.text = "\(Int(mediaInfo.hoja_roya_blanca))%"
        self.minador.text = "\(Int(mediaInfo.hoja_minador))%"
        self.hoja_quimico.text = "\(Int(mediaInfo.hoja_quimico))%"
        self.hoja_quemada.text = "\(Int(mediaInfo.hoja_quemada))%"
        self.flor_cerrada.text = "\(Int(mediaInfo.flor_cerrada))%"
        self.flor_abierta.text = "\(Int(mediaInfo.flor_abierta))%"
        self.maleza.text = "\(Int(mediaInfo.maleza))%"
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
