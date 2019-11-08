import UIKit

class ViewController: UIViewController, TimeDelegate {
    
    @IBOutlet weak var readTextField: UITextView!
    @IBOutlet weak var totalTimeLabel: UILabel!
    
    var totalTimeSaved = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readTextField.layer.cornerRadius = 20
        
    }
    
    @IBAction func readButtonPressed(_ sender: UIButton) {
        
    }
    
    //Delegate method
    func sentTotalTime(time: Double) {
        
        totalTimeSaved += time
        totalTimeLabel.text = "Lifetime saved: " + String(format: "%.1f", totalTimeSaved) + " sec."
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "readSegue" {
            
            if let readVC = segue.destination as? ReadViewController {
                readVC.delegate = self
                readVC.words = readTextField.text
            }
        }
    }
}

