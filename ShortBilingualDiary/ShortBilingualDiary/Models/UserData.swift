//
//  UserData.swift
//  ShortBilingualDiary
//  
//  Created by e.hasegawa on 2022/12/02.
//  

import SwiftUI

class UserData: ObservableObject {
    @Published var diaries: [DiaryItem]
    @Published var changedDiary: DiaryItem?
    
    init(diaries: [DiaryItem]) {
        self.diaries = diaries
    }
    
    func deleteDiary(at diaryIndex: Int?) {
        if let index = diaryIndex {
            diaries.remove(at: index)
            saveDiaries()
            print(diaries)
        }
    }
    
    func addNew(_ diary: DiaryItem) {
        diaries.append(diary)
        saveDiaries()
        print(diaries)
    }
    
    func update(_ diary: DiaryItem, at diaryIndex: Int?) {
        if let index = diaryIndex {
            print(index)
            diaries[index] = diary
            changedDiary = diary
            saveDiaries()
            print(diaries)
        }
    }
    
    func resetChangedDiary() {
        DispatchQueue.main.async {
            self.changedDiary = nil
        }
    }
    
    
    // データ保存用
    private func saveDiaries() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archive = "data.archive"
        let archiveUrl = documentDirectory.appendingPathComponent(archive)
        
        do {
            let jsonData = try JSONEncoder().encode(diaries)
            try jsonData.write(to: archiveUrl)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func loadDiaries() {
        let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let archive = "data.archive"
        let archiveUrl = documentDirectory.appendingPathComponent(archive)
        
        do {
            let jsonData = try Data(contentsOf: archiveUrl)
            diaries = try JSONDecoder().decode([DiaryItem].self, from: jsonData)
        } catch {
            print(error.localizedDescription)
        }
        
        if diaries.isEmpty {
            print("No saved diaries.")
        } else {
            print(diaries)
        }
    }
    
    
    // プレビュー用
    static func test() -> UserData {
        let diariesForPreviews = [
            DiaryItem(decoration: .circle,
                      date: Date(),
                      text1: "今日はいつもと変わらない１日だった。\n普段通り朝起きて仕事に行き、家に帰ってお風呂に入り、夕食を食べ、テレビを見て寝た。",
                      text2: "There was nothing special today.\nAs usual, I got up in the morning, went to work, came home, took a bath, had dinner, watched TV and went to bed."),
            DiaryItem(decoration: .circle,
                      date: Date().diff(numOfDays: -2),
                      text1: "最近運動不足気味だったので、今日は散歩に行った。\n久しぶりにたくさん歩いたので、明日は筋肉痛になるかも…",
                      text2: "I felt like I was getting out of shape, so I went for a walk today.\nI walked a lot for the first time in a while, so I think my muscles will be sore tomorrow…"),
            DiaryItem(decoration: .star,
                      date: Date().diff(numOfDays: -2).diff(numOfHours: 3),
                      imageData: UIImage(named: "pitaya")?.jpegData(compressionQuality: 0.5),
                      text1: "帰りに寄ったスーパーで、ドラゴンフルーツを見つけて買ってみた。\n甘さは控えめだったけれど、美味しかった。",
                      text2: "On my way home, I dropped by a supermarket and found dragon fruit there.\nI bought and tried it.\nIt was not that sweet, but was good."),
            DiaryItem(decoration: .heart,
                      date: Date().diff(numOfMonths: -1),
                      imageData: UIImage(named: "cake")?.jpegData(compressionQuality: 0.5),
                      text1: "今日は友人の誕生日だった。\nカフェが併設された洋菓子店で、ケーキを食べてお祝いした。\n友人が喜んでくれて嬉しかったし、お茶を飲みながらゆっくり話もできて楽しい１日だった。",
                      text2: "Today was my friend’s birthday.\nWe celebrated it with some cakes at a cake shop with a cafe.\nI was happy that she liked it, and it was a wonderful day to have a nice chat over a cup of tea."),
            DiaryItem(decoration: .circle,
                      date: Date().diff(numOfMonths: -3),
                      imageData: UIImage(named: "cleaning")?.jpegData(compressionQuality: 0.5),
                      text1: "今日はお風呂掃除をした。昨日、石鹸が見当たらなかったので探したら排水溝に詰まっていた。\nなんでこんなところに…と思っていると、母が「こんなところにあったの？！」と驚いていた。",
                      text2: "I cleaned the bathroom today. I couldn’t find soap there yesterday, so I looked for and found it in the drain.\nWhen I was wondering why it was there, my mother was surprised and said, “Was it there?!”"),
            DiaryItem(decoration: .star,
                      date: Date().diff(numOfYears: -1),
                      imageData: UIImage(named: "capybara")?.jpegData(compressionQuality: 0.5),
                      text1: "今日は動物園に行った。\n最近カピバラの赤ちゃんが生まれたそうで、水遊びをしたり、餌を食べたりする姿が可愛かった。",
                      text2: "I went to a zoo today.\nThere were baby capybaras, and the information board said that they were born recently. It was cute when they were playing in the water and eating.")
        ]
        
        return UserData(diaries: diariesForPreviews)
    }
}
