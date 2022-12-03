//
//  DiaryListView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct DiaryListView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var selectedItem: SelectedItem
    
    @State private var allDiaries: [DiaryItem] = []
    @State private var dateComponent: DateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
    @State private var showingAddDiaryView = false
    @State private var showingFilterDiariesView = false
    @State private var showingExtractedDiariesView = false
    @State private var searchText = ""
    @State private var searchResults: [DiaryItem] = []
    
    var body: some View {
        NavigationView {
            VStack {
                if !showingExtractedDiariesView {
                    if userData.diaries.isEmpty {
                        Text("登録された日記はありません。")
                            .foregroundColor(.gray)
                    } else if searchText.isEmpty {
                        VStack {
                            DiaryListFormView(diaries: $allDiaries)
                            
                            Text("全\(userData.diaries.count)件")
                                .foregroundColor(.gray)
                        }
                    } else {
                        VStack {
                            DiaryListFormView(diaries: $searchResults)
                            
                            Text("\(searchResults.count)件")
                                .foregroundColor(.gray)
                        }
                    }
                } else {
                    selectedItem.showSelectedItem()
                    
                    if searchText.isEmpty {
                        VStack {
                            ExtractedDiariesView()
                        }
                    } else {
                        VStack {
                            DiaryListFormView(diaries: $searchResults)
                            
                            Text("\(searchResults.count)件")
                                .foregroundColor(.gray)
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showingAddDiaryView = true
                    }) {
                        Image(systemName: "square.and.pencil")
                    }
                    .fullScreenCover(isPresented: $showingAddDiaryView) {
                        AddDiaryView(dateComponent: $dateComponent)
                            .environmentObject(userData)
                    }
                }
                
                ToolbarItem(placement: .navigationBarLeading) {
                    if !showingExtractedDiariesView {
                        Button(action: {
                            showingFilterDiariesView = true
                        }) {
                            Text("絞り込む")
                        }
                        .disabled(userData.diaries.isEmpty)
                        .sheet(isPresented: $showingFilterDiariesView) {
                            FilterDiariesView(showingExtractedDiariesView: $showingExtractedDiariesView)
                                .presentationDetents([.medium, .large])
                                .environmentObject(userData)
                                .environmentObject(selectedItem)
                        }
                    } else {
                        Button(action: {
                            showingExtractedDiariesView = false
                            selectedItem.clearSelectedItem()
                        }) {
                            Text("条件をクリア")
                        }
                    }
                }
            }
        }
        .searchable(text: $searchText, prompt: "テキストの内容で検索")
        .onAppear {
            sortDiaries()
        }
        .onChange(of: userData.diaries) { newDiaries in
            sortDiaries()
            searchForDiaries()
            selectedItem.extract(newDiaries)
        }
        .onChange(of: searchText) {_ in
            searchForDiaries()
        }
        .onChange(of: selectedItem.extractedDiaryList) {_ in
            searchForDiaries()
            selectedItem.extract(userData.diaries)
        }
    }
    
    private func sortDiaries() {
        allDiaries = userData.diaries
        allDiaries.sort(by: { (a, b) -> Bool in
            return a.date < b.date
        })
    }
    
    private func searchForDiaries() {
        if !showingExtractedDiariesView {
            searchResults = allDiaries.filter { diary in
                diary.text1.contains(searchText) || diary.text2.contains(searchText)
            }
        } else {
            searchResults = selectedItem.extractedDiaryList.filter { diary in
                diary.text1.contains(searchText) || diary.text2.contains(searchText)
            }
        }
    }
}

struct DiaryListView_Previews: PreviewProvider {
    static var previews: some View {
        DiaryListView()
            .environmentObject(UserData.test())
            .environmentObject(SelectedItem.test())
    }
}
