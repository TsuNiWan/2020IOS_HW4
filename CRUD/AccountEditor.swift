//
//  AccountEditor.swift
//  CRUD
//
//  Created by 林子平 on 2020/5/16.
//  Copyright © 2020 林子平. All rights reserved.
//

import SwiftUI

struct AccountEditor: View {
    @Environment(\.presentationMode) var presentationMode
    var accountData: AccountData
    @State private var date = Date()
    @State private var type = "餐飲食品"
    @State private var amount = ""
    var editAccount: Account?
    
    let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter
    }()
    
    let types = ["餐飲食品", "3C通訊", "休閒娛樂", "運輸交通", "居家生活"]
    
    var body: some View {
        VStack {
            Form {
                HStack {
                    Spacer()
                    Image(self.type)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)
                    Spacer()
                }
                
                DatePicker("日期", selection: $date, in: ...Date(), displayedComponents: .date)
                VStack(alignment: .leading) {
                    Text("類別")
                    Picker("類別", selection: $type) {
                        ForEach(types, id: \.self) { (type) in
                            Text(type)
                        }
                    }
                    .padding()
                    .labelsHidden()
                    .pickerStyle(WheelPickerStyle())
                }
                HStack {
                    Text("花費")
                    Spacer()
                    TextField("金額", text: $amount).keyboardType(.numberPad).multilineTextAlignment(.trailing)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
            }
        }
        .navigationBarTitle("新增一筆花費", displayMode: .inline)
        .navigationBarItems(trailing: Button("儲存") {
            let account = Account(date: self.dateFormatter.string(from: self.date), type: self.type, amount: self.amount)
            
            if let editAccount = self.editAccount {
                let index = self.accountData.accounts.firstIndex {
                    $0.id == editAccount.id
                    }!
                self.accountData.accounts[index] = account
            } else {
                self.accountData.accounts.insert(account, at: 0)
            }
            
            
            self.presentationMode.wrappedValue.dismiss()
        })
            .onAppear {
                if let editAccount = self.editAccount {
                    self.date = self.dateFormatter.date(from:editAccount.date)!
                    self.type = editAccount.type
                    self.amount = editAccount.amount
                }
        }
        
    }
}

struct AccountEditor_Previews: PreviewProvider {
    static var previews: some View {
        AccountEditor(accountData: AccountData())
    }
}
