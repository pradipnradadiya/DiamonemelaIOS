import UIKit



class ManageBankCell: UITableViewCell {

    
   var actionBlockDelete: (() -> Void)? = nil
   var actionBlockEdit: (() -> Void)? = nil
    
    @IBOutlet weak var lblBranchName: UILabel!
    @IBOutlet weak var lblIfscCode: UILabel!
    @IBOutlet weak var lblAccountNumber: UILabel!
    @IBOutlet weak var lblAccountHolderName: UILabel!
    @IBOutlet weak var lblBankName: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    @IBOutlet weak var btnDelete: UIButton!
    
    var bankData:BankItem.Data?{
        didSet{
            lblBranchName.text=bankData?.branch_name
            lblIfscCode.text=bankData?.ifsc_code
            lblAccountNumber.text=bankData?.bank_account_number
            lblAccountHolderName.text=bankData?.bank_account_holder
            lblBankName.text=bankData?.bank_name
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
    
    @IBAction func btnDeleteClick(_ sender: Any) {
       actionBlockDelete?()
    }
    
    @IBAction func btnEditClick(_ sender: Any) {
         actionBlockEdit?()
    }
    
}
