import UIKit

protocol SampleProtocol
{
    func myCart()
    func myShipping()
    func myPayment()
}

class CartVC: UIViewController{

    @IBOutlet weak var imgPayment: UIImageView!
    @IBOutlet weak var imgShipping: UIImageView!
    @IBOutlet weak var imgMyCart: UIImageView!
    @IBOutlet weak var paymentContainer: UIView!
    @IBOutlet weak var shippingContainer: UIView!
    @IBOutlet weak var cartContainer: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myCart()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnPayment(_ sender: Any) {
       self.myPayment()
    }
    @IBAction func btnShipping(_ sender: Any) {
       self.myShipping()
    }
    @IBAction func btnBack(_ sender: Any) {
    }
    
    @IBAction func btnCart(_ sender: Any) {
      self.myCart()
    }
    
    
   
    
    
}
extension CartVC : SampleProtocol {
    
    func myCart() {
        cartContainer.isHidden=false
        shippingContainer.isHidden=true
        paymentContainer.isHidden=true
        imgMyCart.image=UIImage(named: "arrow-up")
        imgShipping.image=nil
        imgPayment.image=nil
        
    }
    
    func myShipping() {
        cartContainer.isHidden=true
        shippingContainer.isHidden=false
        paymentContainer.isHidden=true
        imgMyCart.image=nil
        imgShipping.image=UIImage(named: "arrow-up")
        imgPayment.image=nil
    }
    
    func myPayment() {
        cartContainer.isHidden=true
        shippingContainer.isHidden=true
        paymentContainer.isHidden=false
        imgMyCart.image=nil
        imgShipping.image=nil
        imgPayment.image=UIImage(named: "arrow-up")
    }
    
   
}
