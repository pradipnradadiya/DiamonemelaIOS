import UIKit

class ListCell: UICollectionViewCell {
    
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblQty: UILabelX!
    @IBOutlet weak var lblProName: UILabel!
    @IBOutlet weak var lblSku: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblGoldType: UILabel!
    
    var listData : ListItem.Data?{
        didSet{
            lblSku.text=listData?.sku
            lblProName.text=listData?.name
            let amountString=Float((listData?.custom_price)!).asLocaleCurrency
            lblPrice.text=amountString
            
            
         //   imgProduct.setImageWith("", usingActivityIndicatorStyle: .gray)
        }
        
    }
    
}


extension Float {
    var asLocaleCurrency:String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = NSLocale.current
        return formatter.string(from: self as NSNumber)!
    }
}
