import Foundation
import ObjectMapper

struct ProductDetailItem : Mappable {
    var status : String?
    var products : String?
    var simpleproductid : String?
    var category_id : String?
    var stock : String?
    var slider : [String]?
    var rts_slider : [Rts_slider]?
    var ringsize : [Ringsize]?
    var bangle_size : [String]?
    var bracelets_size : [String]?
    var pendent_earring : [String]?
    var stone_clarity : [Stone_clarity]?
    var carat : [String]?
    var metal : [String]?
    var belt_price : String?
    var gemstonedetails : [String]?
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
        simpleproductid <- map["simpleproductid"]
        category_id <- map["category_id"]
        stock <- map["stock"]
        slider <- map["slider"]
        rts_slider <- map["rts_slider"]
        ringsize <- map["ringsize"]
        bangle_size <- map["bangle_size"]
        bracelets_size <- map["bracelets_size"]
        pendent_earring <- map["pendent_earring"]
        stone_clarity <- map["stone_clarity"]
        carat <- map["carat"]
        metal <- map["metal"]
        belt_price <- map["belt_price"]
        gemstonedetails <- map["gemstonedetails"]
        metalprice <- map["metalprice"]
        diamondmainprice <- map["diamondmainprice"]
        product_details <- map["product_details"]
        diamonddetails <- map["diamonddetails"]
        metaldetails <- map["metaldetails"]
    }
    
    struct Rts_slider : Mappable {
        var entity_id : String?
        var type_id : String?
        var attribute_set_id : String?
        var metal_quality : String?
        var metal_quality_value : String?
        var rts_stone_quality : String?
        var rts_ring_size : String?
        var custom_price : String?
        var rts_bangle_size : String?
        var rts_bracelet_size : String?
        var original_sku : String?
        var is_sold : String?
        var isreadytoship : String?
        var is_salable : String?
        var diamond_weight : Double?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            entity_id <- map["entity_id"]
            type_id <- map["type_id"]
            attribute_set_id <- map["attribute_set_id"]
            metal_quality <- map["metal_quality"]
            metal_quality_value <- map["metal_quality_value"]
            rts_stone_quality <- map["rts_stone_quality"]
            rts_ring_size <- map["rts_ring_size"]
            custom_price <- map["custom_price"]
            rts_bangle_size <- map["rts_bangle_size"]
            rts_bracelet_size <- map["rts_bracelet_size"]
            original_sku <- map["original_sku"]
            is_sold <- map["is_sold"]
            isreadytoship <- map["isreadytoship"]
            is_salable <- map["is_salable"]
           
            diamond_weight <- map["diamond_weight"]
        }
        
    }
    
    struct Ringsize : Mappable {
        var title : String?
        var option_type_id : String?
        var option_id : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            title <- map["title"]
            option_type_id <- map["option_type_id"]
            option_id <- map["option_id"]
        }
        
    }
    
    struct Stone_clarity : Mappable {
        var title : String?
        var option_type_id : String?
        var option_id : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            title <- map["title"]
            option_type_id <- map["option_type_id"]
            option_id <- map["option_id"]
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
    
}
