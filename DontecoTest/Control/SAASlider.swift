//
//  SAASlider.swift
//  DontecoTest
//
//  Created by Александр on 10.04.2022.
//

import UIKit

class SAASlider: UISlider {
    
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
         let point = CGPoint(x: bounds.minX, y: bounds.midY)
         return CGRect(origin: point, size: CGSize(width: bounds.width, height: 12))
     }

}
