import Foundation
import ObjectMapper


struct OrderDetailItem : Mappable {
    var status : String?
    var data : [Data]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        data <- map["data"]
    }
    
    struct Data : Mappable {
        var order_date : String?
        var order_subtotal : String?
        var order_shippingamount : String?
        var oder_taxamount : String?
        var order_grandtotal : String?
        var order_item : [Order_item]?
        var shiiping_address : String?
        var billing_address : String?
        var shipping_description : String?
        var payment_method : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            order_date <- map["order_date"]
            order_subtotal <- map["order_subtotal"]
            order_shippingamount <- map["order_shippingamount"]
            oder_taxamount <- map["oder_taxamount"]
            order_grandtotal <- map["order_grandtotal"]
            order_item <- map["order_item"]
            shiiping_address <- map["shiiping_address"]
            billing_address <- map["billing_address"]
            shipping_description <- map["shipping_description"]
            payment_method <- map["payment_method"]
        }
        
    }
    
    struct Order_item : Mappable {
        var product_img : String?
        var product_name : String?
        var product_sku : String?
        var product_stoneweight : String?
        var product_size : String?
        var product_metalweight : String?
        var product_type : String?
        var product_price : String?
        var product_rawtotal : String?
        var product_qty : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            product_img <- map["product_img"]
            product_name <- map["product_name"]
            product_sku <- map["product_sku"]
            product_stoneweight <- map["product_stoneweight"]
            product_size <- map["product_size"]
            product_metalweight <- map["product_metalweight"]
            product_type <- map["product_type"]
            product_price <- map["product_price"]
            product_rawtotal <- map["product_rawtotal"]
            product_qty <- map["product_qty"]
        }
        
    }
    
}
