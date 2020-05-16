//
//  Account.swift
//  CRUD
//
//  Created by 林子平 on 2020/5/16.
//  Copyright © 2020 林子平. All rights reserved.
//

import Foundation

struct Account: Identifiable, Codable {
    let id = UUID()
    let date: String
    var type: String
    var amount: String
}
