//
//  ImagePicker.swift
//  InventoryApp
//
//  Created by Matt Pandolfo on 2/7/23.
//

import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
  @Binding var selectedImageData: Data?
  @Environment(\.presentationMode) private var presentationMode
    
  func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
    let imagePicker = UIImagePickerController()
    imagePicker.allowsEditing = false
    imagePicker.sourceType = .camera
    imagePicker.delegate = context.coordinator
    imagePicker.cameraCaptureMode = .photo
        
    return imagePicker
  }
    
  func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    // leave alone for right now
  }
    
  final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var parent: ImagePicker
     
    init(_ parent: ImagePicker) {
      self.parent = parent
    }
        
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
      if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
        parent.selectedImageData = image.jpegData(compressionQuality: 1.0)
      }
     
      parent.presentationMode.wrappedValue.dismiss()
    }
  }
    
  func makeCoordinator() -> Coordinator {
    Coordinator(self)
  }
}
