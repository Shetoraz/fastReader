//
//  ReadViewController.swift
//  fastReader
//
//  Created by Anton Asetski on 11/5/19.
//  Copyright © 2019 Anton Asetski. All rights reserved.
//

import UIKit

class ReadViewController: UIViewController {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var secondomer: UILabel!
    
    var words = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        
        secondomer.isHidden = false
        var seconds = 3
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            seconds -= 1
            self.secondomer.text = String(seconds)
            if seconds == 0 {
                self.secondomer.isHidden = true
                startRead()
                timer.invalidate()
            } else {
                print(seconds)
            }
            
        }
        
        func startRead() {
            
            DispatchQueue.global(qos: .default).async {
                for word in self.words.split(separator: " ") {
                    DispatchQueue.main.async {
                        self.wordLabel.text = String(word)
                    }
                    usleep(150000)
                }
            }
            
        }
    }
    
}

