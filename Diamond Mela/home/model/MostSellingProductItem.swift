import Foundation
import ObjectMapper
struct MostSellingProductItem : Mappable {
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
        var custom_price : String?
        var name : String?
        var small_image : String?
        var thumbnail : String?
        var sku : String?
        var dml_only : String?
        var indexed_price : String?
        var price : String?
        var final_price : String?
        var minimal_price : String?
        var min_price : String?
        var max_price : String?
        var tier_price : String?
        var sold_quantity : String?
        var cat_index_position : String?
        var status : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            entity_id <- map["entity_id"]
            type_id <- map["type_id"]
            attribute_set_id <- map["attribute_set_id"]
            custom_price <- map["custom_price"]
            name <- map["name"]
            small_image <- map["small_image"]
            thumbnail <- map["thumbnail"]
            sku <- map["sku"]
            dml_only <- map["dml_only"]
            indexed_price <- map["indexed_price"]
            price <- map["price"]
            final_price <- map["final_price"]
            minimal_price <- map["minimal_price"]
            min_price <- map["min_price"]
            max_price <- map["max_price"]
            tier_price <- map["tier_price"]
            sold_quantity <- map["sold_quantity"]
            cat_index_position <- map["cat_index_position"]
            status <- map["status"]
        }
        
    }
    
}
