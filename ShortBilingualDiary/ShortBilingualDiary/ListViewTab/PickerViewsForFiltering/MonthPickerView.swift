//
//  MonthPickerView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct MonthPickerView: View {
    @EnvironmentObject var selectedItem: SelectedItem
    
    @State private var diariesMonthList: [String] = []
    
    var body: some View {
        Picker("月", selection: $selectedItem.selectedMonth) {
            Text("選択しない").tag(String?.none)
            ForEach(diariesMonthList, id: \.self) { month in
                Text(month).tag(String?.some(month))
            }
        }
        .pickerStyle(.wheel)
        .onAppear {
            extractDiariesMonth()
        }
        .onChange(of: selectedItem.extractedDiaryList) {_ in
            extractDiariesMonth()
        }
    }
    
    private func extractDiariesMonth() {
        for diary in selectedItem.extractedDiaryList {
            diariesMonthList.append(diary.date.formatDateForMonth())
        }
        diariesMonthList = Set(diariesMonthList).sorted()
    }
}

struct MonthPickerView_Previews: PreviewProvider {
    static var previews: some View {
        MonthPickerView()
            .environmentObject(SelectedItem.test())
    }
}
