import Foundation
import ObjectMapper

struct CartProductListItem : Mappable {
    var status : String?
    var data : [Data]?
    var grandtotal : Int?
    var subtotal : Int?
    var tax : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        data <- map["data"]
        grandtotal <- map["grandtotal"]
        subtotal <- map["subtotal"]
        tax <- map["tax"]
    }
    
    struct Data : Mappable {
        var product_type : String?
        var sku : String?
        var name : String?
        var ringsize : String?
        var pendents : String?
        var bangles : String?
        var bracelets : String?
        var metaldetails : String?
        var stonedetails : String?
        var price : String?
        var itemid : String?
        var qty : Int?
        var image : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            product_type <- map["product_type"]
            sku <- map["sku"]
            name <- map["name"]
            ringsize <- map["ringsize"]
            pendents <- map["pendents"]
            bangles <- map["bangles"]
            bracelets <- map["bracelets"]
            metaldetails <- map["metaldetails"]
            stonedetails <- map["stonedetails"]
            price <- map["price"]
            itemid <- map["itemid"]
            qty <- map["qty"]
            image <- map["image"]
        }
        
    }
    
}
