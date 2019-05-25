
import UIKit
import ObjectMapper
import RappleProgressHUD

class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.getBannerSlider(url: Endpoint.bannerSlider.url)
        self.getHeaderMenuBestCategory(url: Endpoint.headerMenu.url)
        self.getMostSellingProduct(url: Endpoint.mostSellingProducts.url)
        self.getPopularProduct(url: Endpoint.popularProducts.url)
        
        // Do any additional setup after loading the view.
    }

}

extension HomeVC{
    
    func getPopularProduct(url:String){
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiPopularProduct(url: url){ (result) in
            RappleActivityIndicatorView.stopAnimation()
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let data=Mapper<PopularProductItem>().map(JSON: result)
                
                
                
            }
            
        }
    }
    
    func getMostSellingProduct(url:String){
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiMostSellingProduct(url: url){ (result) in
            RappleActivityIndicatorView.stopAnimation()
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let data=Mapper<MostSellingProductItem>().map(JSON: result)
                
                
                
            }
            
        }
    }
    
    func getHeaderMenuBestCategory (url:String){
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiHeaderBestCategory(url: url){ (result) in
            RappleActivityIndicatorView.stopAnimation()
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let data=Mapper<HeaderItem>().map(JSON: result)
                
                
                
            }
            
        }
    }
    
    func getBannerSlider(url:String){
        RappleActivityIndicatorView.startAnimatingWithLabel(loadingMsg)
        ApiManager.shared.apiBannerSlider(url: url){ (result) in
            RappleActivityIndicatorView.stopAnimation()
            let status = result[STATUS_CODE] as? String
            print(status as Any)
            if status == FAILURE_CODE || status == nil {
                
            } else {
                let bannerdata=Mapper<BannerItem>().map(JSON: result)
                
                
                
            }
            
        }
    }
    
    
}
