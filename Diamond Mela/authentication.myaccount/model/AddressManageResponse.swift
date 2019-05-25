import Foundation
import ObjectMapper

struct AddressManageResponse : Mappable {
    var status : String?
    var default_billing : Default_billing?
    var default_shipping : Default_shipping?
    var data : [Data]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        default_billing <- map["default_billing"]
        default_shipping <- map["default_shipping"]
        data <- map["data"]
    }
    
    
    struct Default_shipping : Mappable {
        var entity_id : String?
        var entity_type_id : String?
        var attribute_set_id : String?
        var increment_id : String?
        var parent_id : String?
        var created_at : String?
        var updated_at : String?
        var is_active : String?
        var firstname : String?
        var lastname : String?
        var city : String?
        var country_id : String?
        var region : String?
        var postcode : String?
        var telephone : String?
        var region_id : String?
        var street : String?
        var country : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            entity_id <- map["entity_id"]
            entity_type_id <- map["entity_type_id"]
            attribute_set_id <- map["attribute_set_id"]
            increment_id <- map["increment_id"]
            parent_id <- map["parent_id"]
            created_at <- map["created_at"]
            updated_at <- map["updated_at"]
            is_active <- map["is_active"]
            firstname <- map["firstname"]
            lastname <- map["lastname"]
            city <- map["city"]
            country_id <- map["country_id"]
            region <- map["region"]
            postcode <- map["postcode"]
            telephone <- map["telephone"]
            region_id <- map["region_id"]
            street <- map["street"]
            country <- map["country"]
        }
        
    }
    
    
    
    struct Default_billing : Mappable {
        var entity_id : String?
        var entity_type_id : String?
        var attribute_set_id : String?
        var increment_id : String?
        var parent_id : String?
        var created_at : String?
        var updated_at : String?
        var is_active : String?
        var firstname : String?
        var lastname : String?
        var city : String?
        var country_id : String?
        var region : String?
        var postcode : String?
        var telephone : String?
        var region_id : String?
        var street : String?
        var country : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            entity_id <- map["entity_id"]
            entity_type_id <- map["entity_type_id"]
            attribute_set_id <- map["attribute_set_id"]
            increment_id <- map["increment_id"]
            parent_id <- map["parent_id"]
            created_at <- map["created_at"]
            updated_at <- map["updated_at"]
            is_active <- map["is_active"]
            firstname <- map["firstname"]
            lastname <- map["lastname"]
            city <- map["city"]
            country_id <- map["country_id"]
            region <- map["region"]
            postcode <- map["postcode"]
            telephone <- map["telephone"]
            region_id <- map["region_id"]
            street <- map["street"]
            country <- map["country"]
        }
        
    }
    
    
    struct Data : Mappable {
        var country : String?
        var entity_id : String?
        var entity_type_id : String?
        var attribute_set_id : String?
        var increment_id : String?
        var parent_id : String?
        var created_at : String?
        var updated_at : String?
        var is_active : String?
        var firstname : String?
        var lastname : String?
        var postcode : String?
        var city : String?
        var region : String?
        var country_id : String?
        var telephone : String?
        var region_id : String?
        var street : String?
        var customer_id : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            country <- map["country"]
            entity_id <- map["entity_id"]
            entity_type_id <- map["entity_type_id"]
            attribute_set_id <- map["attribute_set_id"]
            increment_id <- map["increment_id"]
            parent_id <- map["parent_id"]
            created_at <- map["created_at"]
            updated_at <- map["updated_at"]
            is_active <- map["is_active"]
            firstname <- map["firstname"]
            lastname <- map["lastname"]
            postcode <- map["postcode"]
            city <- map["city"]
            region <- map["region"]
            country_id <- map["country_id"]
            telephone <- map["telephone"]
            region_id <- map["region_id"]
            street <- map["street"]
            customer_id <- map["customer_id"]
        }
        
    }
    
}


