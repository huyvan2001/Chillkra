//
//  StatsView.swift
//  Chillkra
//
//  Created by Lê Văn Huy on 06/09/2022.
//
import SwiftUI
struct StatsView: View {
    @EnvironmentObject var viewModel: AuthViewModel
    @State private var selectFiller: StatsFillerViewModel = .activity
    let customSize = CustomSize()
    @Namespace var animation
    var body: some View {
        VStack{
            
            if let user = viewModel.currentUser {
                HeaderView(imageApp: "General.sun", textApp: "Chillkra", name: user.name, personImage: "Person",title: "Stats")
            }
            
            statsFiller
            if selectFiller == .activity {
                withAnimation(.easeInOut){
                    TotalRow(title: "Total played", amount: "120K", nameAmount: "reproductions", timeupdate: "Last update yesterday")
                    
                }
                    
            }
            else if selectFiller == .bedtime {
                withAnimation(.easeInOut){
                    TotalRow(title: "Total slept", amount: "246", nameAmount: "hours", timeupdate: "Last update this morning")
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
        StatsView()
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
                            .frame(width:87,height:1)
                            .matchedGeometryEffect(id: "filler", in: animation)
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
