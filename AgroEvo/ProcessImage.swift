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
    var thumbnail_img:UIImage?
    var imgs_string_names:[String] = []
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
    
    init(id:String, thumbnail_img:UIImage, imgs_string_names:[String],hoja_sana:Float, hoja_roya_blanca:Float, hoja_minador:Float, hoja_quimico:Float, hoja_quemada:Float, flor_cerrada:Float, flor_abierta:Float, maleza:Float) {
        self.id = id
        self.thumbnail_img = thumbnail_img
        self.imgs_string_names = imgs_string_names
        self.hoja_sana = hoja_sana
        self.hoja_roya_blanca = hoja_roya_blanca
        self.hoja_minador = hoja_minador
        self.hoja_quimico = hoja_quimico
        self.hoja_quemada = hoja_quemada
        self.flor_cerrada = flor_cerrada
        self.flor_abierta = flor_abierta
        self.maleza = maleza
    }
    
}
