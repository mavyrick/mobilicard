import UIKit
import Foundation

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var jobData: JobModel? {
        didSet {
            //            self.listTableView.reloadData()
            print("jobData test 4")
            print(jobData)
        }
    }
    
    var jobs: Jobs?
    var releaseJobData: ReleaseJobModel?
    
    //    var cells = [ListTableViewCell]()
    
    //    var jobData: JobModel
    //
    //    init(jobData: JobModel) {
    //        self.jobData = jobData
    //        super.init(jobData: jobData)
    //    }
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        super.init(coder: aDecoder)
    //
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    //
    //    required init?(coder aDecoder: NSCoder) {
    //        fatalError("init(coder:) has not been implemented")
    //    }
    
    //    var jobData: JobModel?
    //    var jobData: JobModel = JobModel(from: try JSONDecoder)
    
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
        
        //        listTableView?.dataSource = jobData
        
        totalCost.text = "0.00 ILS"
        
        totalCost2()
        
        self.sendButton.layer.cornerRadius = 5
        self.refreshButton.layer.cornerRadius = 5
        
        self.listTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
    }
    
    //    func getJobData(completed: @escaping () -> ()) {
    //
    //        let parameters: [String: Any] = [
    //            "password": Constants.RequestPassword,
    //            "mobile_number": "0542323420",
    //            "machine_id": 0000,
    //            "operator_id": 0
    //        ]
    //
    //        guard let testURL = URL(string: Constants.PrintRequestURL) else { return }
    //
    //        var request = URLRequest(url: testURL)
    //
    //        request.httpMethod = "POST"
    //        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    //
    //        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return }
    //
    //        print(httpBody)
    //
    //        request.httpBody = httpBody
    //
    //        let session = URLSession.shared
    //
    //        let task = session.dataTask(with: request) { (data, response, error) in
    //
    //            guard error == nil else {
    //                print("error 1")
    //                print(error!)
    //                return
    //            }
    //            guard let data = data else { return }
    //
    //            do {
    //
    //                let decoder = JSONDecoder()
    //                let jobDataTest = try decoder.decode(JobModel.self, from: data)
    //                self.jobData = jobDataTest
    //
    //                print(self.jobData?.jobs?[0].jobid)
    //                //                print(self.jobData[0].jobs?[0].title)
    //                //                print(Int((jobDataTest.jobs?.count)!))
    //                //                print(jobDataTest.jobs?[0].checkbox)
    //                //                self.jobData = jobDataTest.jobs
    //                //                print(jobDataTest.jobs?[0].title)
    //                //                print(self.jobData)
    //                //                print(self.jobData)
    //
    //                //                self.totalCost.text = self.jobData?.total_cost
    //
    //                DispatchQueue.main.async {
    //
    //                    completed()
    //
    //                    self.activityIndicator.isHidden = true
    //
    //                    self.totalCost.text = "\(self.jobData?.total_cost ?? "0") ILS"
    //
    //                    self.listTableView.reloadData()
    //
    //                    print(self.jobData?.ret_code)
    //
    //                    if self.jobData?.ret_code != 200 {
    //                        self.noJobs.isHidden = false
    //                        self.refreshButton.isHidden = false
    //                    }
    //
    //                    print("tokens")
    //                    print(self.jobData?.total_cost)
    //                    print((self.jobData?.user_token)!)
    //                    print((self.jobData?.device_token)!)
    //
    //                }
    //                return
    //            } catch let err {
    //                print("Err", err)
    //            }
    //
    //        }
    //        task.resume()
    //
    //    }
    
    @IBAction func refreshButton(_ sender: UIButton) {
        
        //        getJobData() {
        //            self.listTableView.reloadData()
        //        }
        
        noJobs.isHidden = true
        refreshButton.isHidden = true
        activityIndicator.isHidden = false
    }
    
    
    //    var printOrCopy = FrontPageViewController().printOrCopy
    //
    //    var printOrCopyTest = ""
    
    var printOrCopy = "test"
    //
    
    //    var printOrCopy = FrontPageViewController().printOrCopy
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        //        var printOrCopyText = ""
        //
        //        if printOrCopy == true {
        //            printOrCopyText = "Print"
        //        } else {
        //            printOrCopyText = "Copy"
        //        }
        
        //        return "Documents to \(printOrCopy)"
        
        //        let section = self.sections[section]
        
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
                //                print(jobidArray)
            } else {
                cell.checkbox?.isSelected = false
                //                jobidArray = []
                //                print(jobidArray)
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
                //                print(jobidArray)
            }
            //            } else {
            //                if let index = jobidArray.index(of: cell.job?.jobid ?? "") {
            //                    jobidArray.remove(at: index)
            //                }
            ////                print(jobidArray)
            //            }
            
            //            if checkedItems.count != jobData?.jobs?.count {
            //                cell.selectAllCheckbox?.isSelected = false
            //            } else if (checkedItems.count + 1) == jobData?.jobs?.count {
            //                cell.selectAllCheckbox?.isSelected = true
            //            }
            
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
    
    //    @IBAction func checkboxChecked(_ sender: Any) {
    //
    //        print(listTableView.numberOfRows(inSection: 1))
    //
    //        let totalRows = listTableView.numberOfRows(inSection: 1)
    ////        for row in 0..<totalRows {
    ////            //            let cell = listTableView.selectRow(at: IndexPath(row: row, section: 1), animated: false, scrollPosition: .none)
    ////
    ////        }
    //
    //        if sender.isSelected {
    //                        sender.isSelected = false
    //                        jobData?.jobs?[0].checkbox = false
    //                        print(jobData?.jobs?[0].checkbox)
    //                        print(sender)
    //                    } else {
    //                        sender.isSelected = true
    //                        jobData?.jobs?[0].checkbox = true
    //                        print(jobData?.jobs?[0].checkbox)
    //                    }
    //
    //                }
    //
    //    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell: ListTableViewCell!
        
        //        let document = listTableView.dequeueReusableCell(withIdentifier: "Document", for: indexPath) as! ListTableViewCell
        
        //        let selectAll = listTableView.dequeueReusableCell(withIdentifier: "SelectAll", for: indexPath) as! ListTableViewCell
        
        if (indexPath.section == 0) {
            
            cell = listTableView.dequeueReusableCell(withIdentifier: "SelectAll", for: indexPath) as! ListTableViewCell
            cell.jobData = jobData
            
        } else if (indexPath.section == 1) {
            
            cell = listTableView.dequeueReusableCell(withIdentifier: "Document", for: indexPath) as! ListTableViewCell
            cell.job = jobData?.jobs?[indexPath.row]
            
            //            cells.insert(cell ?? ListTableViewCell(), at :0)
        }
        
        cell.selectionStyle = .none
        
        //        cell.title?.text = jobData?.jobs?[indexPath.row].title
        //        cell.jobid?.text = jobData?.jobs?[indexPath.row].jobid
        //        cell.numPages?.text = jobData?.jobs?[indexPath.row].pages_nb
        //        cell.jobPrice?.text = jobData?.jobs?[indexPath.row].price
        
        //        totalCost.text = "$\(jobData?.total_cost!)"
        
        //        var jobPriceArray = [jobData?.jobs?[indexPath.row].title]
        
        var jobPriceArray = NSMutableArray()
        
        jobPriceArray.insert(jobData?.jobs?[indexPath.row].price, at: 0)
        
        print(jobPriceArray)
        
        //        for i in Int(jobData?.jobs?[indexPath.row].price) {
        //
        //            print(i)
        //
        //
        //        }
        
        //        print(Int((jobData?.jobs?[indexPath.row].price)!).reduce(0, +))
        
        //        totalCost.text = jobData
        
        print("test tableview 123")
        print(cell)
        return cell
        
    }
    
    func totalCost2() {
        
        print(jobData?.jobs?[0].jobid)
        
        
        for i in 0...1 {
            
            print(jobData?.jobs?[i].jobid)
            
        }
        
    }
    
    //    @IBAction func checkBoxChecked(_ sender: UIButton) {
    //
    //        if sender.isSelected {
    //            sender.isSelected = false
    //            jobData?.jobs?[0].checkbox = false
    //            print(jobData?.jobs?[0].checkbox)
    //            print(sender)
    //        } else {
    //            sender.isSelected = true
    //            jobData?.jobs?[0].checkbox = true
    //            print(jobData?.jobs?[0].checkbox)
    //        }
    //
    //    }
    
    
    //    @IBAction func selectAllCheckBoxChecked(_ sender: UIButton) {
    //
    //        if sender.isSelected {
    //            selectAllCheckbox.isSelected = false
    ////            selectAllCheckBox.isSelected = false
    ////            sender.isSelected = false
    //        } else {
    //            selectAllCheckbox.isSelected = true
    //
    ////            selectAllCheckBox.isSelected = true
    ////            sender.isSelected = true
    //
    //        }
    //
    //    }
    
    //    func releaseJob(completed: @escaping () -> ()) {
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
        static let PrintRequestURL = "https://gvs.mobilicard.com/external/rs/public/do_print_request"
        static let RequestPassword = "!dneviliboM@"
        static let ReleaseJobURL =  "https://gvs.mobilicard.com/external/rs/public/do_release_job"
    }
    
}
