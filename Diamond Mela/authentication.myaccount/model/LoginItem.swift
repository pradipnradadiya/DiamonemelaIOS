
import Foundation
import ObjectMapper

class LoginItem: Mappable {
    var status : String?
    var customer_role : String?
    var data : Data?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        
        status <- map["status"]
        customer_role <- map["customer_role"]
        data <- map["data"]
    }
    
    
    
    struct Data : Mappable {
        var entity_id : String?
        var entity_type_id : String?
        var attribute_set_id : String?
        var increment_id : String?
        var parent_id : Int?
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
        var website_id : String?
        var email : String?
        var group_id : String?
        var store_id : String?
        var disable_auto_group_change : String?
        var created_in : String?
        var password_hash : String?
        var refcode : String?
        var default_billing : String?
        var default_shipping : String?
        var entity_customer : String?
        var _isfranchisee : String?
        var entity : String?
        var franchisee_status : String?
        var franchise_referral_status : String?
        var community : String?
        var customer_theme : String?
        var download_products : String?
        var deleted_products : String?
        var device_id : String?
        var notification_token : String?
        var default_billing_new : Default_billing_new?
        var default_shipping_new : Default_shipping_new?
        var country : String?
        var confirmation : String?
        
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
            website_id <- map["website_id"]
            email <- map["email"]
            group_id <- map["group_id"]
            store_id <- map["store_id"]
            disable_auto_group_change <- map["disable_auto_group_change"]
            created_in <- map["created_in"]
            password_hash <- map["password_hash"]
            refcode <- map["refcode"]
            default_billing <- map["default_billing"]
            default_shipping <- map["default_shipping"]
            entity_customer <- map["entity_customer"]
            _isfranchisee <- map["_isfranchisee"]
            entity <- map["entity"]
            franchisee_status <- map["franchisee_status"]
            franchise_referral_status <- map["franchise_referral_status"]
            community <- map["community"]
            customer_theme <- map["customer_theme"]
            download_products <- map["download_products"]
            deleted_products <- map["deleted_products"]
            device_id <- map["device_id"]
            notification_token <- map["notification_token"]
            default_billing_new <- map["default_billing_new"]
            default_shipping_new <- map["default_shipping_new"]
            country <- map["country"]
            confirmation <- map["confirmation"]
        }
        
    }
    
    struct Default_shipping_new : Mappable {
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
        }
        
    }
    
    
    
    struct Default_billing_new : Mappable {
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
        }
        
    }
    
    
    
}
