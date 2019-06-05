import UIKit

class MetalCell: UICollectionViewCell {
    
    @IBOutlet weak var btnMetal: UIButton!
    @IBOutlet weak var viewBorder: UIViewX!
    
    var count:Int = 0
    
    var metalData: [String] = [] {
        didSet{
            
            btnMetal.setTitle(metalData[count], for: .normal)
            
        }
    }
    
}
