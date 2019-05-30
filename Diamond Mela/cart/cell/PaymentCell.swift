import UIKit

class PaymentCell: UITableViewCell {

    @IBOutlet weak var imgMethodLogo: UIImageView!
    @IBOutlet weak var lblPlacing: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPaymentTitle: UILabel!
    @IBOutlet weak var imgCheckUncheck: UIImageView!
    var actionClick: (() -> Void)? = nil
    var payment:PaymentMethodItem.Data?{
        didSet{
            lblPaymentTitle.text=payment?.label
            lblAddress.text=payment?.info
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

    @IBAction func btnClick(_ sender: Any) {
        self.actionClick?()
    }
}
