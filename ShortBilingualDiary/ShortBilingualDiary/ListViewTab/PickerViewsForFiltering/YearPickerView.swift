//
//  YearPickerView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct YearPickerView: View {
    @EnvironmentObject var selectedItem: SelectedItem
    
    @State private var diariesYearList: [String] = []
    
    var body: some View {
        Picker("年", selection: $selectedItem.selectedYear) {
            Text("選択しない").tag(String?.none)
            ForEach(diariesYearList, id: \.self) { year in
                Text(year).tag(String?.some(year))
            }
        }
        .pickerStyle(.wheel)
        .onAppear {
            extractDiariesYear()
        }
        .onChange(of: selectedItem.extractedDiaryList) {_ in
            extractDiariesYear()
        }
    }
    
    private func extractDiariesYear() {
        for diary in selectedItem.extractedDiaryList {
            diariesYearList.append(diary.date.formatDateForYear())
        }
        diariesYearList = Set(diariesYearList).sorted()
    }
}

struct YearPickerView_Previews: PreviewProvider {
    static var previews: some View {
        YearPickerView()
            .environmentObject(SelectedItem.test())
    }
}
