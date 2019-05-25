import Foundation
import ObjectMapper

struct ListItem : Mappable {
    var status : String?
    var data : [Data]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        data <- map["data"]
    }
    
    
    
    struct Data : Mappable {
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
        var dml_only : String?
        var qty : String?
        var custom_price : Int?
        var is_salable : String?
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
            dml_only <- map["dml_only"]
            qty <- map["qty"]
            custom_price <- map["custom_price"]
            is_salable <- map["is_salable"]
            stock <- map["stock"]
            download_flag <- map["download_flag"]
        }
        
    }
    
}
