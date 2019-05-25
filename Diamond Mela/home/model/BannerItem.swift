import Foundation
import ObjectMapper

struct BannerItem : Mappable {
    var status : String?
    var banner_image : String?
    var slider_image : [Slider_image]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        status <- map["status"]
        banner_image <- map["banner_image"]
        slider_image <- map["slider_image"]
    }
    
    
    struct Slider_image : Mappable {
        var title : String?
        var state : String?
        var date_from : String?
        var date_to : String?
        var slot_amount : String?
        var transition_rotation : String?
        var transition_duration : String?
        var delay : String?
        var save_performance : String?
        var enable_link : String?
        var slide_thumb : String?
        var class_attr : String?
        var id_attr : String?
        var data_attr : String?
        var background_type : String?
        var image_url : String?
        var bg_fit : String?
        var bg_repeat : String?
        var bg_position : String?
        var kenburn_effect : String?
        var slide_transition : String?
        var slide_order : String?
        var layers : [String]?
        var id : String?
        
        init?(map: Map) {
            
        }
        
        mutating func mapping(map: Map) {
            
            title <- map["title"]
            state <- map["state"]
            date_from <- map["date_from"]
            date_to <- map["date_to"]
            slot_amount <- map["slot_amount"]
            transition_rotation <- map["transition_rotation"]
            transition_duration <- map["transition_duration"]
            delay <- map["delay"]
            save_performance <- map["save_performance"]
            enable_link <- map["enable_link"]
            slide_thumb <- map["slide_thumb"]
            class_attr <- map["class_attr"]
            id_attr <- map["id_attr"]
            data_attr <- map["data_attr"]
            background_type <- map["background_type"]
            image_url <- map["image_url"]
            bg_fit <- map["bg_fit"]
            bg_repeat <- map["bg_repeat"]
            bg_position <- map["bg_position"]
            kenburn_effect <- map["kenburn_effect"]
            slide_transition <- map["slide_transition"]
            slide_order <- map["slide_order"]
            layers <- map["layers"]
            id <- map["id"]
        }
        
    }
    
}
