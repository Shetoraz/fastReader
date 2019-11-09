import UIKit

class ViewController: UIViewController, TimeDelegate {
    
    @IBOutlet weak var readTextField: UITextView!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var speedPercentage: UILabel!
    
    var totalTimeSaved = Double()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recallValue()
        readTextField.layer.cornerRadius = 20
        speedPercentage.text = String(format: "%.0f", speedSlider.value) + "%"
    }
    
    @IBAction func readButtonPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        DispatchQueue.main.async {
            self.speedPercentage.text = String(format: "%.0f", sender.value) + "%"
        }
    }
    
    //Delegate method
    func sentTotalTime(time: Double) {
        
        totalTimeSaved += time
        totalTimeLabel.text = String(format: "%.1f", totalTimeSaved) + " sec."
        saveValue()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "readSegue" {
            
            if let readVC = segue.destination as? ReadViewController {
                readVC.delegate = self
                readVC.words = readTextField.text
                readVC.readingSpeed = 150000 / 100 * UInt32(speedSlider.value) // 150000 = default speed
            }
        }
    }
    
    // SAVE / LOAD
    func saveValue() {
        UserDefaults.standard.set(totalTimeSaved, forKey: "secSaved")
    }
    
    func recallValue(){
        totalTimeLabel.text = String(format: "%.1f", UserDefaults.standard.double(forKey: "secSaved"))
    }
}
