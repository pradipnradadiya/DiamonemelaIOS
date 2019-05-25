import Foundation
import ObjectMapper

struct DownloadItem : Mappable {
    var status : String?
    var customer_id : String?
    var data : [Data]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        customer_id <- map["customer_id"]
        data <- map["data"]
    }
    
    struct Data : Mappable {
        var product_id : String?
        var sku : String?
        var stoneDetail : String?
        var metalDeatil : String?
        var carat : String?
        var diamondWeight : String?
        var price : Int?
        var image : String?
        var flag : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            product_id <- map["product_id"]
            sku <- map["Sku"]
            stoneDetail <- map["StoneDetail"]
            metalDeatil <- map["MetalDeatil"]
            carat <- map["Carat"]
            diamondWeight <- map["DiamondWeight"]
            price <- map["price"]
            image <- map["image"]
            flag <- map["flag"]
        }
        
    }
    
}
