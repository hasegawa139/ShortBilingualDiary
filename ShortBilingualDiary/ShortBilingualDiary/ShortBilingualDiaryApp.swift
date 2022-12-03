//
//  ShortBilingualDiaryApp.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/01.
//  

import SwiftUI

@main
struct ShortBilingualDiaryApp: App {
    @StateObject var userData = UserData(diaries: [])
    
    var body: some Scene {
        WindowGroup {
            DisplayStyleTabView()
                .environmentObject(userData)
                .onAppear {
                    userData.loadDiaries()
                    print(NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true))
                }
        }
    }
}
