import Foundation
import ObjectMapper
struct PopularProductItem : Mappable {
    var status : String?
    var product_img : [Product_img]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        product_img <- map["product_img"]
    }
    
    
    struct Product_img : Mappable {
        var entity_id : String?
        var type_id : String?
        var attribute_set_id : String?
        var name : String?
        var url_path : String?
        var is_sold : String?
        var thumbnail : String?
        var original_sku : String?
        var sku : String?
        var status : String?
        var rts_stone_quality : String?
        var custom_price : String?
        var dml_only : String?
        var qty : String?
        var is_salable : String?
        var stock_item : Stock_item?
        var stock : String?
        var download_flag : Int?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            entity_id <- map["entity_id"]
            type_id <- map["type_id"]
            attribute_set_id <- map["attribute_set_id"]
            name <- map["name"]
            url_path <- map["url_path"]
            is_sold <- map["is_sold"]
            thumbnail <- map["thumbnail"]
            original_sku <- map["original_sku"]
            sku <- map["sku"]
            status <- map["status"]
            rts_stone_quality <- map["rts_stone_quality"]
            custom_price <- map["custom_price"]
            dml_only <- map["dml_only"]
            qty <- map["qty"]
            is_salable <- map["is_salable"]
            stock_item <- map["stock_item"]
            stock <- map["stock"]
            download_flag <- map["download_flag"]
        }
        
    }
    
    struct Stock_item : Mappable {
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
        }
        
    }
    
}
