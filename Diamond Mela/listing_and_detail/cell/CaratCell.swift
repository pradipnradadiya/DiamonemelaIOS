import UIKit

class CaratCell: UICollectionViewCell {
    
    @IBOutlet weak var btnCarat: UIButtonX!
    var count:Int = 0
    
    var caratData: [String] = [] {
        didSet{
        btnCarat.setTitle(caratData[count], for: .normal)
        }
    }
    
}
