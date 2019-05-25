import Foundation
import ObjectMapper

struct SortFilterItem : Mappable {
    var status : String?
    var data : [Data]?
    var sort_by : [Sort_by]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        data <- map["data"]
        sort_by <- map["sort_by"]
    }
    
    
    struct Data : Mappable {
        var option_name : String?
        var option_data : [Option_data]?
        var option_type : String?
        var label : String?
        var icon : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            option_name <- map["option_name"]
            option_data <- map["option_data"]
            option_type <- map["option_type"]
            label <- map["label"]
            icon <- map["icon"]
        }
        
    }
    
    struct Sort_by : Mappable {
        var label : String?
        var value : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            label <- map["label"]
            value <- map["value"]
        }
        
    }
    
    
    struct Option_data : Mappable {
        var label : String?
        var value : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            label <- map["label"]
            value <- map["value"]
        }
        
    }
    
    
    
}
