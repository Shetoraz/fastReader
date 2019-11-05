//
//  ViewController.swift
//  fastReader
//
//  Created by Anton Asetski on 11/5/19.
//  Copyright © 2019 Anton Asetski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var readTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readTextField.layer.cornerRadius = 20
    }
    
    @IBAction func readButtonPressed(_ sender: UIButton) {
        
    
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "readSegue" {
            
            if let readVC = segue.destination as? ReadViewController {
                readVC.words = readTextField.text
            }
        }
    }
}

