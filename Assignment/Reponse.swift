//
//  Reponse.swift
//  Assignment
//
//  Created by Priyanka on 5/30/20.
//  Copyright © 2020 Priyanka. All rights reserved.
//

import Foundation
struct Response : Codable{
    let moviesArray: [Movie]?
    let date: [String:String]?
    
    private enum CodingKeys: String, CodingKey {
        case moviesArray = "results"
        case date = "dates"
    }
}
 
