import UIKit

//Pass saved time to ViewController
protocol TimeDelegate {
    func sentTotalTime(time : Double)
}

class ReadViewController: UIViewController {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var secondomer: UILabel!
    @IBOutlet weak var timeSavedLabel: UILabel! // first
    @IBOutlet weak var savedTimeLabel: UILabel! // second
    
    var delegate: TimeDelegate?
    var words = String()
    var readingSpeed = UInt32()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        countdownStart()
    }
    
    //MARK: Countdown Start /
    func countdownStart() {
        
        print(readingSpeed)
        secondomer.isHidden = false
        var seconds = 3
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            
            seconds -= 1
            self.secondomer.text = String(seconds)
            if seconds == 0 {
                self.secondomer.isHidden = true
                self.startRead()
                timer.invalidate()
            } else {
                print(seconds)
            }
        }
    }
    
    //MARK: Words changing/data sending.
    func startRead() {
        
        let startDate = Date()
        let characterCount = Double(words.count)
        let defaultTime = characterCount / 25
        
        DispatchQueue.global(qos: .default).async {
            for word in self.words.split(separator: " ") {
                DispatchQueue.main.async {
                    self.wordLabel.text = String(word)
                }
                usleep(self.readingSpeed)
            }
            let endDate = Date()
            let timeInterval = endDate.timeIntervalSince(startDate)
            
            DispatchQueue.main.async {
                
                self.timeSavedLabel.isHidden = false
                self.savedTimeLabel.isHidden = false
                self.timeSavedLabel.text = "Time passed: " + String(format: "%.1f", timeInterval) + " sec."
                self.savedTimeLabel.text = String(format: "%.1f", defaultTime - timeInterval) + " sec saved."
                
                if self.delegate != nil {
                    self.delegate?.sentTotalTime(time: defaultTime - timeInterval)
                    self.navigationController?.isNavigationBarHidden = false
                }
            }
        }
    }
}
