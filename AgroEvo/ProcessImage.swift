//
//  ProcessImage.swift
//  AgroEvo
//
//  Created by Jose Mejia on 4/30/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import Foundation
import UIKit

class ProcessImage {
    var id:String = ""
    var image_url:UIImage?
    var hoja_sana:Float = 0.0
    var hoja_roya_blanca:Float = 0.0
    var hoja_minador:Float = 0.0
    var hoja_quimico:Float = 0.0
    var hoja_quemada:Float = 0.0
    var flor_cerrada:Float = 0.0
    var flor_abierta:Float = 0.0
    var maleza:Float = 0.0
    
    init() {
        
    }
    
    init(id:String, image_url:UIImage, hoja_sana:Float, hoja_roya_blanca:Float, hoja_minador:Float, hoja_quimico:Float, hoja_quemada:Float, flor_cerrada:Float, flor_abierta:Float, maleza:Float) {
        self.id = id
        self.image_url = image_url
        self.hoja_sana = hoja_sana
        self.hoja_roya_blanca = hoja_roya_blanca
        self.hoja_minador = hoja_minador
        self.hoja_quimico = hoja_quimico
        self.hoja_quemada = hoja_quemada
        self.flor_cerrada = flor_cerrada
        self.flor_abierta = flor_abierta
        self.maleza = maleza
    }
    
    func fetch_data(data:NSDictionary) {
        let string_img_url = "http://159.65.225.153:5000/\(data["img_url"]!)"
        
        let url = URL(string: string_img_url)
        let img_data = try? Data(contentsOf: url!)
        
        self.image_url = UIImage(data: img_data!)
        self.hoja_sana = data["hoja_sana"] as! Float
        self.hoja_roya_blanca = data["hoja_roya_blanca"] as! Float
        self.hoja_minador = data["hoja_minador"] as! Float
        self.hoja_quimico = data["hoja_quimico"] as! Float
        self.hoja_quemada = data["hoja_quemada"] as! Float
        self.flor_cerrada = data["flor_cerrada"] as! Float
        self.flor_abierta = data["flor_abierta"] as! Float
        self.maleza = data["maleza"] as! Float
    }
    
}
