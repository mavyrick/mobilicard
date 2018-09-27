import UIKit
import Foundation

class FrontPageViewController: UIViewController {
    
    @IBOutlet weak var printButton: UIButton!
    @IBOutlet weak var copyButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var pingData = [Ping]()
    
    func ping() {
        
        print("test")
        
        guard let testURL = URL(string: "https://vend.mobilicard.com/external/rs/public/ping") else { return }
        
        var request = URLRequest(url: testURL)
        
        request.httpMethod = "GET"
        //                request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let session = URLSession.shared
        
        print("test1")
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                print("error 1")
                print(error!)
                return
            }
            guard let responseData = data else {
                print("testtest")
                return
                
            }
            
            do {
                let decoder = JSONDecoder()
                let pingData = try decoder.decode(Ping.self, from: data!)
                
                DispatchQueue.main.async {
                    
                }
                
                return
                
            } catch let err {
                print("Err", err)
            }
            
        }
        task.resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.printButton.layer.cornerRadius = 5
        self.copyButton.layer.cornerRadius = 5
        
        ping()
        
    }
    
    var printOrCopy = "test"
    
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
                //                print(self.jobData[0].jobs?[0].title)
                //                print(Int((jobDataTest.jobs?.count)!))
                //                print(jobDataTest.jobs?[0].checkbox)
                //                self.jobData = jobDataTest.jobs
                //                print(jobDataTest.jobs?[0].title)
                //                print(self.jobData)
                //                print(self.jobData)
                
                //                self.totalCost.text = self.jobData?.total_cost
                
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
        
        
        
        //        printOrCopy = "print"
        //        print(printOrCopy)
        
        //        let vc = ListViewController(nibName: "ListViewController", bundle: nil)
        //        vc.printOrCopy = "print"
        //        print(vc.printOrCopy)
        //
        //        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func copyDocuments(_ sender: UIButton) {
        //        printOrCopy = "copy"
    }
    
    func getJobDataAlert(message: String) {
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            }}))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    //    http://gvs.mobilicard.com/scopos/pages/do_print_request.php
    
    //    http://gvs.mobilicard.com/scopos/pages/do_print.php
    
    //    gvs.mobilicard.com/scopos/external/rs/public/ping
    
    //    put request
    //    gvs.mobilicard.com/scopos/external/rs/public/user_get_info
    //    json params:
    
    //    gvs.mobilicard.com/scopos/external/rs/public/user_get_info.php
    
    //    005493
    
    private struct Constants {
        static let PrintRequestURL = "https://gvs.mobilicard.com/external/rs/public/do_print_request"
        static let RequestPassword = "!dneviliboM@"
        static let ReleaseJobURL =  "https://gvs.mobilicard.com/external/rs/public/do_release_job"
    }
}

