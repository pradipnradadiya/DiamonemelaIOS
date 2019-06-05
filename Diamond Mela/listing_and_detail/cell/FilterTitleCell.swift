
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
            lblTitle.text=filterTitleData?.label
        }
    }
    

}



