//
//  SAAButton.swift
//  DontecoTest
//
//  Created by Александр on 10.04.2022.
//

import UIKit

@IBDesignable class SAAButton: UIButton {
    
    @IBInspectable var radius: Double = 0 {
        didSet {
            self.layer.cornerRadius = radius
        }
    }

}
