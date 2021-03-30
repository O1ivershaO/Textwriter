//
//  Settings.swift
//  Textwriter
//
//  Created by Oliver Shaw on 3/30/21.
//

import SwiftUI

struct Settings: View {
    var body: some View {
        ZStack{
            LinearGradient(gradient: Gradient(colors: [.black, .gray, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                Text("Settings")
                    .font(.system(size: 50, design: .rounded))
                    .fontWeight(.light)
                    .foregroundColor(.black)
                    .font(.largeTitle)
                    .gradientForeground(colors: [Color.blue, Color.black, Color.black,Color.black])
            }
        }
        
        
        
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings()
    }
}
