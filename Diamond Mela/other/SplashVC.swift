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
        
        
        //retrieve from UserDefaults
        if (UserDefaults.standard.string(forKey: THEME_USEDEFAULTS)) != nil {
            let theme = UserDefaults.standard.string(forKey: THEME_USEDEFAULTS) ?? ""
            if theme == BLACK_THEME_KEY{
                
            }else if theme == WHITE_THEME_KEY{
//                userSessionData.set(BLACK_THEME_KEY, forKey: THEME_USEDEFAULTS)
            }
            
        }else{
            userSessionData.set(WHITE_THEME_KEY, forKey: THEME_USEDEFAULTS)
        }
     
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
                    let login = self.storyboard?.instantiateViewController(withIdentifier: "HomeVC") as? HomeVC
                    login?.arrPopularProducts = self.arrPopularProducts
                    self.navigationController?.pushViewController(login!, animated: true)
                }
                
            }
            
        }
    }
}
