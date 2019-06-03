import UIKit

class FilterDataCell: UITableViewCell {

    
    @IBOutlet weak var lblRadioTitle: UILabel!
    @IBOutlet weak var btnRadio: UIButton!
    
    
    var filterData:SortFilterItem.Option_data?{
        didSet{
            lblRadioTitle.text=filterData?.label
            
            if filterData?.isSelected == true {
//                lblRadioTitle.textColor=UIColor.red
                btnRadio.setImage(UIImage(named: "radio-select"), for: .normal)
                
            }else{
//                lblRadioTitle.textColor=UIColor.black
                 btnRadio.setImage(UIImage(named: "radio"), for: .normal)
            }
//
        }
        
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func btnRadioClick(_ sender: Any) {
    }
}
