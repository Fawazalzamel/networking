//
//  Pet.swift
//  NetworkingAndAPI
//
//  Created by Fawaz Alzamel on 04/03/2024.
//

import Foundation

struct Pet : Codable{
    
    let id : Int?
    let name : String
    let adopted : Bool
    let image : String
    let age : Int
    let gender : String
    
}
