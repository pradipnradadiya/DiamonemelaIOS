
import UIKit

class ManageAddressCell: UITableViewCell {
    
    var actionBlockDelete: (() -> Void)? = nil
    var actionBlockEdit: (() -> Void)? = nil
    
    @IBOutlet weak var lblCityState: UILabel!
    @IBOutlet weak var lblTelephone: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    
    var addressData:AddressManageResponse.Data?{
        didSet{
            lblCityState.text="\(addressData?.city ?? ""), \(addressData?.region ?? ""), \(addressData?.postcode ?? "")"
            lblTelephone.text=addressData?.telephone
            lblCountry.text=addressData?.country
            lblAddress.text=addressData?.street
            lblName.text="\(addressData?.firstname ?? "")  \(addressData?.lastname ?? "")"
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
    
    @IBAction func btnEdit(_ sender: Any) {
        self.actionBlockEdit?()
    }
}
