//
//  DecorationPickerView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct DecorationPickerView: View {
    @EnvironmentObject var selectedItem: SelectedItem
    
    @State private var diariesDecorationList: [DiaryItem.Decoration] = []
    
    var body: some View {
        Picker("アイコン", selection: $selectedItem.selectedDecoration) {
            Text("選択しない").tag(DiaryItem.Decoration?.none)
            ForEach(diariesDecorationList, id: \.self) { decoration in
                Image(systemName: decoration.icon).tag(DiaryItem.Decoration?.some(decoration))
            }
        }
        .pickerStyle(.wheel)
        .onAppear {
            extractDiariesDecoration()
        }
        .onChange(of: selectedItem.extractedDiaryList) {_ in
            extractDiariesDecoration()
        }
    }
    
    private func extractDiariesDecoration() {
        for diary in selectedItem.extractedDiaryList {
            diariesDecorationList.append(diary.decoration)
        }
        diariesDecorationList = Set(diariesDecorationList).sorted(by: { (a, b) -> Bool in
            return a.rawValue < b.rawValue
        })
    }
}

struct DecorationPickerView_Previews: PreviewProvider {
    static var previews: some View {
        DecorationPickerView()
            .environmentObject(SelectedItem.test())
    }
}
