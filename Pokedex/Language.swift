//
//  Language.swift
//  Pokedex
//
//  Created by Thomas Benali on 02/03/2017.
//  Copyright © 2017 Thomas Benali. All rights reserved.
//

import Foundation

class Language {
    
    private var _id: Int!
    private var _name: String!
    
    var id : Int! {
        return _id
    }
    
    var name : String! {
        return _name
    }
    
    init(id: Int, name: String) {
        self._id = id
        self._name = name
    }
}
