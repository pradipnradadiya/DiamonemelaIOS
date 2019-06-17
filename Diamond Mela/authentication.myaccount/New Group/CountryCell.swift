
import UIKit

class CountryCell: UITableViewCell {

    @IBOutlet weak var lblCountryName: UILabel!
    
    
    var country : CountryResponse.Data?{
        didSet{
            
            lblCountryName.text = country?.name
            
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
