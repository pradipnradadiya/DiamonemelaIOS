import Foundation
import ObjectMapper


struct MyStockItem: Mappable {
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
        var image : String?
        var sku : String?
        var price : Float?
        var metal_quality : String?
        var stone_quality : String?
        var size : String?
       
        
        init?(map: Map) {
            
        }
        mutating func mapping(map: Map) {
            
            product_id <- map["product_id"]
            image <- map["image"]
            sku <- map["sku"]
            price <- map["price"]
            metal_quality <- map["metal_quality"]
            stone_quality <- map["stone_quality"]
            size <- map["size"]
          
        }
        
    }
    
}
