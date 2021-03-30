//
//  ContentView.swift
//  Textwriter
//
//  Created by Oliver Shaw on 3/15/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            ZStack{
                LinearGradient(gradient: Gradient(colors: [.black, .gray, .gray]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .edgesIgnoringSafeArea(.all)
                
                VStack{
                    Text("Textwriter")
                        .font(.system(size: 50, design: .rounded))
                        .fontWeight(.light)
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .gradientForeground(colors: [Color.red, Color.black, Color.black,Color.black])
                    HStack{
                        NavigationLink(destination: Settings()) {
                            Image(systemName:"gearshape.2.fill")
                                .resizable()
                                .frame(width: 130.0, height:100)
                                .foregroundColor(.black)
                             }.buttonStyle(PlainButtonStyle())
                        Spacer()
                            .frame(width: 50)
                        
                        Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                            Image(systemName:"arrow.up.doc")
                                .resizable()
                                .frame(width: 80.0, height: 90)
                                .foregroundColor(.black)
                             }.buttonStyle(PlainButtonStyle())
                        }
                    Text("//converted text showed here//")
                        .font(.system(size: 20, design: .rounded))
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .frame(width: 400, height: 380, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    
                    Button(action: /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Action@*/{}/*@END_MENU_TOKEN@*/) {
                        Image(systemName:"doc.on.doc")
                            .resizable()
                            .frame(width: 80.0, height: 90)
                            .foregroundColor(.black)
                         }.buttonStyle(PlainButtonStyle())
                    }
                }
            }
        }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension View {
    public func gradientForeground(colors: [Color]) -> some View {
        self.overlay(LinearGradient(gradient: .init(colors: colors),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing))
            .mask(self)
    }
}
