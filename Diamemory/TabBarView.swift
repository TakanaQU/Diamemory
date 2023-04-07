//
//  TabBarView.swift
//  Diamemory
//
//  Created by たな on 2023/04/07.
//

import SwiftUI
import UIKit

struct TabBarView: View {
    var body: some View {
        TabView{
            RecordButton(isRecording: false)
                .tabItem {
                    Image(systemName: "pencil")
                    Text("日記をつける")
                }
            TaskView()
                .tabItem{
                    Image(systemName: "list.bullet")
                    Text("タスク")
                }
            PastDiaryView()
                .tabItem {
                    Image(systemName: "book.fill")
                    Text("日記帳")
                }
        }
        //Color("PaleBlue")
        .accentColor(Color("DarkBlue"))
        //.foregroundColor(Color.brown) Text in all view get brown
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
