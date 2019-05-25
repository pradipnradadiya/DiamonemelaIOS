import Foundation
import ObjectMapper
struct CountryResponse : Mappable {
    var status : String?
    var data : [Data]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        data <- map["data"]
    }
    
    
    struct Data : Mappable {
        var country_id : String?
        var iso2_code : String?
        var iso3_code : String?
        var name : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            country_id <- map["country_id"]
            iso2_code <- map["iso2_code"]
            iso3_code <- map["iso3_code"]
            name <- map["name"]
        }
        
    }
}
