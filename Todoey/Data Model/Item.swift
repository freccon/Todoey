//
//  Item.swift
//  Todoey
//
//  Created by RAMON DAVO GONZALEZ on 12/11/18.
//  Copyright © 2018 com.Adan Nunez. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object{
    @objc  dynamic var title:String=""
    @objc dynamic var done:Bool=false
    @objc dynamic var dateCreated:Date=Date()
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
