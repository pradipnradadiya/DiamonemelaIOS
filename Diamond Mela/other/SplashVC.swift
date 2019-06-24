import UIKit
import ObjectMapper
import RappleProgressHUD

class SplashVC: UIViewController {

    var arrPopularProducts = [PopularProductItem.Product_img]()
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getPopularProduct(url: Endpoint.popularProducts.url)
        
        
        // Do any additional setup after loading the view.
    }

}
extension SplashVC{
    func getPopularProduct(url:String){
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiPopularProduct(url: url){ (result) in
            
            RappleActivityIndicatorView.stopAnimation()
            
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let data=Mapper<PopularProductItem>().map(JSON: result)
                self.arrPopularProducts = (data?.product_img)!
                if (UserDefaults.standard.string(forKey: USER_SESSION_DATA_KEY)) != nil {
                    let homeVC = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
                    homeVC?.arrPopularProducts = self.arrPopularProducts
                    self.navigationController?.pushViewController(homeVC!, animated: true)
                    
                }else{
                    let login = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC
                  
                    self.navigationController?.pushViewController(login!, animated: true)
                }
                
            }
            
        }
    }
}
