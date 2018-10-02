import Foundation
import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var numPages: UILabel!
    @IBOutlet weak var jobPrice: UILabel!
    @IBOutlet weak var checkbox: UIButton!
    @IBOutlet weak var selectAllCheckbox: UIButton!
    @IBOutlet weak var selectAllText: UILabel!
    
    var job: Jobs? {
        didSet {
            self.updateUI()
        }
    }
    
    var jobData: JobModel? {
        didSet {
            self.selectAllUI()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
        
    }
    
    func updateUI() {
        
        title?.text = job?.title
        
        numPages?.text = job?.pages_nb
        
        let jobPriceDouble = Double(Int(job?.price ?? "0") ?? 0)
        let jobPriceValue = String(format: "%.2f", (jobPriceDouble / Double(100)))
        jobPrice?.text = "\(jobPriceValue) ILS"
    }
    
    func selectAllUI() {
        
        selectAllText?.text = "Select All - \(jobData?.num_of_jobs ?? 0) Documents"
        
    }
    
}
