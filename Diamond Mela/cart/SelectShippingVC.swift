import UIKit

class SelectShippingVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    

}
extension SelectShippingVC{
    
    func paymentSave()  {
        
    }
    
}
