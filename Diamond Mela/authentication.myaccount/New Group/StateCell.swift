import UIKit

class StateCell: UITableViewCell {

    @IBOutlet weak var lblStateName: UILabel!
    
    
    var state:StateResponse.Data?{
        didSet{
            lblStateName.text = state?.name
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

}
