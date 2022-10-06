//
//  StatsView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//
import SwiftUI
import Charts
struct StatsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    
    @Binding var selectedIndex: Int
    @State private var selectFiller: StatsFillerViewModel = .activity
    
    @Namespace var animation
    
    let customSize = CustomSize()
    let sleep = Sleep(sleep: 7, deep: 3.5, quantity: 3.5/7)
    
    var body: some View {
        VStack{
            
            HeaderView(selectedIndex: $selectedIndex, title: "Stats")
            
            statsFiller
            if selectFiller == .activity {
                withAnimation(.easeInOut){
                    ActivityView()
                }
                
            }
            else if selectFiller == .bedtime {
                withAnimation(.easeInOut){
                    BedtimeView()
                }
            }
            
            
            Spacer()
        }
        .navigationBarHidden(true)
        .foregroundColor(Color("General.mainTextColor"))
        .padding()
        .background(Color("backgroundColor"))
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView(selectedIndex: .constant(1))
            .environmentObject(AuthViewModel())
    }
}

extension StatsView {
    
    var statsFiller: some View {
        
        HStack{
            
            Spacer()
            ForEach(StatsFillerViewModel.allCases, id:\.rawValue){
                item in
                VStack{
                    Text(item.title)
                        .modifier(Fonts(fontName:FontsName.JosefinBold,
                                        size: customSize.mediumText))
                        .foregroundColor(Color(selectFiller == item ?
                                               "General.mainTextColor" : "Setting.ColorTitle")
                        )
                    if selectFiller == item {
                        Capsule()
                            .foregroundColor(Color("General.mainTextColor"))
                            .frame(width:87,
                                   height:1)
                            .matchedGeometryEffect(id: "filler",
                                                   in: animation)
                    }
                    else{
                        Capsule()
                            .foregroundColor(Color(.clear))
                            .frame(width:87,height:1)
                    }
                }
                .onTapGesture {
                    withAnimation(.easeInOut) {
                        
                        self.selectFiller = item
                    }
                }
                Spacer()
            }
        }
    }
}
