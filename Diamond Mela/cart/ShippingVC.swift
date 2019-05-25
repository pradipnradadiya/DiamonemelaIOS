
import UIKit

class ShippingVC: UIViewController {

    @IBOutlet weak var btnSaveContinue: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
   
    @IBAction func btnSaveContinue(_ sender: Any) {
        (parent as! SampleProtocol).myPayment()
    }
    

}

extension ShippingVC{
    func getSelectPaymentMethodList()  {
        
    }
}
