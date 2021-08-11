//
//  PlanetModel.swift
//  Planets
//
//  Created by M_931521 on 23/06/2021.
//

import Foundation

struct Results: Decodable {
    var results : [PlanetModel]
    
}
struct PlanetModel: Codable {
    let name: String
    let climate: String
    let gravity: String
    let population: String
    let residentURLs: [String]
    var residentDetails: [ResidentModel]?
    
    enum CodingKeys: String, CodingKey {
        case name
        case climate
        case gravity
        case population
        case residentURLs = "residents"
        case residentDetails
       }
}



struct ResidentModel: Codable {
    let name: String
    let height: String
    let gender: String
    
}

