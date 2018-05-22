//
//  MediaDetailViewController.swift
//  AgroEvo
//
//  Created by Jose Mejia on 5/1/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import UIKit

class MediaDetailViewController: UIViewController, UIScrollViewDelegate {
    
    
    @IBOutlet weak var imgPageControl: UIPageControl!
    @IBOutlet weak var scrollImages: UIScrollView!
    @IBOutlet weak var springLoader: UIActivityIndicatorView!
    
    @IBOutlet weak var estadoHoja: UITextView!
    @IBOutlet weak var estadoFlor: UITextView!
    
    @IBOutlet weak var maleza: UILabel!
    
    var contentWidth:CGFloat = 0.0
    var mediaInfo:ProcessImage = ProcessImage()
    var responseTitles:[String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        scrollImages.delegate = self
        imgPageControl.numberOfPages = 0
        
        imgPageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControlEvents.valueChanged)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.springLoader.isHidden = false
        self.springLoader.startAnimating()
        
        for (index, img_name) in mediaInfo.imgs_string_names.enumerated() {
            let escape_string = (img_name as String).addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
            let img_url_string = "http://159.65.225.153/media/tensor/\(escape_string!)"
            let img_url = URL(string: img_url_string)!
            let data = try? Data(contentsOf: img_url)
            // self.fullzise_img.image = UIImage(data: data!)
            
            let new_img = UIImage(data: data!)
            
            let imageView = UIImageView(image: new_img)
            imageView.transform = imageView.transform.rotated(by: CGFloat.pi/2)
            
            self.contentWidth += self.scrollImages.frame.width
            
            let xCoordinate = self.scrollImages.frame.width * CGFloat(index)
            
            self.scrollImages.addSubview(imageView)
            
            let soulName = img_name.split(separator: "-")[1].split(separator: ".")[0]
            self.responseTitles.append(String(soulName))
            
            imageView.frame = CGRect(x: xCoordinate, y: 0, width: self.scrollImages.frame.width, height: self.scrollImages.frame.height)
        }
        
        self.navigationItem.title = self.responseTitles[0]
        imgPageControl.numberOfPages = mediaInfo.imgs_string_names.count
        
        self.scrollImages.contentSize = CGSize(width: self.contentWidth, height: self.scrollImages.frame.height)
        
        self.springLoader.stopAnimating()
        self.springLoader.isHidden = true
        
        var auxString = ""
        
        if mediaInfo.hoja_sana != 0.0 {
            auxString += "\(Int(mediaInfo.hoja_sana))% Sana\n"
        }
        if mediaInfo.hoja_roya_blanca != 0.0 {
            auxString += "\(Int(mediaInfo.hoja_roya_blanca)))% Roya blanca\n"
        }
        if mediaInfo.hoja_minador != 0.0 {
            auxString += "\(Int(mediaInfo.hoja_minador))% Minador\n"
        }
        if mediaInfo.hoja_quimico != 0.0 {
            auxString += "\(Int(mediaInfo.hoja_quimico))% Químico\n"
        }
        if mediaInfo.hoja_quemada != 0.0 {
            auxString += "\(Int(mediaInfo.hoja_quemada))% Quemado\n"
        }
        
        self.estadoHoja.text = auxString
        
        auxString = ""
        
        if mediaInfo.flor_cerrada != 0.0 {
            auxString += "\(Int(mediaInfo.flor_cerrada))% Cerrada\n"
        }
        if mediaInfo.flor_abierta != 0.0 {
            auxString += "\(Int(mediaInfo.flor_abierta))% Abierta\n"
        }
        
        self.estadoFlor.text = auxString
        
        if mediaInfo.maleza != 0.0 {
            self.maleza.text = "\(Int(mediaInfo.maleza))% Maleza"
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let x = Int(self.scrollImages.contentOffset.x / CGFloat(self.scrollImages.frame.width))
        self.imgPageControl.currentPage = x
        self.navigationItem.title = self.responseTitles[x]
    }
    
    @objc func changePage(sender: AnyObject) -> () {
        let x = CGFloat(imgPageControl.currentPage) * scrollImages.frame.size.width
        scrollImages.setContentOffset(CGPoint(x: x,y :0), animated: true)
        self.navigationItem.title = self.responseTitles[imgPageControl.currentPage]
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
