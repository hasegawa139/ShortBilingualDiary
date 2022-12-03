//
//  ExtractedDiariesView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct ExtractedDiariesView: View {
    @EnvironmentObject var selectedItem: SelectedItem
    
    var body: some View {
        NavigationView {
            VStack {
                DiaryListFormView(diaries: $selectedItem.extractedDiaryList)
                
                Text("\(selectedItem.extractedDiaryList.count)件")
                    .foregroundColor(.gray)
            }
        }
    }
}

struct ExtractedDiariesView_Previews: PreviewProvider {
    static var previews: some View {
        ExtractedDiariesView()
            .environmentObject(SelectedItem.test())
    }
}
