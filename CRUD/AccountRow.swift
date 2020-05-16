//
//  AccountRow.swift
//  CRUD
//
//  Created by 林子平 on 2020/5/16.
//  Copyright © 2020 林子平. All rights reserved.
//

import SwiftUI

struct AccountRow: View {
    var account: Account

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(account.type).fontWeight(.heavy).padding(10)
                Text(account.date).foregroundColor(.blue).underline().padding(5)
            }
            Spacer()
            Text("-$\(account.amount)").font(.headline).foregroundColor(.red)
        }

    }
}

struct AccountRow_Previews: PreviewProvider {
    static var previews: some View {
        AccountRow(account: Account(date: "11/8/19", type: "飲食", amount: "123"))
            .previewLayout(.sizeThatFits)
    }
}
