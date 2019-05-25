import UIKit

class PaymentVC: UIViewController {

    @IBOutlet weak var btnContinue: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnContinue(_ sender: Any) {
        let shipping = self.storyboard?.instantiateViewController(withIdentifier: "SelectShippingVC") as? SelectShippingVC
        self.navigationController?.pushViewController(shipping!, animated: true)
    }
    

}

extension PaymentVC{
    
}
