import UIKit

class ReferralListCell: UITableViewCell {

    
    var actionBlockDelete: (() -> Void)? = nil
   
    
    @IBOutlet weak var btnPercent: UIButton!
    @IBOutlet weak var lblName: UILabel!
    
    
    var referralData:ReferralItem.Data?{
        didSet{
            
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

    @IBAction func btnDelete(_ sender: Any) {
        self.actionBlockDelete?()
    }
}
