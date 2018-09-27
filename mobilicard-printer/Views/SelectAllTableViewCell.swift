import Foundation
import UIKit

class SelectAllTableViewCell: UITableViewCell {
    
    var jobs: JobModel? {
        didSet {
            self.updateUI()
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
        
    }
    
}
