import Foundation
import ObjectMapper
struct HeaderItem : Mappable {
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
        var level : String?
        var path : String?
        var position : String?
        var is_active : String?
        var is_anchor : String?
        var name : String?
        var icon_img : String?
        var category_img : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            entity_id <- map["entity_id"]
            level <- map["level"]
            path <- map["path"]
            position <- map["position"]
            is_active <- map["is_active"]
            is_anchor <- map["is_anchor"]
            name <- map["name"]
            icon_img <- map["icon_img"]
            category_img <- map["category_img"]
        }
        
    }
    
}
