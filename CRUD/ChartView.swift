//
//  ChartView.swift
//  CRUD
//
//  Created by 林子平 on 2020/5/16.
//  Copyright © 2020 林子平. All rights reserved.
//

import SwiftUI

struct ChartView: View {
    @ObservedObject var accountData = AccountData()
    var totalAmount:Double = 0
    var index:Double = 0
    var countAmount:[Double] = [0, 0, 0, 0, 0]
    var percentAmount:[Double] = [0, 0, 0, 0, 0]
    var countType:[Int] = [0, 0, 0, 0, 0]
    var anglesAmount = [Angle]()
    var startDegree: Double = 0
    var chart = ["花費比例", "類型計量"]
    @State private var selectChart: String = "花費比例"
    let types = ["餐飲食品", "3C通訊", "休閒娛樂", "運輸交通", "居家生活"]
    
    init(accountData: AccountData) {
        for data in accountData.accounts {
            index += 1;
            totalAmount += Double(data.amount) ?? 0
            if data.type == "餐飲食品" {
                countAmount[0] += Double(data.amount) ?? 0
                countType[0] += 1;
            } else if data.type == "3C通訊" {
                countAmount[1] += Double(data.amount) ?? 0
                countType[1] += 1;
            } else if data.type == "休閒娛樂" {
                countAmount[2] += Double(data.amount) ?? 0
                countType[2] += 1;
            } else if data.type == "運輸交通" {
                countAmount[3] += Double(data.amount) ?? 0
                countType[3] += 1;
            } else {
                countAmount[4] += Double(data.amount) ?? 0
                countType[4] += 1;
            }
        }
        
        percentAmount[0] = countAmount[0] / totalAmount
        percentAmount[1] = countAmount[1] / totalAmount
        percentAmount[2] = countAmount[2] / totalAmount
        percentAmount[3] = countAmount[3] / totalAmount
        percentAmount[4] = countAmount[4] / totalAmount
        
        for percent in percentAmount {
            anglesAmount.append(.degrees(startDegree))
            startDegree += 360 * percent
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Text("請選擇統計項目：")
                    .padding(EdgeInsets(top: 50, leading: 10, bottom: 0, trailing: 10))
                Picker(selection: self.$selectChart, label: Text("請選擇統計項目：")) {
                    ForEach(self.chart, id: \.self) {
                        (text) in Text(text)
                    }
                }
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
                .padding(20)
                
                if self.selectChart == "花費比例" {
                    HStack {
                        PieChartView(startAngle: anglesAmount)
                            .frame(width: 180, height: 180)
                        Spacer()
                        VStack(alignment: .trailing){
                            Color.blue.frame(width: 10, height: 10)
                            Text("餐飲食品 " + String(format: "%.1f", percentAmount[0] * 100) + "%")
                            Color.green.frame(width: 10, height: 10)
                            Text("3C通訊 " + String(format: "%.1f", percentAmount[1] * 100) + "%")
                            Color.yellow.frame(width: 10, height: 10)
                            Text("休閒娛樂 " + String(format: "%.1f", percentAmount[2] * 100) + "%")
                            Color.red.frame(width: 10, height: 10)
                            Text("運輸交通 " + String(format: "%.1f", percentAmount[3] * 100) + "%")
                            Color.orange.frame(width: 10, height: 10)
                            Text("居家生活 " + String(format: "%.1f", percentAmount[4] * 100) + "%")
                        }
                    }
                    .padding()
                    
                    Text("總花費： " + String(format: "%.0f", totalAmount) + " 元")
                } else if self.selectChart == "類型計量" {
                    Histogramview(countType: countType)
                }
                Spacer()
            }
            .navigationBarTitle("圖表統計")
        }
    }
}


struct ChartView_Previews: PreviewProvider {
    static var previews: some View {
        ChartView(accountData: AccountData())
    }
}

