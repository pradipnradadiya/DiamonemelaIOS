import UIKit
import SDWebImage

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
            
            //self.imgProduct?.setImageWith("retrgegre", usingActivityIndicatorStyle: .gray)
            
     //       imgProduct.sd_setImage(with: "\(IMAGE_URL)catalog/product\(listData?.thumbnail)")
            
            
            imgProduct.sd_setImage(with: URL(string: "\(IMAGE_URL)catalog/product\(listData?.thumbnail! ?? "")"), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
            
            
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
