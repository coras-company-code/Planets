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
    let residents: [String]
    
}

struct ResidentModel: Codable {
    let name: String
    let height: String
    let gender: String
    
}

