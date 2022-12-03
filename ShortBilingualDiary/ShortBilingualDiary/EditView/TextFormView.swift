//
//  TextFormView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct TextFormView: View {
    @Binding var text: String
    let placeHolder: String
    @State private var totalChars = 0
    
    var body: some View {
        VStack {
            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .border(.selection, width: 1)
                if text.isEmpty {
                    Text(placeHolder)
                        .foregroundColor(.gray)
                        .padding(10)
                }
            }
            .frame(height: 200)
            .padding(.horizontal)
            
            Text("\(totalChars) / 200 ")
                .foregroundColor(.gray)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .padding(.horizontal)
        }
        .onAppear {
            totalChars = text.count
        }
        .onChange(of: text) { newText in
            totalChars = newText.count
        }
        .onChange(of: text) { newText in
            if newText.count > 200 {
                text.removeLast(text.count - 200)
            }
        }
    }
}

struct TextFormView_Previews: PreviewProvider {
    static var previews: some View {
        TextFormView(text: .constant(""), placeHolder: "テキストを入力（第一言語）")
    }
}
