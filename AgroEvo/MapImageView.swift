//
//  MapImageView.swift
//  AgroEvo
//
//  Created by Jose Mejia on 5/20/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import UIKit

class MapImageView: UIImageView {
    
    var x_coord = 0.0
    var y_coord = 0.0

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            let position = touch.location(in: self)
            let edited_img = drawOnImage(startingImage: self.image!, x_coord: position.x, y_coord: position.y)
            self.image = edited_img
        }
    }
    
    func drawOnImage(startingImage: UIImage, x_coord:CGFloat, y_coord:CGFloat) -> UIImage {
        
        let img_width = self.image!.size.width
        let img_height = self.image!.size.height
        
        let view_width = self.frame.width
        let view_height = self.frame.height
        
        let img_x = (x_coord * img_width)/view_width
        let img_y = (y_coord * img_height)/view_height
        
        self.x_coord = Double(img_x)
        self.y_coord = Double(img_y)
        
        UIGraphicsBeginImageContext(startingImage.size)
        
        startingImage.draw(at: CGPoint.zero)
        
        let context = UIGraphicsGetCurrentContext()!
        context.saveGState()
        
        let rect = CGRect(x: img_x, y: img_y, width: 100, height: 100)
        context.setFillColor(red: 1, green: 0, blue: 0, alpha: 1)
        context.fillEllipse(in: rect)
        
        
        let myImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return myImage!
    }

}
