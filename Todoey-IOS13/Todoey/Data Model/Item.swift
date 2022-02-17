//
//  Item.swift
//  Todoey
//
//  Created by Andrei Marinescu on 17.04.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Item:Object {
    @objc dynamic var title = ""
    @objc dynamic var done = false
    @objc dynamic var dateCreated:Date?
    var parentCategory = LinkingObjects<Category>(fromType: Category.self, property: "items")
}
