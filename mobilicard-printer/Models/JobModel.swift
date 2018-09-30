import Foundation

struct JobModel : Codable {
    let error : Bool?
    let ret_code : Int?
    let device_token : String?
    let user_token : String?
    let mobile_number : String?
    let num_of_jobs : Int?
    let total_cost : Int?
    let jobs : [Jobs]?
    
    enum CodingKeys: String, CodingKey {
        
        case error = "error"
        case ret_code = "ret_code"
        case device_token = "device_token"
        case user_token = "user_token"
        case mobile_number = "mobile_number"
        case num_of_jobs = "num_of_jobs"
        case total_cost = "total_cost"
        case jobs = "jobs"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        error = try values.decodeIfPresent(Bool.self, forKey: .error)
        ret_code = try values.decodeIfPresent(Int.self, forKey: .ret_code)
        device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
        user_token = try values.decodeIfPresent(String.self, forKey: .user_token)
        mobile_number = try values.decodeIfPresent(String.self, forKey: .mobile_number)
        num_of_jobs = try values.decodeIfPresent(Int.self, forKey: .num_of_jobs)
        total_cost = try values.decodeIfPresent(Int.self, forKey: .total_cost)
        jobs = try values.decodeIfPresent([Jobs].self, forKey: .jobs)
    }
    
}

import Foundation
struct Jobs : Codable {
    let jobid : String?
    let title : String?
    let price : String?
    let userid : String?
    let time : String?
    let pages_nb : String?
    let pages_col : String?
    let nb_copy : String?
    let charge_u : String?
    let duplex : String?
    let env_impact_water : String?
    let env_impact_diox : String?
    let env_impact_energy : String?
    let format : String?
    
    enum CodingKeys: String, CodingKey {
        
        case jobid = "jobid"
        case title = "title"
        case price = "price"
        case userid = "userid"
        case time = "time"
        case pages_nb = "pages_nb"
        case pages_col = "pages_col"
        case nb_copy = "nb_copy"
        case charge_u = "charge_u"
        case duplex = "duplex"
        case env_impact_water = "env_impact_water"
        case env_impact_diox = "env_impact_diox"
        case env_impact_energy = "env_impact_energy"
        case format = "format"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        jobid = try values.decodeIfPresent(String.self, forKey: .jobid)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        price = try values.decodeIfPresent(String.self, forKey: .price)
        userid = try values.decodeIfPresent(String.self, forKey: .userid)
        time = try values.decodeIfPresent(String.self, forKey: .time)
        pages_nb = try values.decodeIfPresent(String.self, forKey: .pages_nb)
        pages_col = try values.decodeIfPresent(String.self, forKey: .pages_col)
        nb_copy = try values.decodeIfPresent(String.self, forKey: .nb_copy)
        charge_u = try values.decodeIfPresent(String.self, forKey: .charge_u)
        duplex = try values.decodeIfPresent(String.self, forKey: .duplex)
        env_impact_water = try values.decodeIfPresent(String.self, forKey: .env_impact_water)
        env_impact_diox = try values.decodeIfPresent(String.self, forKey: .env_impact_diox)
        env_impact_energy = try values.decodeIfPresent(String.self, forKey: .env_impact_energy)
        format = try values.decodeIfPresent(String.self, forKey: .format)
    }
    
}

//import Foundation
//
//struct JobModel : Codable {
//    let error : Bool?
//    let ret_code : Int?
//    let mobile_number : String?
//    let total_cost : String?
//    let jobs : [Jobs]?
//
//    enum CodingKeys: String, CodingKey {
//
//        case error = "error"
//        case ret_code = "ret_code"
//        case mobile_number = "mobile_number"
//        case total_cost = "total_cost"
//        case jobs = "jobs"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        error = try values.decodeIfPresent(Bool.self, forKey: .error)
//        ret_code = try values.decodeIfPresent(Int.self, forKey: .ret_code)
//        mobile_number = try values.decodeIfPresent(String.self, forKey: .mobile_number)
//        total_cost = try values.decodeIfPresent(String.self, forKey: .total_cost)
//        jobs = try values.decodeIfPresent([Jobs].self, forKey: .jobs)
//    }
//
//}
//
//struct Jobs : Codable {
//    let jobid : String?
//    let title : String?
//    let price : String?
//    let userid : String?
//    let time : String?
//    let pages_nb : String?
//    let pages_col : String?
//    let nb_copy : String?
//    let charge_u : String?
//    let duplex : String?
//    let env_impact_water : String?
//    let env_impact_diox : String?
//    let env_impact_energy : String?
//    let format : String?
//
//    enum CodingKeys: String, CodingKey {
//
//        case jobid = "jobid"
//        case title = "title"
//        case price = "price"
//        case userid = "userid"
//        case time = "time"
//        case pages_nb = "pages_nb"
//        case pages_col = "pages_col"
//        case nb_copy = "nb_copy"
//        case charge_u = "charge_u"
//        case duplex = "duplex"
//        case env_impact_water = "env_impact_water"
//        case env_impact_diox = "env_impact_diox"
//        case env_impact_energy = "env_impact_energy"
//        case format = "format"
//    }
//
//    init(from decoder: Decoder) throws {
//        let values = try decoder.container(keyedBy: CodingKeys.self)
//        jobid = try values.decodeIfPresent(String.self, forKey: .jobid)
//        title = try values.decodeIfPresent(String.self, forKey: .title)
//        price = try values.decodeIfPresent(String.self, forKey: .price)
//        userid = try values.decodeIfPresent(String.self, forKey: .userid)
//        time = try values.decodeIfPresent(String.self, forKey: .time)
//        pages_nb = try values.decodeIfPresent(String.self, forKey: .pages_nb)
//        pages_col = try values.decodeIfPresent(String.self, forKey: .pages_col)
//        nb_copy = try values.decodeIfPresent(String.self, forKey: .nb_copy)
//        charge_u = try values.decodeIfPresent(String.self, forKey: .charge_u)
//        duplex = try values.decodeIfPresent(String.self, forKey: .duplex)
//        env_impact_water = try values.decodeIfPresent(String.self, forKey: .env_impact_water)
//        env_impact_diox = try values.decodeIfPresent(String.self, forKey: .env_impact_diox)
//        env_impact_energy = try values.decodeIfPresent(String.self, forKey: .env_impact_energy)
//        format = try values.decodeIfPresent(String.self, forKey: .format)
//    }
//
//}
//
