//
//  RecordButton.swift
//  Diamemory
//
//  Created by たな on 2023/04/06.
//

import SwiftUI

struct RecordButton: View {
    var isRecording : Bool = false
    var size : CGFloat = 60
    
    @State private var degree: Int = 270
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color(red:0.8, green:0.8, blue:0.8, opacity: 1),lineWidth: 4)
                .frame(width: size, height: size)
            
            if isRecording {
                Image(systemName: "stop.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size * 0.6, height: size * 0.6)
                    .clipped()
                    .foregroundColor(color())
                
                Circle()
                    .trim(from: 0.0, to: 0.25)
                    .stroke(color(), style: StrokeStyle(lineWidth: 4.0, lineCap: .round, lineJoin: .round))
                    .frame(width: size, height: size)
                    .rotationEffect(Angle(degrees: Double(degree)))
                    .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                    .onAppear {
                        rotate()
                    }
            } else {
                Image(systemName: "circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: size * 0.8, height: size * 0.8)
                    .clipped()
                    .foregroundColor(color())
            }
        }
    }
    
    func rotate() {
        self.degree = 270 + 360
    }
    
    func color() -> Color {
        return isRecording ? Color.green : Color.red
    }
}

struct RecordButton_Previews: PreviewProvider {
    static var previews: some View {
        HStack {
            RecordButton(isRecording: false)
            Spacer()
            RecordButton(isRecording: true)
        }.padding(.all)
    }
}
