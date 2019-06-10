import UIKit

class CaratCell: UICollectionViewCell {
    
    @IBOutlet weak var btnCarat: UIButtonX!
   var actionClick: (() -> Void)? = nil
    
    var caratData: [String] = [] {
        didSet{
            
            if caratData.first! == ProductDetailVC.caratValue{
                btnCarat.borderColor = UIColor.selectButtonColor
                btnCarat.borderWidth = 1
                btnCarat.setTitleColor(UIColor.selectButtonColor, for: .normal)
            }else{
                btnCarat.borderColor = UIColor.unSelectButtonColor
                btnCarat.borderWidth = 1
                btnCarat.setTitleColor(UIColor.unSelectButtonColor, for: .normal)
                
            }
            
        btnCarat.setTitle(caratData.first!, for: .normal)
            
        }
    }
    
    @IBAction func btnCarat(_ sender: Any) {
        actionClick?()
    }
}
