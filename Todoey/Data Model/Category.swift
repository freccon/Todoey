//
//  Category.swift
//  Todoey
//
//  Created by RAMON DAVO GONZALEZ on 12/11/18.
//  Copyright © 2018 com.Adan Nunez. All rights reserved.
//

import Foundation
import RealmSwift
class Category: Object {
    @objc dynamic var name:String=""
    let items = List<Item>()
}
