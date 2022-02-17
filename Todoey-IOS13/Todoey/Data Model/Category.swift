//
//  Category.swift
//  Todoey
//
//  Created by Andrei Marinescu on 17.04.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name = ""
    @objc dynamic var color = ""
    var items = List<Item>()
    
}
