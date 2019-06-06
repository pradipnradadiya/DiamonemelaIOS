import UIKit

class PopularProductCell: UICollectionViewCell {
    
    @IBOutlet weak var lblGoldType: UILabel!
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSku: UILabel!
    @IBOutlet weak var imgProduct: UIImageView!
    @IBOutlet weak var btnQty: UILabelX!
    @IBOutlet weak var btnDownload: UIButton!
    
    var actionBlockDownload: (() -> Void)? = nil
    
    var popularProduct:PopularProductItem.Product_img?{
        didSet{
            
            if popularProduct?.download_flag == 1 {
                btnDownload.isEnabled=false
            }else{
                btnDownload.isEnabled=true
            }
            
            
            if popularProduct?.type_id == "simple"{
                if Int((popularProduct?.type_id)!) ?? 0 > 1{
                    btnQty.isHidden=false
                    btnQty.text="QTY \(popularProduct?.qty ?? "")"
                }else{
                    btnQty.isHidden=true
                }
                
            }else{
                btnQty.isHidden=true
            }
            
            
            lblSku.text=popularProduct?.sku
            lblName.text=popularProduct?.name
            
            let amountString=Float((popularProduct?.custom_price)!)!.asLocaleCurrency
            lblPrice.text=amountString
            
            //self.imgProduct?.setImageWith("retrgegre", usingActivityIndicatorStyle: .gray)
            
            //       imgProduct.sd_setImage(with: "\(IMAGE_URL)catalog/product\(listData?.thumbnail)")
            
            
            imgProduct.sd_setImage(with: URL(string: "\(IMAGE_URL)catalog/product\(popularProduct?.thumbnail! ?? "")"), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
            
            
            
        }
    }
    
        
    @IBAction func btnDownload(_ sender: Any) {
        self.actionBlockDownload?()
    }
    
    
}
