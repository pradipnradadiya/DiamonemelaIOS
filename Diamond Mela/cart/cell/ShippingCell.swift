
import UIKit

class ShippingCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgCheckUncheck: UIImageView!
    var shippingData:PaymentMethodItem.Shipping_charges?{
        didSet{
            lblTitle.text=shippingData?.method_title
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
