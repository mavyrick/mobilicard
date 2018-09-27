import Foundation

struct ReleaseJobModel : Codable {
    let error : Bool?
    let message : String?
    let ret_code : Int?
    let mobile_number : String?
    let number : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case error = "error"
        case message = "message"
        case ret_code = "ret_code"
        case mobile_number = "mobile_number"
        case number = "number"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Bool.self, forKey: .error)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        ret_code = try values.decodeIfPresent(Int.self, forKey: .ret_code)
        mobile_number = try values.decodeIfPresent(String.self, forKey: .mobile_number)
        number = try values.decodeIfPresent(Int.self, forKey: .number)
    }
    
}
