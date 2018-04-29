//
//  SendButton.swift
//  AgroEvo
//
//  Created by Jose Mejia on 4/29/18.
//  Copyright © 2018 Jose Mejia. All rights reserved.
//

import UIKit

@IBDesignable
class SendButton: UIButton {
    
    @IBInspectable var s:String = "Analizar" {
        didSet {
            setNeedsDisplay()
        }
    }
    
    @IBInspectable var bgColor:UIColor = UIColor(red: 0.3294, green: 0.6118, blue: 0.7882, alpha:0.8) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
        
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 7.0)
        bgColor.setFill()
        path.fill()
        
        let fieldColor: UIColor = UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1.0)
        let fieldFont = UIFont(name: "HelveticaNeue-Bold", size: 30)
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = .center
        paraStyle.lineSpacing = 0
        
        // let skew = 0
        
        let attrs = [NSAttributedStringKey.font: fieldFont!, NSAttributedStringKey.paragraphStyle: paraStyle, NSAttributedStringKey.foregroundColor: fieldColor]
        
        self.s.draw(in: CGRect(x:(self.bounds.midX)-(self.bounds.width/2), y:self.bounds.minY, width:self.bounds.width, height:self.bounds.height), withAttributes: attrs)
    }

}
