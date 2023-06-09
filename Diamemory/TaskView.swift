//
//  TaskView.swift
//  Diamemory
//
//  Created by たな on 2023/04/07.
//

import SwiftUI
import UIKit

struct CheckBoxToggleStyle:ToggleStyle{
    func makeBody(configuration: Configuration) -> some View {
        Button{
            configuration.isOn.toggle()
        } label: {
            HStack{
                Image(systemName: configuration.isOn
                      ? "checkmark.circle.fill"
                      : "circle")
                .accentColor(Color("DarkBlue"))
                //Spacer()
                configuration.label
                    .accentColor(.black)
            }
        }
    }
}

struct TaskView: View {
    @State var toggle = false
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack {//NavigationViewはiOS16から非推奨らしい
                List{
                    Text("めちゃめちゃ") + Text("りんご買う")
                    Toggle("なすび買う", isOn: $toggle)
                        .toggleStyle(CheckBoxToggleStyle())
                    Toggle("電気代支払い", isOn: $toggle)
                        .toggleStyle(CheckBoxToggleStyle())
                }
                .navigationTitle("タスク一覧")
            }
        } else {
            NavigationView {//NavigationViewはiOS16から非推奨らしい
                List{
                    Text("めちゃめちゃ") + Text("りんご買う")
                    Toggle("なすび買う", isOn: $toggle)
                        .toggleStyle(CheckBoxToggleStyle())
                    Text("電気代支払い")
                }
                .navigationTitle("タスク一覧")
            }
            // Fallback on earlier versions
        }
    }
}
//検索機能はSearchBarが良さそうだけど、位置やサイズの調整が難しいのと他のビュートの連携がむずいらしい

struct TaskView_Previews: PreviewProvider {
    static var previews: some View {
        TaskView()
    }
}
