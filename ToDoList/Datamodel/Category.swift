//
//  Category.swift
//  ToDoList
//
//  Created by einfochips on 24/05/18.
//  Copyright © 2018 einfochips. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name : String = ""
    let items = List<Item>()
}
