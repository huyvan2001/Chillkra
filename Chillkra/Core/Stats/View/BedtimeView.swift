//
//  BedtimeView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 23/09/2022.
//

import SwiftUI

struct BedtimeView: View {
    
    var customSize = CustomSize()
    let sleep = Sleep(sleep: 7, deep: 3.5, quantity: 3.5/7)
    var body: some View {
        
        VStack {
            TotalRow(title: "Total slept", amount: "246", nameAmount: "hours", timeupdate: "Last update this morning")
            VStack{
                
                Text("Today sleep value")
                    .modifier(Fonts(fontName: .JosefinBold, size: customSize.mediumText))
                    .padding(.bottom,2)
                Text("Sleep range 23:00 - 6:15")
                    .modifier(Fonts(fontName: .kalam, size: customSize.smallText))
                    .foregroundColor(Color("Search.blue"))
                HStack{
                    circle(percent: "\(Int(sleep.sleep/24*100))%", colorstroke: "Search.lightBlue", value: sleep.sleep, text: "Sleep")
                        .padding()
                    circle(percent: "\(Int(sleep.deep/24*100))%", colorstroke: "Search.lightPurple", value: sleep.sleep, text: "Deep")
                    circle(percent: "\(Int(sleep.quantity*100))%", colorstroke: "Search.blue", value: sleep.sleep, text: "Quantity")
                        .padding()
                }
                Text("Eos in autem itaque nihil in nesciunt sint.\nConsequuntur vitae ratione et ut eligendi dolorem.\nExpedita quia aut est.Ducimus officia minima.\nDeleniti excepturi voluptate minima")
                    .modifier(Fonts(fontName: .kalam, size: customSize.smalltinyText))
                    .foregroundColor(Color("Search.lightBlue"))
                
                Spacer()
            }
            .padding()
            .frame(width: 344, height: 331)
            .background(Color("Stats.Colorrow").opacity(0.15))
            .cornerRadius(customSize.totalRadius)
            .padding()
        }
    }
}

struct BedtimeView_Previews: PreviewProvider {
    static var previews: some View {
        BedtimeView()
    }
}

struct circle: View {
    
    let customSize = CustomSize()
    let percent: String
    let colorstroke: String
    let value: Double
    let text: String
    
    var body: some View{
        
        VStack{
            ZStack{
                Text(percent)
                    .modifier(Fonts(fontName: .boldKalam, size: customSize.tinyText))
                    .foregroundColor(Color(colorstroke))
                Circle()
                    .stroke(
                        Color("Stats.ColorCircle"),
                        lineWidth: 5
                    )
                Circle()
                    .trim(from: 0,to: value/24 )
                    .stroke(
                        Color(colorstroke),
                        style: StrokeStyle(lineWidth: 5,lineCap: .round)
                    )
                    .rotationEffect(.degrees(-90))
            }
            .frame(width:67,height: 67)
            Text(text)
                .modifier(Fonts(fontName: .kalam, size: customSize.smallText))
                .foregroundColor(Color(colorstroke))
        }
    }
}
