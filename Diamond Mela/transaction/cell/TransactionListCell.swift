import UIKit

class TransactionListCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblCrDr: UILabel!
    @IBOutlet weak var lblOrderId: UILabel!
    
    var transactionData:TransactionItem.Data?{
        didSet{
            lblPrice.text="\(transactionData?.transction_price ?? 0)"
            lblCrDr.text=transactionData?.description
            lblOrderId.text=transactionData?.increment_id
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
