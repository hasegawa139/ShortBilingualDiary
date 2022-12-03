//
//  DiariesCalendarView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct DiariesCalendarView: View {
    @EnvironmentObject var userData: UserData
    
    @State private var dateComponent: DateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
    @State private var showingAddDiaryView = false
    
    var body: some View {
        VStack {
            NavigationView {
                ScrollView {
                    CalendarView(dateComponent: $dateComponent)
                        .padding()
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
                }
            }
            
            DaysDiaryListView(dateComponent: $dateComponent)
                .frame(height: 180)
        }
    }
}

struct DiariesCalendarView_Previews: PreviewProvider {
    static var previews: some View {
        DiariesCalendarView()
            .environmentObject(UserData.test())
    }
}
