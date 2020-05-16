//
//  AccountList.swift
//  CRUD
//
//  Created by 林子平 on 2020/5/16.
//  Copyright © 2020 林子平. All rights reserved.
//

import SwiftUI

struct AccountList: View {
    @ObservedObject var accountData = AccountData()
    @State private var showEditAccount = false
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(accountData.accounts) { (account) in
                    NavigationLink(destination: AccountEditor(accountData: self.accountData, editAccount: account)) {
                        AccountRow(account: account)
                    }
                }
                .onDelete { (indexSet) in
                    self.accountData.accounts.remove(atOffsets: indexSet)
                }
                .onMove { (indexSet, index) in
                    self.accountData.accounts.move(fromOffsets: indexSet, toOffset: index)
                }
            }
            .navigationBarTitle("花費總覽")
            .navigationBarItems(leading: EditButton(), trailing: Button(action: {
                self.showEditAccount = true
            }) {
                Image(systemName: "plus.circle.fill")
            })
                .sheet(isPresented: $showEditAccount) {
                    NavigationView {
                        AccountEditor(accountData: self.accountData)
                    }
            }
        }
    }
}

struct AccountList_Previews: PreviewProvider {
    static var previews: some View {
        AccountList()
    }
}
