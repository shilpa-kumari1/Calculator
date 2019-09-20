//
//  historyViewController.swift
//  Calculator
//
//  Created by Shilpa Kumari on 08/08/19.
//  Copyright © 2019 Shilpa Kumari. All rights reserved.
//

import UIKit

protocol clearHistoryDelegate : class{
    func clear(type: [String])
}
class historyViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    weak var ClearHistoryDelegate : clearHistoryDelegate?
    @IBOutlet weak var stackview: UIStackView!
    
    @IBOutlet weak var titleLabl: UILabel!
    
      var items : [String] = []
    
    @IBOutlet weak var clearBtn: UIButton!
    
    
   
    
    @IBAction func clearButton(_ sender: Any) {
        items.removeAll()
        ClearHistoryDelegate?.clear(type: items)
        historyTableView.reloadData()
        clearBtn.isHidden = true
        items = ["No history to show"]
        historyTableView.reloadData()
        // self.navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet weak var historyTableView: UITableView!
   
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->
        UITableViewCell{
            let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "Cell")
            cell.textLabel?.text = items[indexPath.row]
           
            return cell
            
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete{
            items.remove(at: indexPath.row)
            ClearHistoryDelegate?.clear(type: items)
            
            historyTableView.reloadData()
            if items.count == 0{
                clearBtn.isHidden = true
                items = ["No history to show"]
                historyTableView.reloadData()
                //self.navigationController?.popViewController(animated: true)
            }
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if items.count == 0{
            /*clearBtn.isHidden = true
           let margins = view.layoutMarginsGuide
            historyTableView.bottomAnchor.constraint(equalTo: margins.bottomAnchor, constant: 100).isActive = true
            historyTableView.reloadData()*/
            clearBtn.isHidden = true
            items = ["No history to show"]
            //stackview.isHidden = true
            
            
            

        }
        // Do any additional setup after loading the view.
    }
    

   

}

