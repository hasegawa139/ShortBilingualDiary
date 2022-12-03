//
//  DiaryImageView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct DiaryImageView: View {
    @Binding var isPresent: Bool
    
    let diaryImage: UIImage
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.white)
            
            VStack(alignment: .trailing) {
                Button(action: {
                    withAnimation {
                        isPresent = false
                    }
                }) {
                    Text("✖️")
                }
                .padding()
                
                Image(uiImage: diaryImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
        }
    }
}

struct DiaryImageView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryImageView(isPresent: .constant(true), diaryImage: UIImage(named: "cleaning")!)
    }
}
