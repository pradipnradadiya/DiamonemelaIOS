import Foundation
import ObjectMapper

struct OrderSummaryItem : Mappable {
    var status : String?
    var subtotal : Int?
    var grand_total : Int?
    var tax_ammount : Int?
    var payment : String?
    var shipping_charges : Int?
    var data : [Data]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        subtotal <- map["subtotal"]
        grand_total <- map["grand_total"]
        tax_ammount <- map["tax_ammount"]
        payment <- map["payment"]
        shipping_charges <- map["shipping_charges"]
        data <- map["data"]
    }
    
    
    struct Data : Mappable {
        var name : String?
        var sku : String?
        var metaldetails : String?
        var stonequality : String?
        var ringsize : String?
        var pendents : String?
        var bangles : String?
        var bracelets : String?
        var qty : Int?
        var price : Int?
        var subtotal : Int?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            name <- map["name"]
            sku <- map["sku"]
            metaldetails <- map["metaldetails"]
            stonequality <- map["stonequality"]
            ringsize <- map["ringsize"]
            pendents <- map["pendents"]
            bangles <- map["bangles"]
            bracelets <- map["bracelets"]
            qty <- map["qty"]
            price <- map["price"]
            subtotal <- map["subtotal"]
        }
        
    }
    
}
