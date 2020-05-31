//
//  API.swift
//  Assignment
//
//  Created by Priyanka on 5/31/20.
//  Copyright © 2020 Priyanka. All rights reserved.
//
import Foundation
struct APIConstants {
    static let kBaseUrl = "https://api.themoviedb.org/3/movie"
    static let ApiKey = "?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
    static let posterUrl = "https://image.tmdb.org/t/p/w342/"
    static let backgrondUrl = "https://image.tmdb.org/t/p/original/"
    private struct endPoint {
           static let kMovies = "/now_playing"
         static let kTopRated = "/top_rated"
    }
    
    static var moviesUrl: String {
        return kBaseUrl + endPoint.kMovies + ApiKey
    }
    static var topratedUrl: String {
         return kBaseUrl + endPoint.kTopRated + ApiKey
     }
}
