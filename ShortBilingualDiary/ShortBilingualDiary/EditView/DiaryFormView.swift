//
//  DiaryFormView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct DiaryFormView: View {
    @Binding var decoration: DiaryItem.Decoration
    @Binding var date: Date
    @Binding var image: UIImage?
    @Binding var text1: String
    @Binding var text2: String
    
    var body: some View {
        ScrollView {
            HStack {
                Picker("アイコン", selection: $decoration) {
                    ForEach(DiaryItem.Decoration.allCases, id: \.self) { decoration in
                        Image(systemName: decoration.icon)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                
                DatePicker(selection: $date) {
                    Text("")
                }
                .padding()
                .environment(\.locale, Locale(identifier: "ja_JP"))
            }
            
            ImageFormView(image: $image)
            TextFormView(text: $text1, placeHolder: "テキストを入力（第一言語）")
            TextFormView(text: $text2, placeHolder: "テキストを入力（第二言語）")
        }
    }
}

struct DiaryFormView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryFormView(decoration: .constant(DiaryItem.Decoration.circle), date: .constant(Date()), image: .constant(nil), text1: .constant(""), text2: .constant(""))
    }
}
