import UIKit

class DmlButton : UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        
        if userAlreadyExist(kUsernameKey: "theme"){
            if saveTheme.string(forKey: "userId")! == "black"{
                let color = UIColor.red
                self.setTitleColor(color, for: .normal)
            }else{
                let color = UIColor.red
                self.setTitleColor(color, for: .normal)
            }
        }else{
            
        }
        
        
      
        
        
//        let disabledColor = color.withAlphaComponent(0.3)
//
//        _ = UIColor(red: 100.0 / 255.0, green: 100.0 / 255.0, blue: 100.0 / 255.0, alpha: 1).cgColor
//        _ = UIColor(red: 50.0 / 255.0, green: 50.0 / 255.0, blue: 50.0 / 255.0, alpha: 1).cgColor
//
//        let btnFont = "Noteworthy"
//        _ = 200
//        _ = 60
//
//
//        self.layer.cornerRadius = 10.0
//        self.clipsToBounds = true
//        self.layer.borderWidth = 3.0
//        self.layer.borderColor = color.cgColor
//
//
//
//
//        self.setTitleColor(disabledColor, for: .disabled)
//        self.titleLabel?.font = UIFont(name: btnFont, size: 25)
//        self.titleLabel?.adjustsFontSizeToFitWidth = true
//        self.setTitle(self.titleLabel?.text?.capitalized, for: .normal)
        //TODO: Code for our button
    }
}
