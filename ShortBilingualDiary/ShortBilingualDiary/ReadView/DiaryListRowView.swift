//
//  DiaryListRowView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct DiaryListRowView: View {
    let diary: DiaryItem
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: diary.decoration.icon)
                Text(diary.date.formatDateForDiary())
            }
            
            Divider()
            
            HStack {
                if let data = diary.imageData, let uiImage = UIImage(data: data) {
                    Image(uiImage: uiImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                        .padding(.trailing)
                }
                
                VStack(alignment: .leading) {
                    Text(diary.text1)
                        .lineLimit(1)
                    
                    Divider()
                    
                    Text(diary.text2)
                        .lineLimit(1)
                }
            }
        }
    }
}

struct DiaryListRowView_Previews: PreviewProvider {
    static let index = 3
    static var previews: some View {
        DiaryListRowView(diary: UserData.test().diaries[index])
    }
}
