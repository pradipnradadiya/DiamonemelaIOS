import UIKit

class TransactionDetailCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblMetalWeight: UILabel!
    @IBOutlet weak var lblStoneDetail: UILabel!
    @IBOutlet weak var lblSku: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblOrderNo: UILabel!
    
    var transactionDetail:TransactionItem.Order_item?{
        didSet{
            lblOrderNo.text=transactionDetail?.product_increment_id
            lblName.text=transactionDetail?.product_name
            lblSku.text=transactionDetail?.product_sku
            lblStoneDetail.text=transactionDetail?.product_stonequality
            lblMetalWeight.text=transactionDetail?.product_metalweight
            lblPrice.text=priceFormat2("\(transactionDetail?.product_price ?? "")")
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
