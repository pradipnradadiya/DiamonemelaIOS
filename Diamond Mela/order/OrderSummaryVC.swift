import UIKit

class OrderSummaryVC: UIViewController {
    @IBOutlet weak var lblTax: UILabel!
    
    @IBOutlet weak var lblGrandTotal: UILabel!
    @IBOutlet weak var lblShippingCharge: UILabel!
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblShippingAddress: UILabel!
    @IBOutlet weak var lblBillingAddress: UILabel!
    @IBOutlet weak var lblPaymentMethod: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnPlaceOrder(_ sender: Any) {
    }
    
}
