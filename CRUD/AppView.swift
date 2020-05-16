//
//  AppView.swift
//  CRUD
//
//  Created by 林子平 on 2020/5/16.
//  Copyright © 2020 林子平. All rights reserved.
//

import SwiftUI

struct AppView: View {
    @ObservedObject var accountData = AccountData()
    
    var body: some View {
        TabView {
            AccountList(accountData: self.accountData)
                .tabItem {
                    Image(systemName: "dollarsign.square.fill")
                    Text("記帳本")
            }
            ChartView(accountData: self.accountData)
                .tabItem {
                    Image(systemName: "chart.bar.fill")
                    Text("圖表統計")
            }
        }
    }
}

struct AppView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
