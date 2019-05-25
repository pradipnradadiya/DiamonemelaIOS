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

var customerId = "1190"


//Common message

let internetNotConnectMsg : String?="Make sure your device is connected to the internet."


let RING_ID : String?="14"
let BRACELETS_ID : String?="124"
let BANGLE_ID : String?="9"
let EARRINGS_ID : String?="6"
let PENDANTS_SETS_ID : String?="287"
let PENDANTS_ID : String?="7"
let NOSEPIN_ID : String?="289"
let NECKLACE_ID : String?="290"
let COLLECTION_ID : String?="291"
let RUBBER_ID : String?="295"


//-----------Common Message-----------------

let STATUS_CODE: String="status"
let FAILURE_CODE: String="failure"
let SUCCESS: String="Success"
let wrongLogin : String="Invalid email & password."
let errorTitle: String="Error"


//User defaults key's name

let USER_SESSION_DATA_KEY:String="user_data_key"
let INDIA_CODE:String="IN"


//validation message

let ENTER_FNM:String = "Please enter first name."
let ENTER_LNM:String = "Please enter last name."
let ENTER_EMAIL:String = "Please enter email id."
let ENTER_CITY:String = "Please enter city name."
let ENTER_STATE:String = "Please enter state name."
let ENTER_ADDRESS:String = "Please enter address."
let ENTER_TEL:String = "Please enter telephone number."
let ENTER_ZIP_CODE:String = "Please enter postal code."
