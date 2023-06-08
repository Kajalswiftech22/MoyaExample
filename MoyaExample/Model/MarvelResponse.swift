//
//  MarvelResponse.swift
//  MoyaExample
//
//  Created by Kajol   on 06/06/23.
//

import Foundation

struct MarvelResponse<T: Codable>: Codable {
    let code: Int
    let status: String
    let data: [Movie]
}
