import Foundation

let pagesize:Int=20
//user prefrences
let saveTheme = UserDefaults.standard
let userSessionData = UserDefaults.standard

//registerdUserId.set(userData[0].iD!, forKey: "userId")

let BASE_URL = "http://www.diamondmela.com/"
//let BASE_URL = "http://123.108.51.11/index.php/"

let IMAGE_URL="http://www.diamondmela.com/media/"

let app_name:String?="Diamondmela"

let loadingMsg:String="Please wait.."

let internetAlert:String="Internet Alert"

var customerId = ""
var groupId = ""


//Common message

let internetNotConnectMsg : String?="Make sure your device is connected to the internet."


let RING_ID : String="14"
let BRACELETS_ID : String="124"
let BANGLE_ID : String="9"
let EARRINGS_ID : String="6"
let PENDANTS_SETS_ID : String="287"
let PENDANTS_ID : String="7"
let NOSEPIN_ID : String="289"
let NECKLACE_ID : String="290"
let COLLECTION_ID : String="291"
let RUBBER_ID : String="295"


//-----------Common Message-----------------
let STATUS_CODE: String="status"
let FAILURE_CODE: String="failure"
let SUCCESS: String="Success"
let DELETE: String="DELETE"
let OK: String="Ok"
let CANCEL: String="Cancel"
let ARE_U_SURE_DEL="Are you sure u want delete this item."
let wrongLogin : String="Invalid email & password."
let errorTitle: String="Error"


//User defaults key's name
let USER_SESSION_DATA_KEY:String="user_data_key"
let BILLING_USERDEFAULTS:String="billing"
let SHIPPING_USERDEFAULTS:String="shipping"
let INDIA_CODE:String="IN"
let CART_USERDEFAULTS = "CART"
let THEME_USEDEFAULTS = "theme"

let BLACK_THEME_KEY = "black"
let WHITE_THEME_KEY = "white"


//validation message
let ENTER_FNM:String = "Please enter first name."
let ENTER_LNM:String = "Please enter last name."
let ENTER_EMAIL:String = "Please enter email id."
let ENTER_CITY:String = "Please enter city name."
let ENTER_STATE:String = "Please enter state name."
let ENTER_ADDRESS:String = "Please enter address."
let ENTER_TEL:String = "Please enter telephone number."
let ENTER_ZIP_CODE:String = "Please enter postal code."


var arrFilterData = [SortFilterItem.Data]()

let w :Float = 50
let h :Float = 45



let ID = "id";
let PRODUCT_ID = "product_id";
let CATEGORY_ID = "category_id";
let PRODUCT_TYPE = "category_type";
let SKU = "sku";
let RING_SIZE = "ring_size";
let RING_OPTION_ID = "option_id";
let RING_OPTION_TYPE_ID = "option_type_id";
let BANGLE_SIZE = "bangle_size";
let BRACELET_SIZE = "bracelet_size";
let PENDENT_SET_TYPE = "pendent_set_type";
let METAL_DETAIL = "metal_detail";
let STONE_DETAIL = "stone_detail";
let STONE_OPTION_ID = "stone_option_id";
let STONE_OPTION_TYPE_ID = "stone_option_type_id";
let PRICE = "price";
let QTY = "qty";
let PRODUCT_IMAGE = "pro_image";
