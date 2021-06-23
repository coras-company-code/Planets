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
struct PlanetModel: Decodable {
    let name: String
    let climate: String
    let gravity: String
    let population: String
}
