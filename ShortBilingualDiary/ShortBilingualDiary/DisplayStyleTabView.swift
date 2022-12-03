//
//  DisplayStyleTabView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct DisplayStyleTabView: View {
    @StateObject var selectedItem = SelectedItem(extractedDiaryList: [])
    
    var body: some View {
        TabView {
            DiariesCalendarView()
                .tabItem {
                    Label("カレンダー", systemImage: "calendar")
                }
            
            DiaryListView()
                .tabItem {
                    Label("日記", systemImage: "text.book.closed")
                }
                .environmentObject(selectedItem)
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = .white.withAlphaComponent(0.9)
        }
    }
}

struct DisplayStyleTabView_Previews: PreviewProvider {
    static var previews: some View {
        DisplayStyleTabView()
            .environmentObject(UserData.test())
    }
}
