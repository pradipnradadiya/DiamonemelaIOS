import UIKit
import SDWebImage

class ListCell: UICollectionViewCell {
    
    var actionBlockDownload: (() -> Void)? = nil
    
    @IBOutlet weak var btnDownload: UIButton!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var lblQty: UILabelX!
    @IBOutlet weak var lblProName: UILabel!
    @IBOutlet weak var lblSku: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblGoldType: UILabel!
    
    @IBOutlet weak var btnDownlod: UIButton!
    
    @IBAction func btnDownload(_ sender: Any) {
        self.actionBlockDownload?()
    }
    var listData : ListItem.Data?{
        didSet{
            
            if listData?.download_flag == 1 {
                btnDownlod.isEnabled=false
            }else{
                btnDownlod.isEnabled=true
            }
            
            
            if listData?.type_id == "simple"{
                if Int((listData?.type_id)!) ?? 0 > 1{
                    lblQty.isHidden=false
                    lblQty.text="QTY \(listData?.qty ?? "")"
                }else{
                    lblQty.isHidden=true
                }
            }else{
                lblQty.isHidden=true
            }
            
            
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
