//
//  Histogramview.swift
//  CRUD
//
//  Created by 林子平 on 2020/5/16.
//  Copyright © 2020 林子平. All rights reserved.
//

import SwiftUI

struct Histogramview: View {
    var countType = [Int]()
    var percent:[CGFloat] = [0, 0, 0, 0, 0]
    var label:[Int] = [0, 0, 0, 0, 0]
    var max:CGFloat = 0
    var total:CGFloat = 0
    let types = ["餐飲食品", "3C通訊", "休閒娛樂", "運輸交通", "居家生活"]
    
    init(countType: [Int]) {
        for amount in countType {
            if CGFloat(amount) > max {
                max = CGFloat(amount)
            }
            total += CGFloat(amount)
        }
        
        label[0] = countType[0]
        label[1] = countType[1]
        label[2] = countType[2]
        label[3] = countType[3]
        label[4] = countType[4]
        percent[0] = CGFloat(CGFloat(countType[0]) / total)
        percent[1] = CGFloat(CGFloat(countType[1]) / total)
        percent[2] = CGFloat(CGFloat(countType[2]) / total)
        percent[3] = CGFloat(CGFloat(countType[3]) / total)
        percent[4] = CGFloat(CGFloat(countType[4]) / total)
    }
    
    var body: some View {
        VStack {
            Spacer()
            HStack (alignment: .bottom){
                VStack {
                    Rectangle()
                        .fill(Color.blue)
                        .frame(
                            width: 25, height: 300 * percent[0])
                    Text("\(label[0])")
                    Text(types[0]).font(.caption)
                }
                VStack {
                    Rectangle()
                        .fill(Color.green)
                        .frame(
                            width: 25, height: 300 * percent[1])
                    Text("\(label[1])")
                    Text(types[1]).font(.caption)
                }
                VStack {
                    Rectangle()
                        .fill(Color.red)
                        .frame(
                            width: 25, height: 300 * percent[2])
                    Text("\(label[2])")
                    Text(types[2]).font(.caption)
                }
                VStack {
                    Rectangle()
                        .fill(Color.yellow)
                        .frame(
                            width: 25, height: 300 * percent[3])
                    Text("\(label[3])")
                    Text(types[3]).font(.caption)
                }
                VStack {
                    Rectangle()
                        .fill(Color.orange)
                        .frame(
                            width: 20, height: 300 * percent[4])
                    Text("\(label[4])")
                    Text(types[4]).font(.caption)
                }
            }
            Spacer()
        }
    }
}

struct Histogramview_Previews: PreviewProvider {
    static var previews: some View {
        Histogramview(countType: [10, 5, 6, 7, 8])
    }
}
