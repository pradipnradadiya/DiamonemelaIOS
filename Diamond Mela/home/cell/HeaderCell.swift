import UIKit


class HeaderCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgMenuIcon: UIImageView!
    
    var headerData:HeaderItem.Data?{
        didSet{
            lblTitle.text=headerData?.name?.uppercased()
            
            if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
                let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
                if theme == BLACK_THEME_KEY{
                    imgMenuIcon.image = imgMenuIcon.image?.withRenderingMode(.alwaysTemplate)
                   imgMenuIcon.tintColor = UIColor.dmlWhite
                }else if theme == WHITE_THEME_KEY{
                    imgMenuIcon.image = imgMenuIcon.image?.withRenderingMode(.alwaysTemplate)
                    imgMenuIcon.tintColor = UIColor.dmlBlack
                }else{
                    imgMenuIcon.image = imgMenuIcon.image?.withRenderingMode(.alwaysTemplate)
                    imgMenuIcon.tintColor = UIColor.dmlBlack
                }
                
            }
            
            imgMenuIcon.sd_setImage(with: URL(string: "\(headerData?.icon_img ?? "")"), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
            
        }
    }
}

