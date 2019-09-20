//
//  SubView.swift
//  Calculator
//
//  Created by Shilpa Kumari on 08/08/19.
//  Copyright © 2019 Shilpa Kumari. All rights reserved.
//

import UIKit


protocol SubviewDelegate: class {
    func didTapOnMe(name: operate)
}
class SubView: UIView {
    
    weak var subviewDelegate : SubviewDelegate?
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            subviewDelegate?.didTapOnMe(name : operate.plus)
        case 2:
            subviewDelegate?.didTapOnMe(name : operate.minus)
        case 3:
            subviewDelegate?.didTapOnMe(name : operate.multiply)
        case 4:
            subviewDelegate?.didTapOnMe(name : operate.divide)
        default:
            break
        }
    }
    
    
    
    override func awakeFromNib() {
        
    }
    
}
