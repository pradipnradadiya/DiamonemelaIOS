
import UIKit

class PaymentCell2: UITableViewCell {

    
    @IBOutlet weak var lblPlacing: UILabel!
    @IBOutlet weak var imgLogo: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgCheckIncheck: UIImageView!
    var paymentVcInstance = PaymentVC()
    var actionClick: (() -> Void)? = nil
    var payment:PaymentMethodItem.Data?{
        didSet{
            lblTitle.text=payment?.label
//            lblAddress.text=payment?.info
            if payment?.isSelected == true{
                imgCheckIncheck.image = UIImage.init(named: "radio-select")
                paymentVcInstance.paymentTypes = payment?.value ?? ""
            }else{
                imgCheckIncheck.image = UIImage.init(named: "radio")
            }
            
            imgLogo.sd_setImage(with: URL(string: (payment?.image)!), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
            
            
        }
    }
 
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func btnClick(_ sender: Any) {
        actionClick?()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
