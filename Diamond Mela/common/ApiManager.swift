import Foundation
import UIKit
import Alamofire
import Foundation
import SystemConfiguration

//uid global string
//let uid : String? = "&uid=\(registerdUserId.string(forKey: "userId")!)"
//let uid2 : String? = "?uid=\(registerdUserId.string(forKey: "userId")!)"

enum Endpoint {
    //----------Authentication-------------
    
    case login
    case signUp
    case forgotPassword
    case getAllCountry
    case getAllState
    
    
    //-----------Home page--------------------
    case bannerSlider
    case headerMenu
    case popularProducts
    case mostSellingProducts
    
    //------------My Account-------------------
    case getAllAddress
    case editContactInfo
    case editDefaultShipping
    case editDefaultBilling
    case editAdditionalBilling
    case addNewAddress
    case deleteAddress
    case changePassword
    case addBankDetail
    case editBankDetail
    case deleteBankDetail
    case listBankDetail
    case getCountryList
    case getStateList
    
    //Download
    case getDownloadProductList
    case downloadAllProduct
    case deleteAllProduct
    
    //Transaction
    case getTransactionList
    
    //Referral
    case createReferral
    case referralList
    case deleteReferral
    
    //Listing and Detail
    case productList
    case getSortFilter
    case addToDownloadProduct
    case getProductDetail
    case rtsProductClick
    case addToCart
    
    
    
    //Order
    case getOrder
    case getOrderDetail
    case cancelOrder
    case printOrder
    
    //Policy
    case policy
    
    //Cart
    case cartList
    case updateCartItem
    case deleteCartItem
    case paymentMethodList
    case paymentSave
    case orderSummary
    case placeOrder
    
    
    //My Stock
    case myStockList
    
    var url: String {
        
        let baseUrl: String = BASE_URL
        
        switch self {
            
        //-------------------My Stock-------------------
        case .myStockList:
            return baseUrl+"dmlapi/mystock/MystockView"
            
            
        //------------------Cart------------------------
        case .cartList:
            return baseUrl+"dmlapi/addtocart/listcartitems"
            
        case .updateCartItem:
            return baseUrl+"dmlapi/addtocart/updatecartqty"
            
        case .deleteCartItem:
            return baseUrl+"dmlapi/addtocart/removecartitem"
            
        case .paymentMethodList:
            return baseUrl+"dmlapi/addtocart/paymentmethods"
            
        case .paymentSave:
            return baseUrl+"dmlapi/addtocart/paymentsave"
            
        case .orderSummary:
            return baseUrl+"dmlapi/addtocart/orderdetailsview"
            
        case .placeOrder:
            return baseUrl+"dmlapi/addtocart/createorders"
          
        //------------------Policy----------------------
        case .policy:
            return baseUrl+"dmlapi/home/policycontent"
            
            
        //------------------Order------------------------
        case .getOrder:
            return baseUrl+"dmlapi/allorder/orderview/"
            
        case .getOrderDetail:
            return baseUrl+"dmlapi/allorder/OrderViewDetail/"
            
        case .cancelOrder:
            return baseUrl+"dmlapi/allorder/CancelOrder"
            
        case .printOrder:
            return baseUrl+"dmlapi/allorder/downloadpdf"
            
            
            
        //------------------Listing----------------------------
        case .productList:
            return baseUrl+"dmlapi/product/getallproductbycategory"
            
        case .getSortFilter:
            return baseUrl+"dmlapi/product/getreadytoshipfilteroption"
            
        case .addToDownloadProduct:
            return baseUrl+"dmlapi/downloadproduct/addtodownloadlisting"
            
        case .getProductDetail:
            return baseUrl+"dmlapi/product/getproductdetails"
            
        case .rtsProductClick:
            return baseUrl+"dmlapi/product/getrtssliderdetails"
            
        case .addToCart:
            return baseUrl+"dmlapi/addtocart/addcartcustom"
            
        //------------------Referral---------------------------
        case .createReferral:
            return baseUrl+"dmlapi/customers/createreferral"
            
        case .referralList:
            return baseUrl+"dmlapi/customers/getallreferrals"
            
        case .deleteReferral:
            return baseUrl+"dmlapi/customers/deletereferral"
            
        //------------------Transaction-------------------------
        case .getTransactionList:
            return baseUrl+"dmlapi/transaction/transactionview/"
            
        //------------------Download-----------------------------
        case .getDownloadProductList:
            return baseUrl+"dmlapi/downloadproduct/downloadview/"
            
        case .deleteAllProduct:
            return baseUrl+"dmlapi/downloadproduct/DeleteAllProduct/"
            
        case .downloadAllProduct:
            return baseUrl+"dmlapi/downloadproduct/DownloadAllImage/"
            
        //------------------My Account---------------------------
        case .getAllAddress:
            return baseUrl+"dmlapi/customers/getalladdress/"
            
        case .editContactInfo:
            return baseUrl+"dmlapi/customers/editcustomer/"
            
        case .editDefaultShipping:
            return baseUrl+"dmlapi/customers/editdefaultshipping/"
          
        case .editDefaultBilling:
            return baseUrl+"dmlapi/customers/editdefaultbilling/"
            
        case .editAdditionalBilling:
            return baseUrl+"dmlapi/customers/editaddressbyid/"
            
        case .addNewAddress:
            return baseUrl+"dmlapi/customers/createaddress/"
            
        case .deleteAddress:
            return baseUrl+"dmlapi/customers/deleteaddress/"
            
        case .changePassword:
            return baseUrl+"dmlapi/customers/changepassword/"
            
        case .addBankDetail:
            return baseUrl+"dmlapi/customers/addbankdetails/"
            
        case .editBankDetail:
            return baseUrl+"dmlapi/customers/editbankdetails/"
            
        case .deleteBankDetail:
            return baseUrl+"dmlapi/customers/deletebankdetails/"
            
        case .listBankDetail:
            return baseUrl+"dmlapi/customers/listbankdetails/"
            
        case .getCountryList:
            return baseUrl+"dmlapi/customers/getallcountrylist/"
            
        case .getStateList:
            return baseUrl+"dmlapi/customers/getallregionlist/"
            
            
        //------------------Authentication-----------------------
        case .login:
            return baseUrl+"dmlapi/customers/ValidateUser/"
            
        case .signUp:
            return baseUrl+"dmlapi/customers/registercustomer/"
            
        case .forgotPassword:
            return baseUrl+"dmlapi/customers/forgorpassword/"
            
        case .getAllCountry:
            return baseUrl+"dmlapi/customers/getallcountrylist/"
            
        case .getAllState:
            return baseUrl+"dmlapi/customers/getallregionlist/"
            
            
        //------------------Homepage-------------------------------
        case .bannerSlider:
            return baseUrl+"dmlapi/home/gethomeslider"
            
        case .headerMenu:
            return baseUrl+"dmlapi/home/getallcategorys"
            
        case .popularProducts:
            return baseUrl+"dmlapi/home/getpopularproduct"
            
        case .mostSellingProducts:
            return baseUrl+"dmlapi/home/bestsellerproduct"
            
            
        }
    }
}

class ApiManager {
    static let shared = ApiManager()
    
    private let manager: Alamofire.SessionManager = {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.timeoutIntervalForResource = 10
        return Alamofire.SessionManager(configuration: configuration)
    }()
    
    
    
    func apiAlamofire(url: String, method: HTTPMethod,params: [String: AnyObject]? = nil, completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        print(params as Any)
        
        //        manager.request(url, method: method, parameters: params, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
        
        
        manager.request(url, method: method, parameters: params, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            
            if response.result.isSuccess {
                let responseString = String(data: response.data!, encoding: String.Encoding.utf8)
                let dict = convertToDictionary(text: responseString!)
                print(dict?.prettyPrintedJSON ?? "")
                
                completHandler(dict! as [String : AnyObject])
            } else {
                completHandler([:] as [String : AnyObject])
            }
        }
        
    }
    
    //***********************Home**************************************
    //------------------using get popular products-------------------
    func apiPopularProduct(url: String, completHandler: @escaping ([String: AnyObject]) -> ()) {
        self.apiAlamofire(url: url, method: .get, params: nil) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
        }
    }
    
    func apiMostSellingProduct(url: String, completHandler: @escaping ([String: AnyObject]) -> ()) {
        self.apiAlamofire(url: url, method: .get, params: nil) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
        }
    }
    
    func apiHeaderBestCategory(url: String, completHandler: @escaping ([String: AnyObject]) -> ()) {
        self.apiAlamofire(url: url, method: .get, params: nil) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
        }
    }
    
    func apiBannerSlider(url: String, completHandler: @escaping ([String: AnyObject]) -> ()) {
        self.apiAlamofire(url: url, method: .get, params: nil) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
        }
    }
    
    //--------------using for get all country-------------------
    func apiGetCountry(url: String, completHandler: @escaping ([String: AnyObject]) -> ()) {
        self.apiAlamofire(url: url, method: .get, params: nil) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
        }
    }
    
       
    
    //----------------using get all state------------------------
    func apiGetState( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.getStateList.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    
    
    
    //-------------using for login----------------
    func apiLogin( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.login.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //------------using for sign up---------------
    func apiSignUp( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.signUp.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    
    //------------using for forgot password------------
    func apiForgotPassword( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.forgotPassword.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //******************************Transaction**********************************
    func apiGetTransactionList( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.getTransactionList.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //******************************Download**********************************
    func apiGetDownloadProductList( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.getDownloadProductList.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    func apiDownloadAllProductList( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.downloadAllProduct.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    func apiDeleteAllProductList( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.deleteAllProduct.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    
    
    
    
    //***************************** MY ACCOUNT **********************************************
    
    //--------------Get all address-------------------
    func apiGetAllAddress( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.getAllAddress.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    
    //-----------------Edit Contact Information----------------------
    func apiEditContactInfo( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.editContactInfo.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //-----------------Edit Default Billing------------------------
    func apiEditDefaultBilling( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.editDefaultBilling.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //------------------Edit Default Shipping-------------------------
    func apiEditDefaultShipping( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.editDefaultShipping.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //----------------Edit Additional Billing---------------------------
    func apiEditAdditionalBiling( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.editAdditionalBilling.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //-----------------Add new Address-------------------------
    func apiAddNewAddress( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.addNewAddress.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //------------------Delete Address-----------------------
    func apiDeleteAddress( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.deleteAddress.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //------------------Change Password----------------------
    func apiChangePassword( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.changePassword.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //-------------------Add Bank Detail----------------------
    func apiAddBankDetail( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.addBankDetail.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //-------------------Edit Bank Detail-------------------------
    func apiEditBankDetail( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.editBankDetail.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //-----------------Delete Bank Detail-------------------------
    func apiDeleteBankDetail( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.deleteBankDetail.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //----------------List Bank Detail----------------------------
    func apiListBank( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.listBankDetail.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    //*******************************Referral*************************************
    func apiCreateReferral( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.createReferral.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    func apiReferralList( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.referralList.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    func apiDeleteReferral( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.deleteReferral.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    
    //-------------using for listing----------------
    func apiList( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.productList.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
    }
    
    
    func apiGetSortFilter(url: String, completHandler: @escaping ([String: AnyObject]) -> ()) {
        self.apiAlamofire(url: url, method: .get, params: nil) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
        }
    }
    
    
    func apiAddToDownload( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.addToDownloadProduct.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    func apiGetProductDetail( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.getProductDetail.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    func apiRtsProductClick( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.rtsProductClick.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    func apiAddToCart( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.addToCart.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    //**************************Order********************************
    func apiGetOrder( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.getOrder.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    
    func apiGetOrderDetail( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.getOrderDetail.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    
    
    func apiCancelOrder( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.cancelOrder.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    func apiPrintOrder( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.printOrder.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    //***********************************Policy***********************************
    func apiPolicy( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.policy.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    //*******************************Cart*****************************************
    func apiCartList( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.cartList.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    func apiUpdateCart( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.updateCartItem.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    func apiDeleteCart( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.deleteCartItem.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    func apiSelectPaymentMethod( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.paymentMethodList.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    func apiPaymentSave( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.paymentSave.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    func apiOrderSummary( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.orderSummary.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    func apiPlaceOrder( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.placeOrder.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
    
    //***************************MY STOCK********************************
    func apiMyStockList( params: [String: AnyObject],completHandler: @escaping ([String: AnyObject]) -> ()) {
        
        self.apiAlamofire(url: Endpoint.myStockList.url, method:.post, params: params) { (response) in
            
            let status = response["status"] as? String
            if status == "error" {
                completHandler(response)
            } else {
                completHandler(response)
            }
            
        }
        
    }
    
}
