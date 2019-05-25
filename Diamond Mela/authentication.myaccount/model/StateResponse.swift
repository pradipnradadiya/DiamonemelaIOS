import Foundation
import ObjectMapper

struct StateResponse : Mappable {
    var status : String?
    var data : [Data]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        data <- map["data"]
    }
    
    struct Data : Mappable {
        var region_id : String?
        var code : String?
        var name : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            region_id <- map["region_id"]
            code <- map["code"]
            name <- map["name"]
        }
        
    }
    
}
