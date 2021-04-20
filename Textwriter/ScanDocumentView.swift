//
//  ScanDocumentView.swift
//  Textwriter
//
//  Created by Oliver Shaw on 4/14/21.
//

import SwiftUI
import VisionKit

struct ScanDocumentView: UIViewControllerRepresentable {
  
    @Binding var recognizedText: String
    
    func makeUIViewController(context: Context) -> VNDocumentCameraViewController {
        let documentViewController = VNDocumentCameraViewController()
        documentViewController.delegate = context.coordinator
        return documentViewController
        //implement
    }
    
    func updateUIViewController(_ uiViewController: VNDocumentCameraViewController, context: Context) {
                
    }
    
    class Coordinator: NSObject, VNDocumentCameraViewControllerDelegate {
      
        var recognizedText: Binding<String>
        var parent: ScanDocumentView
        
        init(recognizedText: Binding<String>, parent: ScanDocumentView) {
            self.recognizedText = recognizedText
            self.parent = parent
        }
        
        func documentCameraViewController(_ controller: VNDocumentCameraViewController, didFinishWith scan: VNDocumentCameraScan) {
            // do the processing of the scan
        }
        
        fileprivate func extractImages(from scan: VNDocumentCameraScan) -> [CGImage] {
            var extractedImages = [CGImage]()
            for index in 0..<scan.pageCount {
                let extractedImage = scan.imageOfPage(at: index)
                guard let cgImage = extractedImage.cgImage else { continue }
                
                extractedImages.append(cgImage)
            }
            return extractedImages
        }
    }
    
 
        
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedText: $recognizedText, parent: self)
    }
    
    

    
}

