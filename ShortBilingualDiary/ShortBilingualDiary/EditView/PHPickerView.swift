//
//  PHPickerView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI
import PhotosUI

struct PHPickerView: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    @Binding var image: UIImage?
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PHPickerView>) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: UIViewControllerRepresentableContext<PHPickerView>) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(parent: self)
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        var parent: PHPickerView

        init(parent: PHPickerView) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            if let result = results.first {
                result.itemProvider.loadObject(ofClass: UIImage.self) { (image, error) in
                    if let image = image as? UIImage {
                        self.parent.image = image
                    } else {
                        print("使用できる写真がありません。")
                    }
                }
            } else {
                print("選択された写真はありません。")
            }
            parent.dismiss()
        }
    }
}
