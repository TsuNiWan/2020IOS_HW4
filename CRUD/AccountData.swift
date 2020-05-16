//
//  AccountData.swift
//  CRUD
//
//  Created by 林子平 on 2020/5/16.
//  Copyright © 2020 林子平. All rights reserved.
//

import Foundation
import Combine

class AccountData: ObservableObject {
    @Published var accounts = [Account]()
    var cancellable: AnyCancellable?
    
    
    init() {
        
        if let data = UserDefaults.standard.data(forKey: "accounts") {
            let decoder = JSONDecoder()
            if let decodedData = try? decoder.decode([Account].self, from: data) {
                accounts = decodedData
            }
        }
        
        
        cancellable = $accounts
            .sink { (value) in
                let encoder = JSONEncoder()
                do {
                    let data = try encoder.encode(value)
                    UserDefaults.standard.set(data, forKey: "accounts")
                } catch {
                    
                }
        }
        
    }
}
