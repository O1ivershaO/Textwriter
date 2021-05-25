//
//  ContentView.swift
//  Textwriter
//
//  Created by Oliver Shaw on 3/15/21.
//

import SwiftUI
import UIKit
import Vision
import CoreImage
import CoreImage.CIFilterBuiltins




extension UIColor {
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
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

func recognizeTextHandler(request: VNRequest, error: Error?) {
    guard let observations =
            request.results as? [VNRecognizedTextObservation] else {
        return
    }
    let recognizedStrings = observations.compactMap { observation in
        // Return the string of the top VNRecognizedText instance.
        return observation.topCandidates(1).first?.string
    }
    
    // Process the recognized strings.
    
}

func load(){
    guard let cgImage = UIImage(named: "text")?.cgImage else { return }
}

struct ContentView: View {
    
   
    
    let requestHandler = VNImageRequestHandler(cgImage: cgImage)
    let request = VNRecognizeTextRequest(completion: recognizeTextHandler)
    
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
                        
                        Image("text")
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
                            .frame(width: 400, height: 380, alignment: .center)
                    }
                    
                    
                    
                    HStack(spacing: 40){
                        NavigationLink(destination: Settings()) {
                            Image(systemName:"gearshape.2.fill")
                                .resizable()
                                .frame(width: 130.0, height:100)
                                .foregroundColor(.black)
                        }.buttonStyle(PlainButtonStyle())
                        
                        Button(action: {
                            //let aColor = cgImage!.getPixelColor(pos: CGPoint(x: 60, y: 70))
                            //print(aColor.rgba)
                            load()
                            
                            do {
                                // Perform the text-recognition request.
                                try requestHandler.perform([request])
                            } catch {
                                print("Unable to perform the requests: \(error).")
                            }
                            
                            recognizeTextHandler(request: <#T##VNRequest#>, error: <#T##Error?#>)
                            
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

