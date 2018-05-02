//
//  GalleryViewController.swift
//  AgroEvo
//
//  Created by Jose Mejia on 4/30/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import UIKit
import Alamofire

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var mediaCollection: UICollectionView!
    
    var processImages:[ProcessImage] = []
    var galleryType = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        // requestImmgs()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //print(self.galleryType)
        if (self.processImages.count == 0){
            switch self.galleryType {
            case "images":
                requestImmgs()
                break
            default:
                break
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(self.processImages.count)
        return self.processImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellView = collectionView.dequeueReusableCell(withReuseIdentifier: "media", for: indexPath) as! MediaCollectionViewCell
        let preview_img = resizeImage(image: self.processImages[indexPath.row].image_url!, newWidth: cellView.bounds.maxX)
        
        cellView.media_thumbnail.image = preview_img
        
        return cellView
    }
    
    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        
        
        image.draw(in: CGRect(x: 0, y: 0,width: newWidth, height: newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    func requestImmgs() {
        
        let url_string = "http://159.65.225.153:5000/api/image-gallery/"
        
        Alamofire.request(url_string, method: .get)
            .responseJSON { response in
                guard response.result.error == nil else {
                    print(response.result.error!)
                    return
                }
                
                if (response.result.value != nil) {
                    let vals = response.result.value as! NSArray
                    
                    for value in vals {
                        let temp = value as! NSDictionary
                        
                        let id = temp["id"]! as! String
                        
                        let url_string = "http://159.65.225.153:5000/media/\(temp["img_path"]!)"
                        
                        let img_url = URL(string: url_string)
                        let data = try? Data(contentsOf: img_url!)
                        
                        let hoja_sana = temp["hoja_sana"]! as! Double
                        let hoja_roya_blanca = temp["hoja_roya_blanca"]! as! Double
                        let hoja_minador = temp["hoja_minador"]! as! Double
                        let hoja_quimico = temp["hoja_quimico"]! as! Double
                        let hoja_quemada = temp["hoja_quemada"]! as! Double
                        let flor_cerrada = temp["flor_cerrada"]! as! Double
                        let flor_abierta = temp["flor_abierto"]! as! Double
                        let maleza = temp["maleza"]! as! Double
                        
                        let image_response = ProcessImage(id: id, image_url: UIImage(data: data!)!, hoja_sana: Float(hoja_sana), hoja_roya_blanca: Float(hoja_roya_blanca), hoja_minador: Float(hoja_minador), hoja_quimico: Float(hoja_quimico), hoja_quemada: Float(hoja_quemada), flor_cerrada: Float(flor_cerrada), flor_abierta: Float(flor_abierta), maleza: Float(maleza))
                        self.processImages.append(image_response)
                        print(temp["title"]!)
                    }
                    self.mediaCollection.reloadData()
                }
        }
    }
    
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "mediaDetails" {
            let mediaDetailView = segue.destination as! MediaDetailViewController
            let selectedCell = sender as! UICollectionViewCell
            let mediaIndex = mediaCollection?.indexPath(for: selectedCell)
            
            mediaDetailView.mediaInfo = self.processImages[mediaIndex!.row]
        }
    }
    

}
