import UIKit

class SelectAddressCell: UITableViewCell {
  var actionBlockSelect: (() -> Void)? = nil
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var btnSelect: UIButtonX!
    @IBOutlet weak var lblName: UILabel!
    
    
    var addressData:AddressManageResponse.Data?{
        didSet{
//            lblCityState.text="\(addressData?.city ?? ""), \(addressData?.region ?? ""), \(addressData?.postcode ?? "")"
//            lblTelephone.text=addressData?.telephone
//            lblCountry.text=addressData?.country
            lblAddress.text="\(addressData?.street ?? ""), \n\(addressData?.city ?? ""), \n\(addressData?.region ?? ""), \n\(addressData?.postcode ?? ""), \nT: \(addressData?.country ?? ""), \n\(addressData?.telephone ?? "")"
            
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

    @IBAction func btnSelectClick(_ sender: Any) {
        actionBlockSelect?()
    }
}
