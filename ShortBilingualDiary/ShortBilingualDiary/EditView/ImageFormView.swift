//
//  ImageFormView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct ImageFormView: View {
    @Binding var image: UIImage?
    
    @State private var showingActionSheet = false
    @State private var showingPHPickerView = false
    @State private var showingImagePickerView = false
    
    var body: some View {
        Group {
            if let uiImage = image {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
            } else {
                ZStack {
                    Image(systemName: "photo.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding()
                    Text("写真を登録する（任意）")
                        .foregroundColor(.gray)
                }
            }
        }
        .onTapGesture {
            showingActionSheet = true
        }
        .actionSheet(isPresented: $showingActionSheet) {
            ActionSheet(title: Text("写真を選択"),
                        message: Text("どちらから登録しますか？"),
                        buttons: [
                            .default(Text("フォトライブラリー"), action: {
                                showingPHPickerView = true
                            }),
                            .default(Text("カメラ"), action: {
                                showingImagePickerView = true
                            }),
                            .destructive(Text("写真を削除"), action: {
                                image = nil
                            }),
                            .cancel(Text("キャンセル"))
                        ]
            )
        }
        .sheet(isPresented: $showingPHPickerView) {
            PHPickerView(image: $image)
        }
        .sheet(isPresented: $showingImagePickerView) {
            ImagePickerView(image: $image)
        }
    }
}

struct ImageFormView_Previews: PreviewProvider {
    static var previews: some View {
        ImageFormView(image: .constant(nil))
    }
}
