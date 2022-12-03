//
//  SelectedItem.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

class SelectedItem: ObservableObject {
    @Published var selectedYear: String?
    @Published var selectedMonth: String?
    @Published var selectedDecoration: DiaryItem.Decoration?
    @Published var extractedDiaryList: [DiaryItem]
    
    init(selectedYear: String? = nil, selectedMonth: String? = nil, selectedDecoration: DiaryItem.Decoration? = nil, extractedDiaryList: [DiaryItem]) {
        self.selectedYear = selectedYear
        self.selectedMonth = selectedMonth
        self.selectedDecoration = selectedDecoration
        self.extractedDiaryList = extractedDiaryList
    }
    
    func showSelectedItem() -> some View {
        HStack {
            Text("選択条件")
            Text("年: \(selectedYear ?? "-"), 月: \(selectedMonth ?? "-"), アイコン:")
            if let decoration = selectedDecoration {
                Image(systemName: decoration.icon)
            } else {
                Text("-")
            }
        }
        .foregroundColor(.gray)
    }
    
    func extract(_ diaries: [DiaryItem]) {
        extractedDiaryList = diaries
        if selectedYear != nil {
            extractedDiaryList = extractedDiaryList.filter({ diary in
                diary.date.formatDateForYear() == selectedYear
            })
        }
        if selectedMonth != nil {
            extractedDiaryList = extractedDiaryList.filter({ diary in
                diary.date.formatDateForMonth() == selectedMonth
            })
        }
        if selectedDecoration != nil {
            extractedDiaryList = extractedDiaryList.filter({ diary in
                diary.decoration == selectedDecoration
            })
        }
        
        extractedDiaryList.sort(by: { (a, b) -> Bool in
            return a.date < b.date
        })
    }
    
    func clearSelectedItem() {
        selectedYear = nil
        selectedMonth = nil
        selectedDecoration = nil
    }
    
    
    // プレビュー用
    static func test() -> SelectedItem {
        let selectedItemForPreviews = SelectedItem(extractedDiaryList: UserData.test().diaries)
        return selectedItemForPreviews
    }
}
