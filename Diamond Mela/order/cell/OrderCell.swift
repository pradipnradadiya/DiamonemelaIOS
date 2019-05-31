import UIKit
import ObjectMapper
class OrderCell: UITableViewCell {
    
    var actionBlockView: (() -> Void)? = nil
    var actionBlockPrint: (() -> Void)? = nil
    var actionBlockCancel: (() -> Void)? = nil
    
    @IBOutlet weak var lblOrderNo: UILabel!
    @IBOutlet weak var btnViewMore: UIButton!
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblStoneDetail: UILabel!
    @IBOutlet weak var lblMetalDetail: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblSku: UILabel!
    @IBOutlet weak var imgProduct: UIImageViewX!
    
    var rowPosition:Int?
    
    @IBOutlet weak var btnView: UIButton!
    @IBOutlet weak var btnPrint: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var orderData:OrderItem.Data? {
        didSet{
            print(orderData?.order_items?.count as Any)
            if (orderData?.order_items?.count)! > 1 {
                btnViewMore.isHidden=false
            }else{
                btnViewMore.isHidden=true
            }
        }
    }
    
  
    
    @IBAction func btnCancel(_ sender: Any) {
        actionBlockCancel?()
    }
    
    @IBAction func btnPrint(_ sender: Any) {
        actionBlockPrint?()
    }
    
    @IBAction func btnView(_ sender: Any) {
        actionBlockView?()
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnViewMore(_ sender: Any) {
          actionBlockView?()
    }
}
