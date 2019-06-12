
import UIKit

class ShippingCell2: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgCheckUncheck: UIImageView!
    var shippingData:PaymentMethodItem.Shipping_charges?{
        didSet{
            lblTitle.text="\(shippingData?.method_title ?? "") Rs.\(shippingData?.price ?? 0)"
            
            if shippingData?.isSelected == true{
                imgCheckUncheck.image = UIImage.init(named: "radio-select")
            
            }else{
                imgCheckUncheck.image = UIImage.init(named: "radio")
            }
            
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
