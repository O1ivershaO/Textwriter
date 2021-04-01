//
//  ImagePicker.swift
//  Textwriter
//
//  Created by Oliver Shaw on 4/1/21.
//

import Foundation
import UIKit
import SwiftUI




struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) var presentationMode
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    
    
}






