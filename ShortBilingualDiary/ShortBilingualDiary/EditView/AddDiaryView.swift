//
//  AddDiaryView.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

struct AddDiaryView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var userData: UserData
    @Binding var dateComponent: DateComponents
    
    @State private var decoration = DiaryItem.Decoration.circle
    @State private var date = Date()
    @State private var image: UIImage?
    @State private var imageData: Data?
    @State private var text1 = ""
    @State private var text2 = ""
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    DiaryFormView(decoration: $decoration, date: $date, image: $image, text1: $text1, text2: $text2)
                        .onAppear {
                            if let selectedDate = dateComponent.date {
                                date = selectedDate
                            }
                        }
                    
                    Button(action: {
                        addDiary()
                        dismiss()
                    }) {
                        Text("登録")
                            .font(.title2)
                    }
                    .disabled(text1.isEmpty || text2.isEmpty)
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
        }
    }
    
    private func addDiary() {
        imageData = image?.jpegData(compressionQuality: 0.5)
        let diary = DiaryItem(decoration: decoration, date: date, imageData: imageData, text1: text1, text2: text2)
        userData.addNew(diary)
    }
}

struct AddDiaryView_Previews: PreviewProvider {
    static var dateComponent: DateComponents = Calendar.current.dateComponents(in: TimeZone.current, from: Date())
    
    static var previews: some View {
        AddDiaryView(dateComponent: .constant(dateComponent))
            .environmentObject(UserData.test())
    }
}
