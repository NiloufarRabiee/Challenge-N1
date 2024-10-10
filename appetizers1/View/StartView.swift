//
//  StartView.swift
//  appetizers1
//
//  Created by Niloufar Rabiee on 14/10/24.
//

import SwiftUI

struct StartView: View {
    var body: some View {
        ZStack {
            Color (.secondarySystemFill)
                .ignoresSafeArea()
        VStack {
            Image(systemName: "rainbow")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 100 , height: 100)
                .symbolRenderingMode(.multicolor)
                .symbolEffect(.variableColor .reversing)
            
            VStack  {
                Text("Welcome To Apparat App")
                    .font(.system(size: 40))
                    .fontWeight(.bold)
                

                
            }
            .frame(width: 300)
                
        }
        }
    }
}

#Preview {
    StartView()
}
