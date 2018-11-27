import UIKit
import Foundation

class FrontPageViewController: UIViewController {
    
    @IBOutlet weak var printButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.printButton.layer.cornerRadius = 5
        self.copyButton.layer.cornerRadius = 5
        
    }
    
    var jobData: JobModel?
    
    func getJobData(completed: @escaping () -> ()) {
        
        let parameters: [String: Any] = [
            "password": Constants.RequestPassword,
            "mobile_number": "0542323420",
            "machine_id": 5000,
            "operator_id": 0
        ]
        
        guard let testURL = URL(string: Constants.PrintRequestURL) else { return }
        
        var request = URLRequest(url: testURL)
        
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
        
        print(httpBody)
        
        request.httpBody = httpBody
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("error 1")
                print(error!)
                return
            }
            guard let data = data else { return }
            
            do {
                
                let decoder = JSONDecoder()
                let jobDataTest = try decoder.decode(JobModel.self, from: data)
                self.jobData = jobDataTest
                
                print(self.jobData?.jobs?[0].jobid)
                
                DispatchQueue.main.async {
                    
                    completed()
                    
                }
                return
            } catch let err {
                print("Err", err)
            }
            
        }
        
        task.resume()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ListViewController
        {
            let vc = segue.destination as? ListViewController
            vc?.jobData = jobData
        }
    }
    
    @IBAction func printDocuments(_ sender: UIButton) {
        
        activityIndicator.isHidden = false
        
        getJobData() {
            
            self.activityIndicator.isHidden = true
            
            if self.jobData?.ret_code == 200  {
                
                self.performSegue(withIdentifier: "FrontPageSegue", sender: self)
                
            } else if self.jobData?.ret_code == 204  {
                
                self.getJobDataAlert(message: "No pending jobs in current printer")
                
            }
            
        }
        
    }
    
    @IBAction func copyDocuments(_ sender: UIButton) {
    }
    
    func getJobDataAlert(message: String) {
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private struct Constants {
        static let PrintRequestURL = // removed to protect sensitive information
        static let RequestPassword = // removed to protect sensitive information
    }
}

