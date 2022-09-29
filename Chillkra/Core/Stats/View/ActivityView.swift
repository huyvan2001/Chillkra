//
//  ActivityView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 07/09/2022.
//

import SwiftUI
import Charts

var access2019 :[Access] = [
    Access(type: "Jan", value: 400),
    Access(type: "Feb", value: 700),
    Access(type: "Mar", value: 700),
    Access(type: "Apr", value: 810),
    Access(type: "Jun", value: 450),
    Access(type: "Jul", value: 620),
]
var access2020:[Access] = [
    Access(type: "Jan", value: 600),
    Access(type: "Feb", value: 500),
    Access(type: "Mar", value: 800),
    Access(type: "Apr", value: 700),
    Access(type: "Jun", value: 500),
    Access(type: "Jul", value: 320),
]

struct ActivityView: View {
    var customSize = CustomSize()
    let stepData = [
        (period:"2019",data: access2019),
        (period:"2020",data:access2020),
        
    ]
    var body: some View {
        VStack{
                TotalRow(title: "Total played", amount: "120K", nameAmount: "reproductions", timeupdate: "Last update yesterday")
                
                VStack{
                    VStack(alignment: .leading){
                        Text("Monthly activity")
                            .modifier(Fonts(fontName: FontsName.JosefinBold, size: customSize.mediumText))
                            .padding(.bottom)
                        
                        if #available(iOS 16.0, *) {
                            Chart(stepData,id: \.period){ step in
                                ForEach(step.data){
                                    BarMark(x: .value("Year", $0.type),
                                            y: .value("Access", $0.value))
                                }
                                .foregroundStyle(by: .value("Year", step.period))
                                .position(by: .value("year", step.period))
                            }
                            .chartYAxis{
                                AxisMarks(position: .leading)
                            }
                            .chartForegroundStyleScale([
                                "2019": Color("Search.lightBlue"),
                                "2020": Color("Search.lightPurple")
                            ])
                            
                        } else {
                            // Fallback on earlier versions
                        }
                        
                        
                        Spacer()
                    }
                    .padding()
                }
                .frame(width: 344, height: 279)
                .background(Color("Stats.Colorrow").opacity(0.15))
                .cornerRadius(customSize.totalRadius)
        }
    }
}

struct ActivityView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityView()
    }
}
