//
//  SendImageViewController.swift
//  AgroEvo
//
//  Created by Jose Mejia on 5/21/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import UIKit
import Alamofire

class SendImageViewController: UIViewController {
    
    typealias typeCompletionHandler = () -> ()
    var completion : typeCompletionHandler = {}
    
    
    @IBOutlet weak var mapImageView: MapImageView!
    @IBOutlet weak var sendImgButton: SendButton!
    @IBOutlet weak var cancelBtn: SendButton!
    @IBOutlet weak var flowerImg: UIImageView!
    
    let mapImage:UIImage = UIImage(named: "MapTahami.png")!
    var flowerImage:UIImage?
    var imageData:Data?
    var delegate : AnalizeViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapImageView.image = mapImage
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.flowerImg.image = self.flowerImage
    }
    
    @IBAction func sendImage(_ sender: Any) {
        if mapImageView.x_coord != 0.0 && mapImageView.y_coord != 0 {
            self.delegate?.x_coord = mapImageView.x_coord
            self.delegate?.y_coord = mapImageView.y_coord
            dismiss(animated: true, completion: {
                self.completion()
            })
        }else{
            let alertController = UIAlertController(title: "Alerta!", message:
                "Debe seleccinar la ubicación en el mapa", preferredStyle: UIAlertControllerStyle.alert)
            alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
            
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    @IBAction func returnToMain(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func dismissVCCompletion(completionHandler: @escaping typeCompletionHandler) {
        self.completion = completionHandler
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
