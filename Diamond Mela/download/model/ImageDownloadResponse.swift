import Foundation
import ObjectMapper

struct ImageDownloadResponse : Mappable {
    var image : [String]?
    var customer_id : String?
    var status : String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        image <- map["image"]
        customer_id <- map["customer_id"]
        status <- map["status"]
    }
    
}
