//
//  CustomImagePicker.swift
//  Talent-Hunt
//
//  Created by MacBook Pro on 11/03/2025.
//

 

import Foundation
import SwiftUI
struct CustomImagePicker:UIViewControllerRepresentable{
    @Binding var contactImage:UIImage?
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        
        
    }
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
    func makeUIViewController(context: Context) ->UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate=context.coordinator
        return picker
    }
    class Coordinator:NSObject,UINavigationControllerDelegate,
    UIImagePickerControllerDelegate{
        let parent:CustomImagePicker
        init(_ parent:CustomImagePicker){
            self.parent = parent
        }
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage{
                parent.contactImage = image
            }
            picker.dismiss(animated: true)
            print("image selected")
        }
        
    }
}

