import Foundation
import ObjectMapper
import RappleProgressHUD

struct ReferralItem : Mappable {
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
        var entity_type_id : String?
        var attribute_set_id : String?
        var website_id : String?
        var email : String?
        var group_id : String?
        var increment_id : String?
        var store_id : String?
        var created_at : String?
        var updated_at : String?
        var is_active : String?
        var disable_auto_group_change : String?
        var franchise_referral_status : String?
        var parent_franchise_id : String?
        var firstname : String?
        var lastname : String?
        var password_hash : String?
        var referral_comission : String?
        var contact_number : String?
        var referral_type : String?
        var created_in : String?
        var rp_token : String?
        var franchisee_status : String?
        var _isfranchisee : String?
        var rp_token_created_at : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            entity_id <- map["entity_id"]
            entity_type_id <- map["entity_type_id"]
            attribute_set_id <- map["attribute_set_id"]
            website_id <- map["website_id"]
            email <- map["email"]
            group_id <- map["group_id"]
            increment_id <- map["increment_id"]
            store_id <- map["store_id"]
            created_at <- map["created_at"]
            updated_at <- map["updated_at"]
            is_active <- map["is_active"]
            disable_auto_group_change <- map["disable_auto_group_change"]
            franchise_referral_status <- map["franchise_referral_status"]
            parent_franchise_id <- map["parent_franchise_id"]
            firstname <- map["firstname"]
            lastname <- map["lastname"]
            password_hash <- map["password_hash"]
            referral_comission <- map["referral_comission"]
            contact_number <- map["contact_number"]
            referral_type <- map["referral_type"]
            created_in <- map["created_in"]
            rp_token <- map["rp_token"]
            franchisee_status <- map["franchisee_status"]
            _isfranchisee <- map["_isfranchisee"]
            rp_token_created_at <- map["rp_token_created_at"]
        }
        
    }
    
    
}
