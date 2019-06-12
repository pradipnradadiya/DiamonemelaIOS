import UIKit

class PaymentCell: UITableViewCell {

    
    @IBOutlet weak var lblPlacing: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblPaymentTitle: UILabel!
    @IBOutlet weak var imgCheckUncheck: UIImageView!
    
    var paymentVcInstance = PaymentVC()
    
    var actionClickPayment: (() -> Void)? = nil
    var payment:PaymentMethodItem.Data?{
        
        didSet{
            lblPaymentTitle.text=payment?.label
            lblAddress.text=payment?.info
            
            if payment?.isSelected == true{
                imgCheckUncheck.image = UIImage.init(named: "radio-select")
                paymentVcInstance.paymentTypes = payment?.value ?? ""
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

    @IBAction func btnClick(_ sender: Any) {
        self.actionClickPayment?()
    }
}
