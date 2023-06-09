//
//  CustomTabBar.swift
//  Baluchon
//
//  Created by Zidouni on 17/04/2023.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: TabBar
    @State var present = true
    
    var body: some View {
        VStack {
            HStack {
                ForEach(TabBar.allCases, id: \.rawValue) { tab in
                    Spacer()
                    VStack(spacing: 5) {
                        Image("\(selectedTab == tab ? selectedTab.rawValue : tab.rawValue)")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundColor(selectedTab == tab ? .primaryColor : .iconColor)
                            .onTapGesture {
                                selectedTab = tab
                            }
                        Circle()
                            .foregroundColor(.primaryColor)
                            .opacity(selectedTab == tab ? 1 : 0)
                            .frame(width: 5, height: 5)
                    }
                    Spacer()        
                }
            }
            .padding()
            
            .frame(maxWidth: .infinity)
            .background(Color.secondaryColor, in: RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding(.horizontal, 20)
            
        }
    }
}

struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedTab: .constant(.translation))
            .padding()
            .background(Color.backgroundColor)
    }
}
