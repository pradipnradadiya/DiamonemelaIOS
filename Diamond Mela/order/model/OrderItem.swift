import Foundation
import ObjectMapper
struct OrderItem : Mappable {
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
        var orderno : String?
        var grand_total : String?
        var order_items : [Order_items]?
        var order_status : String?
        var orderid : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            orderno <- map["orderno"]
            grand_total <- map["grand_total"]
            order_items <- map["order_items"]
            order_status <- map["order_status"]
            orderid <- map["orderid"]
        }
        
    }
    
    struct Order_items : Mappable {
        var image : String?
        var product_sku : String?
        var product_name : String?
        var product_stonequality : String?
        var product_stoneweight : String?
        var product_metalweight : String?
        var product_metalquality : String?
        var bangleSize : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            image <- map["image"]
            product_sku <- map["product_sku"]
            product_name <- map["product_name"]
            product_stonequality <- map["product_stonequality"]
            product_stoneweight <- map["product_stoneweight"]
            product_metalweight <- map["product_metalweight"]
            product_metalquality <- map["product_metalquality"]
            bangleSize <- map["bangleSize"]
        }
        
    }
    
}
