//
//  ContentView.swift
//  Textwriter
//
//  Created by Oliver Shaw on 3/15/21.
//

import SwiftUI
import UIKit

extension Color {
    var components: (red: CGFloat, green: CGFloat, blue: CGFloat, opacity: CGFloat) {

        #if canImport(UIKit)
        typealias NativeColor = UIColor
        #elseif canImport(AppKit)
        typealias NativeColor = NSColor
        #endif

        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var o: CGFloat = 0

        guard NativeColor(self).getRed(&r, green: &g, blue: &b, alpha: &o) else {
            // You can handle the failure here as you want
            return (0, 0, 0, 0)
        }

        return (r, g, b, o)
    }
}

extension UIColor {

    func toHexString() -> String {
        var r: CGFloat = 0
        var g: CGFloat = 0
        var b: CGFloat = 0
        var a: CGFloat = 0
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        return String(
            format: "%02X%02X%02X",
            Int(r * 0xff),
            Int(g * 0xff),
            Int(b * 0xff)
        )
    }
    
    func rgb() -> Int? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            let iAlpha = Int(fAlpha * 255.0)

            
            let rgb = iAlpha  + iRed  + iGreen  + iBlue
            return rgb
        } else {
            // Could not extract RGBA components:
            return nil
        }
    }
}

extension UIImage {
    func getPixelColor(pos: CGPoint) -> UIColor {

        let pixelData = self.cgImage!.dataProvider!.data
        let data: UnsafePointer<UInt8> = CFDataGetBytePtr(pixelData)

        let pixelInfo: Int = ((Int(self.size.width) * Int(pos.y)) + Int(pos.x)) * 4

        let r = CGFloat(data[pixelInfo]) / CGFloat(255.0)
        let g = CGFloat(data[pixelInfo+1]) / CGFloat(255.0)
        let b = CGFloat(data[pixelInfo+2]) / CGFloat(255.0)
        let a = CGFloat(data[pixelInfo+3]) / CGFloat(255.0)

        return UIColor(red: r, green: g, blue: b, alpha: a)
    }

}

struct ContentView: View {
    
    
    let RGB = UIImage(named:"text")
    @State private var showingPhotoLibrary = false
    @State private var showingScanningView = false
    @State private var image = UIImage()
    @State private var recognizedText = "Input image to start scanning"
    
    
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
                  
                    
                    HStack(spacing: 20){
                        Button(action: {
                            self.showingScanningView = true
                        }) {
                            Image(systemName:"camera")
                                .resizable()
                                .frame(width: 100.0, height: 80)
                                .foregroundColor(.black)
                        }.buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $showingScanningView) {
                            ScanDocumentView(recognizedText: self.$recognizedText)
                        }
                        
                        Image(uiImage: self.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 70)
                            .edgesIgnoringSafeArea(.all)
                            .cornerRadius(7)
                            .background(Color.gray)
                            .cornerRadius(10)
                        Button(action: {
                            self.showingPhotoLibrary = true
                        })  {
                            Image(systemName:"arrow.up.doc")
                                .resizable()
                                .frame(width: 80.0, height: 90)
                                .foregroundColor(.black)
                        }.buttonStyle(PlainButtonStyle())
                        .sheet(isPresented: $showingPhotoLibrary){
                            ImagePicker(selectedImage: self.$image, sourceType: .photoLibrary)
                        }
                    }
                    
                    
                    ScrollView{
                    Text(recognizedText)
                        .font(.system(size: 20, design: .rounded))
                        .fontWeight(.regular)
                        .foregroundColor(.black)
                        .font(.largeTitle)
                        .frame(width: 400, height: 380, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    }
                    
                    
                    
                    HStack(spacing: 40){
                        NavigationLink(destination: Settings()) {
                            Image(systemName:"gearshape.2.fill")
                                .resizable()
                                .frame(width: 130.0, height:100)
                                .foregroundColor(.black)
                        }.buttonStyle(PlainButtonStyle())
                    
                        Button(action: {
                            let aColor = RGB!.getPixelColor(pos: CGPoint(x: 60, y: 70))
                            print(aColor.getRed(<#T##red: UnsafeMutablePointer<CGFloat>?##UnsafeMutablePointer<CGFloat>?#>, green: <#T##UnsafeMutablePointer<CGFloat>?#>, blue: <#T##UnsafeMutablePointer<CGFloat>?#>, alpha: <#T##UnsafeMutablePointer<CGFloat>?#>))
                        }) {
                        Image(systemName:"doc.on.doc")
                            .resizable()
                            .frame(width: 80.0, height: 90)
                            .foregroundColor(.black)
                    }.buttonStyle(PlainButtonStyle())
                
                    
                }//VStack
            }
                
                
                
                
            }
            }//ZStack
        
    }//Nav
}//body



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
