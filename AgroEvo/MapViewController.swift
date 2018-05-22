//
//  MapViewController.swift
//  AgroEvo
//
//  Created by Jose Mejia on 5/20/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import UIKit
import Alamofire

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: UIImageView!
    let mapImage:UIImage = UIImage(named: "MapTahami.png")!
    var alertStrings:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.image = mapImage
        // self. #005A94
        self.navigationItem.title = "Tahami"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.getData()
    }
    
    func getData() {
        let url_string = "http://159.65.225.153/api/image-gallery/"
        
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
                        
                        var red:CGFloat = 0.0
                        var green:CGFloat = 0.0
                        var blue:CGFloat = 0.0
                        
                        var colors:[CGFloat] = []
                        
                        let hoja_sana = temp["hoja_sana"]! as! Double
                        
                        let hoja_roya_blanca = temp["hoja_roya_blanca"]! as! Double
                        let hoja_minador = temp["hoja_minador"]! as! Double
                        let hoja_quimico = temp["hoja_quimico"]! as! Double
                        let hoja_quemada = temp["hoja_quemada"]! as! Double
                        
                        let flor_cerrada = temp["flor_cerrada"]! as! Double
                        let flor_abierta = temp["flor_abierto"]! as! Double
                        
                        let maleza = temp["maleza"]! as! Double
                        
                        var total_danio = 0
                        var alertString = ""
                        
                        if hoja_sana != 0.0 {
                            alertString += "\(Int(Float(hoja_sana)))% Hoja Sana\n"
                        }
                        
                        if hoja_roya_blanca != 0.0 {
                            total_danio += 1
                            alertString += "\(Int(Float(hoja_roya_blanca)))% Roya Blanca\n"
                        }
                        if hoja_minador != 0.0 {
                            total_danio += 1
                            alertString += "\(Int(Float(hoja_minador)))% Minador\n"
                        }
                        if hoja_quimico != 0.0 {
                            total_danio += 1
                            alertString += "\(Int(Float(hoja_quimico)))% Químico\n"
                        }
                        if hoja_quemada != 0.0 {
                            total_danio += 1
                            alertString += "\(Int(Float(hoja_quemada)))% Quemado\n"
                        }
                        
                        if flor_cerrada != 0.0 {
                            alertString += "\(Int(Float(flor_cerrada)))% Flor abierta\n"
                        }
                        
                        if flor_abierta != 0.0 {
                            alertString += "\(Int(Float(flor_abierta)))% Flor cerrada\n"
                        }
                        
                        if maleza != 0.0 {
                            alertString += "\(Int(Float(maleza)))% Maleza\n"
                        }
                        
                        self.alertStrings.append(alertString)
                        
                        if total_danio == 0 {
                            red = 0
                            green = 255/255
                            blue = 0
                        }else if total_danio == 1 {
                            red = 195/255
                            green = 255/255
                            blue = 0/255
                        }else if total_danio == 2 {
                            red = 237/255
                            green = 199/255
                            blue = 11/255
                        }else if total_danio == 3 {
                            red = 255/255
                            green = 182/255
                            blue = 0/255
                        }else if total_danio == 4 {
                            red = 255/255
                            green = 0/255
                            blue = 0/255
                        }
                        
                        colors = [red, green, blue]
                        
                        let x_coord = CGFloat(temp["x_coord"]! as! Double)
                        let y_coord = CGFloat(temp["y_coord"]! as! Double)
                        
                        
                        
                        self.setButton(x_coord:x_coord, y_coord:y_coord, colors:colors, tag:self.alertStrings.count-1)
                        
                        // self.mapView.image = self.drawOnImage(startingImage: self.mapView.image!, x_coord: x_coord, y_coord: y_coord, colors:colors)
                    }
                }
        }
    }
    
    func setButton(x_coord:CGFloat, y_coord:CGFloat, colors:[CGFloat], tag:Int) {
        let img_width = mapImage.size.width
        let img_height = mapImage.size.height
        
        let view_width = mapView.frame.width
        let view_height = mapView.frame.height
        
        let img_x = (x_coord * view_width)/img_width
        let img_y = (y_coord * view_height)/img_height
        
        let button = UIButton()
        button.tag = tag
        
        button.frame = CGRect(x: img_x, y: img_y, width: 10, height: 10)
        button.backgroundColor = UIColor(red: colors[0], green: colors[1], blue: colors[2], alpha: 1)
        button.addTarget(self, action: #selector(self.detailAlert(sender:)), for: .touchUpInside)
        
        self.mapView.addSubview(button)
    }
    
    @objc func detailAlert(sender: UIButton) -> (){
        let alertController = UIAlertController(title: "Detalles", message:
            alertStrings[sender.tag], preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default,handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
        
    }
    
    func drawOnImage(startingImage: UIImage, x_coord:CGFloat, y_coord:CGFloat, colors:[CGFloat]) -> UIImage {
        /*
        let img_width = mapImage!.size.width
        let img_height = mapImage!.size.height
        print("img_width:\(img_width) img_height:\(img_height)")
        let view_width = mapView.frame.width
        let view_height = mapView.frame.height
        print("view_width:\(view_width) view_height:\(view_height)")
 
        let img_x = (x_coord * img_width)/view_width
        let img_y = (y_coord * img_height)/view_height
        */
        
        UIGraphicsBeginImageContext(startingImage.size)
        
        startingImage.draw(at: CGPoint.zero)
        
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        
        let rect = CGRect(x: x_coord, y: y_coord, width: 100, height: 100)
        context.setFillColor(red: colors[0], green: colors[1], blue: colors[2], alpha: 1)
        context.fillEllipse(in: rect)
        
        
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return myImage!
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
