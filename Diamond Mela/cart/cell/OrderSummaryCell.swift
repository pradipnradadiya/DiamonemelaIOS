import UIKit

class OrderSummaryCell: UITableViewCell {

    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblQtyPrice: UILabel!
    @IBOutlet weak var lblQty: UILabel!
    @IBOutlet weak var lblSize: UILabel!
    @IBOutlet weak var lblMetalQuality: UILabel!
    @IBOutlet weak var lblStoneQuality: UILabel!
    @IBOutlet weak var lblSku: UILabel!
    
    var orderData : OrderSummaryItem.Data?{
        didSet{
            lblSku.text=orderData?.sku
            lblStoneQuality.text=orderData?.stonequality
            lblMetalQuality.text=orderData?.metaldetails
//            lblSize.text=orderData?.ringsize
            lblQty.text="\(orderData?.qty ?? 0)"
            lblQtyPrice.text="\(orderData?.price ?? 0)"
            lblPrice.text=priceFormat2("\(orderData?.subtotal ?? 0)")
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
