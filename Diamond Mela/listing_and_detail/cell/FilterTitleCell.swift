
import UIKit

class FilterTitleCell: UITableViewCell {

    @IBOutlet weak var viewFilterTitle: UIView!
    @IBOutlet weak var imgArrow: UIImageView!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
          //viewFilterTitle.backgroundColor=UIColor.rgb(red: 155, green: 15, blue: 86)
        
        // Configure the view for the selected state
    }
    
    var filterTitleData:SortFilterItem.Data?{
        didSet{
            
           
            //retrieve from UserDefaults
            if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
                let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
                if theme == BLACK_THEME_KEY{
                    if filterTitleData?.isSelect == true{
                        viewFilterTitle.backgroundColor = UIColor.selectButtonColor
                        lblTitle.textColor = UIColor.white
                        imgArrow.isHidden = false
                        imgArrow.tintColor = UIColor.dmlBlack
                    }else{
                        viewFilterTitle.backgroundColor = UIColor.dmlBlack
                        lblTitle.textColor = UIColor.white
                        imgArrow.tintColor = UIColor.dmlBlack
                        imgArrow.isHidden = true
                    }
                }else if theme == WHITE_THEME_KEY{
                    if filterTitleData?.isSelect == true{
                        viewFilterTitle.backgroundColor = UIColor.selectButtonColor
                        lblTitle.textColor = UIColor.white
                        imgArrow.tintColor = UIColor.dmlWhite
                    }else{
                        viewFilterTitle.backgroundColor = UIColor.white
                        lblTitle.textColor = UIColor.black
                        imgArrow.tintColor = UIColor.dmlWhite
                    }
                }else{
                    if filterTitleData?.isSelect == true{
                        viewFilterTitle.backgroundColor = UIColor.selectButtonColor
                        lblTitle.textColor = UIColor.white
                        imgArrow.tintColor = UIColor.dmlWhite
                        
                    }else{
                        viewFilterTitle.backgroundColor = UIColor.white
                        lblTitle.textColor = UIColor.black
                        imgArrow.tintColor = UIColor.dmlWhite
                    }
                }
                
            }
            
            
            
            
//            if filterTitleData?.isSelect == true{
//                viewFilterTitle.backgroundColor = UIColor.selectButtonColor
//                lblTitle.textColor = UIColor.white
//            }else{
//                 viewFilterTitle.backgroundColor = UIColor.white
//                lblTitle.textColor = UIColor.black
//            }
            
            
            imgIcon.sd_setImage(with: URL(string: (filterTitleData?.icon)!), placeholderImage: UIImage(named: "Diamond-mela-mobile-logo.png"))
                
            lblTitle.text=filterTitleData?.label
            
            
          
         
            
            
                
            }
            
     
    }
    

}



