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
            lblStoneQuality.attributedText="Stone Quality: \(orderData?.stonequality ?? "")".withBoldText(text: "Stone Quality:")
            lblMetalQuality.attributedText="Metal Quality: \(orderData?.metaldetails ?? "")".withBoldText(text: "Metal Quality:")
//            lblSize.text=orderData?.ringsize
            lblQty.attributedText="Qty: \(orderData?.qty ?? 0)".withBoldText(text: "Qty:")
            lblQtyPrice.text=priceFormat2("\(orderData?.price ?? 0)")
            lblPrice.text=priceFormat2("\(orderData?.subtotal ?? 0)")
            
            
            if orderData?.ringsize != nil{
                lblSize.isHidden = false
                lblSize.attributedText="Ring Size: \(orderData?.ringsize ?? "")".withBoldText(text: "Ring Size:")
            }else if orderData?.bracelets != nil{
                lblSize.isHidden = false
                lblSize.attributedText="Bracelet Size: \(orderData?.ringsize ?? "")".withBoldText(text: "Bracelet Size:")
            }else if orderData?.bangles != nil{
                lblSize.isHidden = false
                lblSize.attributedText="Bangle Size: \(orderData?.ringsize ?? "")".withBoldText(text: "Bangle Size:")
            }else if orderData?.pendents != nil{
                lblSize.isHidden = false
                lblSize.attributedText="Pendent Size: \(orderData?.ringsize ?? "")".withBoldText(text: "Pendent Size:")
            }else{
                lblSize.isHidden = true
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

}
