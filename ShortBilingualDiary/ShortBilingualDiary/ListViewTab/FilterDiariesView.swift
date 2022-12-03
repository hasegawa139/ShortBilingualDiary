//
//  FilterDiariesView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct FilterDiariesView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var selectedItem: SelectedItem
    
    @Binding var showingExtractedDiariesView: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationView {
                    Form {
                        NavigationLink {
                            YearPickerView()
                        } label: {
                            HStack {
                                Text("年")
                                Spacer()
                                Text(selectedItem.selectedYear ?? "選択しない")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        NavigationLink {
                            MonthPickerView()
                        } label: {
                            HStack {
                                Text("月")
                                Spacer()
                                Text(selectedItem.selectedMonth ?? "選択しない")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        NavigationLink {
                            DecorationPickerView()
                        } label: {
                            HStack {
                                Text("アイコン")
                                Spacer()
                                Group {
                                    if let decoration = selectedItem.selectedDecoration?.icon {                                Image(systemName: decoration)
                                    } else {
                                        Text("選択しない")
                                    }
                                }
                                .foregroundColor(.gray)
                            }
                        }
                    }
                }
                
                Button(action: {
                    dismiss()
                    showingExtractedDiariesView = true
                }) {
                    Text("絞り込む")
                }
                .disabled(selectedItem.selectedYear == nil && selectedItem.selectedMonth == nil && selectedItem.selectedDecoration == nil)
                .padding()
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        dismiss()
                    }) {
                        Text("キャンセル")
                    }
                }
            }
        }
        .onAppear {
            selectedItem.extract(userData.diaries)
        }
        .onChange(of: selectedItem.selectedYear) {_ in
            selectedItem.extract(userData.diaries)
        }
        .onChange(of: selectedItem.selectedMonth) {_ in
            selectedItem.extract(userData.diaries)
        }
        .onChange(of: selectedItem.selectedDecoration) {_ in
            selectedItem.extract(userData.diaries)
        }
        .onChange(of: userData.diaries) { newDiaries in
            selectedItem.extract(newDiaries)
        }
    }
}

struct FilterDiariesView_Previews: PreviewProvider {
    static var previews: some View {
        FilterDiariesView(showingExtractedDiariesView: .constant(false))
            .environmentObject(UserData.test())
            .environmentObject(SelectedItem.test())
    }
}
