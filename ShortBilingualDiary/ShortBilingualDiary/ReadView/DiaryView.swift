//
//  DiaryView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct DiaryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userData: UserData
    
    @State var diary: DiaryItem
    @State private var diaryIndex: Int?
    @State private var showingDiaryImageView = false
    @State private var showingModifyDiaryView = false
    @State private var showingAlert = false
    
    var body: some View {
        ZStack {
            NavigationView {
                VStack {
                    VStack {
                        HStack {
                            Image(systemName: diary.decoration.icon)
                            Text(diary.date.formatDateForDiary())
                            Spacer()
                        }
                        
                        if let data = diary.imageData, let uiImage = UIImage(data: data) {
                            Divider()
                            
                            Image(uiImage: uiImage)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .onTapGesture {
                                    withAnimation {
                                        showingDiaryImageView = true
                                    }
                                }
                        }
                        
                        Divider()
                        
                        VStack(alignment: .leading) {
                            Text(diary.text1)
                            
                            Divider()
                            
                            Text(diary.text2)
                        }
                        .fixedSize(horizontal: false, vertical: true)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(.gray))
                    .padding()
                    
                    Spacer()
                    
                    Button(action: {
                        showingModifyDiaryView = true
                    }) {
                        Text("???????????????")
                    }
                    .fullScreenCover(isPresented: $showingModifyDiaryView) {
                        ModifyDiaryView(diary: $diary, diaryIndex: diaryIndex)
                            .environmentObject(userData)
                    }
                    .padding()
                    
                    Button(action: {
                        showingAlert = true
                    }) {
                        Text("???????????????")
                    }
                    .alert("??????", isPresented: $showingAlert) {
                        Button("??????", role: .destructive) {
                            userData.deleteDiary(at: diaryIndex)
                            dismiss()
                        }
                        
                        Button("???????????????", role: .cancel) { }
                    } message: {
                        Text("????????????????????????????????????")
                    }
                    .padding(.bottom)
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            dismiss()
                        }) {
                            Text("?????????")
                        }
                    }
                }
            }
            
            if showingDiaryImageView {
                if let data = diary.imageData, let uiImage = UIImage(data: data) {
                    DiaryImageView(isPresent: $showingDiaryImageView, diaryImage: uiImage)
                }
            }
        }
        .onAppear {
            diaryIndex = userData.diaries.firstIndex(of: diary)
        }
    }
}

struct DiaryView_Previews: PreviewProvider {
    static let index = 4
    static var previews: some View {
        DiaryView(diary: UserData.test().diaries[index])
            .environmentObject(UserData.test())
    }
}
