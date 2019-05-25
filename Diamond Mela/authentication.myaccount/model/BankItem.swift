
import Foundation
import ObjectMapper

struct BankItem : Mappable {
    var status : String?
    var data : [Data]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        data <- map["data"]
    }
    
    struct Data : Mappable {
        var bank_id : String?
        var customer_id : String?
        var bank_name : String?
        var bank_account_number : String?
        var bank_account_holder : String?
        var ifsc_code : String?
        var branch_name : String?
        var created : String?
        var modified : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            bank_id <- map["bank_id"]
            customer_id <- map["customer_id"]
            bank_name <- map["bank_name"]
            bank_account_number <- map["bank_account_number"]
            bank_account_holder <- map["bank_account_holder"]
            ifsc_code <- map["ifsc_code"]
            branch_name <- map["branch_name"]
            created <- map["created"]
            modified <- map["modified"]
        }
        
    }
    
}
