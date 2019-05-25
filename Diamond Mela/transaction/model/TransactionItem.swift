import Foundation
import ObjectMapper

struct TransactionItem : Mappable {
    var status : String?
    var total_deposite : Int?
    var total_credit : Int?
    var total_debit : Int?
    var final_totalamount : Int?
    var total_tds : Int?
    var customer_id : String?
    var data : [Data]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        total_deposite <- map["total_deposite"]
        total_credit <- map["total_credit"]
        total_debit <- map["total_debit"]
        final_totalamount <- map["final_totalamount"]
        total_tds <- map["total_tds"]
        customer_id <- map["customer_id"]
        data <- map["data"]
    }
    
    struct Data : Mappable {
        var increment_id : String?
        var create_date : String?
        var description : String?
        var transction_price : Int?
        var order_item : [Order_item]?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            increment_id <- map["increment_id"]
            create_date <- map["create_date"]
            description <- map["description"]
            transction_price <- map["transction_price"]
            order_item <- map["order_item"]
        }
        
    }
    
    struct Order_item : Mappable {
        var product_increment_id : String?
        var product_name : String?
        var product_sku : String?
        var product_stonequality : String?
        var product_stoneweight : String?
        var product_price : String?
        var product_metalweight : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            product_increment_id <- map["product_increment_id"]
            product_name <- map["product_name"]
            product_sku <- map["product_sku"]
            product_stonequality <- map["product_stonequality"]
            product_stoneweight <- map["product_stoneweight"]
            product_price <- map["product_price"]
            product_metalweight <- map["product_metalweight"]
        }
        
    }
    
}
