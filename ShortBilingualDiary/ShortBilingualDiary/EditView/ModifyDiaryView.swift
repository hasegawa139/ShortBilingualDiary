//
//  ModifyDiaryView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct ModifyDiaryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userData: UserData
    
    @Binding var diary: DiaryItem
    let diaryIndex: Int?
    @State private var image: UIImage?
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    DiaryFormView(decoration: $diary.decoration, date: $diary.date, image: $image, text1: $diary.text1, text2: $diary.text2)
                    
                    Button(action: {
                        userData.update(diary, at: diaryIndex)
                        dismiss()
                    }) {
                        Text("更新")
                            .font(.title2)
                    }
                    .disabled(diary.text1.isEmpty || diary.text2.isEmpty)
                    .padding()
                }
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {
                            undoDiaryUpdate()
                            dismiss()
                        }) {
                            Text("キャンセル")
                        }
                    }
                }
            }
        }
        .onAppear {
            if let data = diary.imageData {
                image = UIImage(data: data)
            }
        }
        .onChange(of: image) { newImage in
            diary.imageData = newImage?.jpegData(compressionQuality: 0.5)
        }
    }
    
    private func undoDiaryUpdate() {
        if let index = diaryIndex {
            if let data = userData.diaries[index].imageData {
                image = UIImage(data: data)
            } else {
                image = nil
            }
            diary = userData.diaries[index]
        }
    }
}

struct ModifyDiaryView_Previews: PreviewProvider {
    static let index = 4
    static var previews: some View {
        ModifyDiaryView(diary: .constant(UserData.test().diaries[index]), diaryIndex: index)
            .environmentObject(UserData.test())
    }
}
