import UIKit
import Foundation

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var jobData: JobModel? {
        didSet {
            //            self.listTableView.reloadData()
            print(jobData)
        }
    }
    
    var jobs: Jobs?
    var releaseJobData: ReleaseJobModel?
    
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var selectAllCell: ListTableViewCell!
    @IBOutlet weak var documentCell: ListTableViewCell!
    
    @IBOutlet weak var totalCost: UILabel!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var noJobs: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var selectAllText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(jobData)
        
        listTableView.delegate = self as UITableViewDelegate
        listTableView.dataSource = self as UITableViewDataSource
        
        totalCost.text = "0.00 ILS"
        
        self.sendButton.layer.cornerRadius = 5
        self.refreshButton.layer.cornerRadius = 5
        
        self.listTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
    @IBAction func refreshButton(_ sender: UIButton) {
        
        noJobs.isHidden = true
        refreshButton.isHidden = true
        activityIndicator.isHidden = false
    }
    
    var printOrCopy = "test"
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if (section == 1) {
            return nil
        }
        
        return "Documents to Print"
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //            print("number of jobs \(Int(jobData?.jobs?.count ?? 7))")
        if (section == 0) {
            return 1
        }
        
        return Int(jobData?.jobs?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.darkGray
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.textAlignment = NSTextAlignment.center
    }
    
    var jobidArray = [String]()
    
    @IBAction func selectAllChecked(_ sender: UIButton) {
        
        jobidArray = []
        
        if sender.isSelected {
            sender.isSelected = false
            totalCost.text = "0.00 ILS"
        } else {
            sender.isSelected = true
            let totalCostDouble = Double(jobData?.total_cost ?? 0)
            let totalCostValue = String(format: "%.2f", (totalCostDouble / Double(100)))
            totalCost.text = "\(totalCostValue) ILS"
        }
        
        var cells = [ListTableViewCell]()
        
        for row in 0...((Int(jobData?.jobs?.count ?? 0)) - 1) {
            let cell = self.listTableView.cellForRow(at: IndexPath(row: row, section: 1)) as? ListTableViewCell
            cells.insert(cell ?? ListTableViewCell(), at :0)
        }
        
        for cell in cells {
            
            if sender.isSelected {
                cell.checkbox?.isSelected = true
                jobidArray.insert(cell.job?.jobid ?? "", at :0)
            } else {
                cell.checkbox?.isSelected = false
            }
            
        }
        
        print(jobidArray)
        
    }
    
    @IBAction func checkboxChecked(_ sender: UIButton) {
        
        jobidArray = []
        
        var cells = [ListTableViewCell]()
        var checkedItems = [Int]()
        
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
        
        for row in 0...(Int(jobData?.jobs?.count ?? 0)) {
            let cell = self.listTableView.cellForRow(at: IndexPath(row: row, section: 1)) as? ListTableViewCell
            cells.insert(cell ?? ListTableViewCell(), at :0)
        }
        
        let selectAllCell = self.listTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ListTableViewCell
        
        for cell in cells {
            
            if cell.checkbox?.isSelected ?? false {
                //                            if sender.isSelected {
                checkedItems.insert(Int(cell.job?.price ?? "") ?? 0, at: 0)
                jobidArray.insert(cell.job?.jobid ?? "", at :0)
            }
            
            if checkedItems.count != jobData?.jobs?.count {
                selectAllCell?.selectAllCheckbox?.isSelected = false
                //                print(jobData?.jobs?.count)
            } else {
                selectAllCell?.selectAllCheckbox?.isSelected = true
                //                print(checkedItems.count)
                //                print(jobData?.jobs?.count)
            }
            
        }
        
        let totalCostValue = String(format: "%.2f", (Double(checkedItems.reduce(0, +)) / Double(100)))
        totalCost.text = "\(totalCostValue) ILS"
        
        print(jobidArray)
        print(checkedItems)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ListTableViewCell!
        
        if (indexPath.section == 0) {
            
            cell = listTableView.dequeueReusableCell(withIdentifier: "SelectAll", for: indexPath) as! ListTableViewCell
            cell.jobData = jobData
            
        } else if (indexPath.section == 1) {
            
            cell = listTableView.dequeueReusableCell(withIdentifier: "Document", for: indexPath) as! ListTableViewCell
            cell.job = jobData?.jobs?[indexPath.row]
        }
        
        cell.selectionStyle = .none
        
        var jobPriceArray = NSMutableArray()
        
        jobPriceArray.insert(jobData?.jobs?[indexPath.row].price, at: 0)
        
        print(jobPriceArray)
        
        return cell
        
    }
    
    func releaseJob(completed: @escaping () -> ()) {
        
        let parameters: [String: Any] = [
            "password": Constants.RequestPassword,
            "mobile_number": "0542323420",
            "machine_id": 5000,
            "machine_type": 01,
            "operator_id": 0,
            "operator_type": 01,
            "device_token": jobData?.device_token,
            "user_token": jobData?.user_token,
            "jobs": jobidArray
        ]
        
        guard let releaseJobURL = URL(string: Constants.ReleaseJobURL) else { return }
        
        var request = URLRequest(url: releaseJobURL)
        
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
                let releaseJobDecode = try decoder.decode(ReleaseJobModel.self, from: data)
                self.releaseJobData = releaseJobDecode
                
                DispatchQueue.main.async {
                    
                    completed()
                    
                    print(self.releaseJobData)
                    
                }
                return
            } catch let err {
                print("Err", err)
            }
            
        }
        task.resume()
        
    }
    
    @IBAction func sendToPrinter(_ sender: UIButton) {
        
        activityIndicator.isHidden = false
        
        if jobidArray.count == 0 {
            self.oneButtonAlert(message: "No documents selected!")
        } else {
            confirm()
        }
    }
    
    func tryRelease() {
        
        releaseJob() {
            
            print(self.releaseJobData?.ret_code)
            
            self.activityIndicator.isHidden = true
            
            switch self.releaseJobData?.ret_code {
            case 200:
                self.performSegue(withIdentifier: "ListSegue", sender: self)
            case 500:
                self.oneButtonAlert(message: "Request includes illegal job id")
            case 402:
                self.balanceAlert()
            default:
                self.oneButtonAlert(message: "Unknown error from Gespage server")
                
            }
        }
    }
    
    func confirm() {
        
        let alert = UIAlertController(title: "Please Confirm", message: "Are you sure you want to print the selected document(s)?", preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            self.tryRelease()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func oneButtonAlert(message: String) {
        
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func balanceAlert() {
        
        let alert = UIAlertController(title: "Alert", message: "Insufficient credit => User balance too low", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Add Funds", style: .default, handler: { action in
        }))
        alert.addAction(UIAlertAction(title: "Not Now", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private struct Constants {
        static let PrintRequestURL = // removed to protect sensitive information
        static let RequestPassword = // removed to protect sensitive information
        static let ReleaseJobURL =  // removed to protect sensitive information
    }
    
}
