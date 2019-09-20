//
//  ViewController.swift
//  Calculator
//
//  Created by Shilpa Kumari on 07/08/19.
//  Copyright © 2019 Shilpa Kumari. All rights reserved.
//

import UIKit

enum operate{
    case plus
    case minus
    case multiply
    case divide
}

class ViewController: UIViewController, UITextFieldDelegate, clearHistoryDelegate {
    
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var seecondTextField: UITextField!
    @IBOutlet weak var firstTextField: UITextField!
    @IBOutlet weak var calculatorLabel: UILabel!
    @IBOutlet weak var subview: UIView!

    var arr : [String] = []
    var referenceViewGlobal : SubView?
    var showText = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        firstTextField.delegate = self
        seecondTextField.delegate = self
        if let referenceView = Bundle.main.loadNibNamed("SubView", owner: self, options: nil)?.first as? SubView{
            subview.addSubview(referenceView)
            referenceView.frame.size.height = subview.frame.size.height
            referenceView.frame.size.width = subview.frame.size.width
            
            referenceView.subviewDelegate = self
            referenceViewGlobal = referenceView
        }
    }
    
    func clear(type : [String]){
        arr = type
    }
    
    
    
  /*  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let HistoryViewController = segue.destination as? historyViewController{
            HistoryViewController.items = arr
            HistoryViewController.ClearHistoryDelegate = self
            
        }
    }*/
    
    @IBAction func showHistory(_ sender: Any) {
               let next = self.storyboard?.instantiateViewController(withIdentifier: "historyViewController") as! historyViewController
        next.items = arr
        next.ClearHistoryDelegate = self
        firstTextField.text = ""
        seecondTextField.text = ""
        resultLabel.text = ""
        self.navigationController?.pushViewController(next, animated: true)
    }
    @IBAction func refreshButton(_ sender: Any) {
        resultLabel.text = ""
        firstTextField.text  = ""
        seecondTextField.text  = ""
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //For mobile numer validation
        if textField == firstTextField || textField == seecondTextField{
            let allowedCharacters = CharacterSet(charactersIn:"+0123456789 ")//Here change this characters based on your requirement
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>,
                               with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


extension ViewController : SubviewDelegate{
    
    func didTapOnMe(name: operate) {
        let num1text = firstTextField.text
        let num2text = seecondTextField.text
        var num_1 = 0.0
        var num_2 = 0.0
                
        if let num1 = Double(num1text!), let num2 = Double(num2text!){
            num_1 = num1
            num_2 = num2
            showText = ""
            showText += String(num1)
            switch name{
            case .plus: resultLabel.text = String(num_1 + num_2)
                showText += " + \(num_2) = \(resultLabel.text!)"
                
            case .minus : resultLabel.text = String(num_1 - num_2)
                 showText += " - \(num_2) = \(resultLabel.text!)"
                
            case .multiply : resultLabel.text = String(num_1 * num_2)
                 showText += " x \(num_2) = \(resultLabel.text!)"
            case .divide : if num_2 == 0{
                resultLabel.text = "Cannot divide by 0, enter a valid divisor"
            }
            else{
                resultLabel.text = String(num_1 / num_2)
                 showText += " / \(num_2) = \(resultLabel.text!)"
                }
          }
            arr.append(showText)
           }
        
       else{
            resultLabel.text = "Enter valid numbers"
        }
        }
}

