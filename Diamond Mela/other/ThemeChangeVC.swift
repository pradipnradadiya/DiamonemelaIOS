import UIKit

class ThemeChangeVC: UIViewController {

   var arrPopularProducts = [PopularProductItem.Product_img]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(arrPopularProducts)
        setNavigationControler()
        let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
        homeVC?.arrPopularProducts = self.arrPopularProducts
        self.navigationController?.pushViewController(homeVC!, animated: true)
        // Do any additional setup after loading the view.
    }
    
    
    
    
    //  @IBOutlet weak var toolBar: UIToolbar!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
      
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        //        if let statusBar: UIView = UIApplication.shared.value(forKey: "statusBar") as? UIView{
        //            statusBar.isHidden = true
        //        }
    }
   

}
