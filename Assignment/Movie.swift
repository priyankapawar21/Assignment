//
//  modal.swift
//  Assignment
//
//  Created by Priyanka on 5/30/20.
//  Copyright © 2020 Priyanka. All rights reserved.
//

import Foundation
struct Movie : Codable{
    let movieName:String?
    let description: String?
    let posterUrl: String?
    let backgrountImgUrl: String?
    
    
    private enum CodingKeys: String, CodingKey {
        case movieName = "title"
        case description = "overview"
        case posterUrl = "poster_path"
        case backgrountImgUrl = "backdrop_path"
    }
}
