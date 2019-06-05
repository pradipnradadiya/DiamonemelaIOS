import Foundation
import ObjectMapper

struct RTSItem : Mappable {
    var status : String?
    var products : String?
    var stock : String?
    var belt_price : String?
    var metalprice : [Int]?
    var diamondmainprice : [Diamondmainprice]?
    var product_details : [Product_details]?
    var diamonddetails : [Diamonddetails]?
    var metaldetails : [Metaldetails]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        
        status <- map["status"]
        products <- map["products"]
        stock <- map["stock"]
        belt_price <- map["belt_price"]
        metalprice <- map["metalprice"]
        diamondmainprice <- map["diamondmainprice"]
        product_details <- map["product_details"]
        diamonddetails <- map["diamonddetails"]
        metaldetails <- map["metaldetails"]
    }
    
    struct Diamonddetails : Mappable {
        var shape : String?
        var setting : String?
        var quality : String?
        var pieces : String?
        var totalweight : String?
        var caratrate : String?
        var estimatedprice : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            shape <- map["shape"]
            setting <- map["setting"]
            quality <- map["quality"]
            pieces <- map["pieces"]
            totalweight <- map["totalweight"]
            caratrate <- map["caratrate"]
            estimatedprice <- map["estimatedprice"]
        }
        
    }
    
    struct Diamondmainprice : Mappable {
        var pices : String?
        var dimondprice : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            pices <- map["pices"]
            dimondprice <- map["dimondprice"]
        }
        
    }
    
    struct Metaldetails : Mappable {
        var metalquality : String?
        var metalweight : String?
        var metalestimatedprice : Int?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            metalquality <- map["metalquality"]
            metalweight <- map["metalweight"]
            metalestimatedprice <- map["metalestimatedprice"]
        }
        
    }
    
    struct Product_details : Mappable {
        var product_name : String?
        var price : String?
        var sku : String?
        var certificate_no : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            product_name <- map["product_name"]
            price <- map["price"]
            sku <- map["sku"]
            certificate_no <- map["certificate_no"]
        }
        
    }
    
}
