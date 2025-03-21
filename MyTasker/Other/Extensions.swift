//
//  Extensions.swift
//  MyTasker
//
//  Created by Anushya Jeshtadi on 25/01/2025.
//

import Foundation
extension Encodable{
    func asDictionary() -> [String:Any]{
        guard let date = try? JSONEncoder().encode(self) else{
            return[:]
        }
        do{
            let json = try JSONSerialization.jsonObject(with: date) as? [String: Any]
            return json ?? [:]
        } catch{
            return[:]
        }
        
    }
}
