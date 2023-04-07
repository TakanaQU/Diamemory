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
                    Image(systemName: "pencil.line")
                }
            TaskView()
                .tabItem{
                    Image(systemName: "list.bullet")
                }
            PastDiaryView()
                .tabItem {
                    Image(systemName: "book.fill")
                    
                }
            
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
