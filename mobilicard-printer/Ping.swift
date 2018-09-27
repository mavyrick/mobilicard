import Foundation

struct Ping : Codable {
    let ret_code : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case ret_code = "ret_code"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        ret_code = try values.decodeIfPresent(Int.self, forKey: .ret_code)
    }
    
}
