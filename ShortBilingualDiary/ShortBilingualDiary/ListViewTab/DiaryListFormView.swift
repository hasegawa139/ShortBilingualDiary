//
//  DiaryListFormView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct DiaryListFormView: View {
    @EnvironmentObject var userData: UserData
    
    @State private var selectedDiary: DiaryItem?
    @Binding var diaries: [DiaryItem]
    
    var body: some View {
        List {
            ForEach(diaries) { diary in
                Section {
                    DiaryListRowView(diary: diary)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedDiary = diary
                        }
                }
            }
            .fullScreenCover(item: $selectedDiary) { diary in
                DiaryView(diary: diary)
                    .environmentObject(userData)
            }
        }
        .listStyle(.insetGrouped)
    }
}

struct DiaryListFormView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListFormView(diaries: .constant(UserData.test().diaries))
            .environmentObject(UserData.test())
    }
}
