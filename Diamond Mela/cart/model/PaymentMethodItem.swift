import Foundation
import ObjectMapper

struct PaymentMethodItem : Mappable {
    var status : String?
    var price : Int?
    var shipping_charges : [Shipping_charges]?
    var data : [Data]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        price <- map["price"]
        shipping_charges <- map["shipping_charges"]
        data <- map["data"]
    }
    
    
    struct Shipping_charges : Mappable {
        var rate_id : String?
        var address_id : String?
        var carrier : String?
        var code : String?
        var method : String?
        var price : Int?
        var method_title : String?
        var isSelected : Bool? = false
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            rate_id <- map["rate_id"]
            address_id <- map["address_id"]
            carrier <- map["carrier"]
            code <- map["code"]
            method <- map["method"]
            price <- map["price"]
            method_title <- map["method_title"]
        }
        
    }
    
    
    struct Data : Mappable {
        var label : String?
        var value : String?
        var info : String?
        var image : String?
        var isSelected : Bool? = false
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            label <- map["label"]
            value <- map["value"]
            info <- map["info"]
            image <- map["image"]
        }
        
    }
    
}
