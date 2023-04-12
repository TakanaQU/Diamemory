//
//  RecordButton.swift
//  Diamemory
//
//  Created by たな on 2023/04/06.
//

import SwiftUI
import UIKit
import Speech


public class ViewController: UIViewController, SFSpeechRecognizerDelegate {
    // MARK: Properties
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "ja-JP"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    
}


struct RecordButton: View {
    @State var isRecording: Bool
    var size : CGFloat = 70
        
    @State private var degree: Int = 270

    var body: some View {
        VStack {
            Text("Hello")
                .padding()
            Spacer()
            ZStack {
                Circle()
                    .stroke(Color(red:0.8, green:0.8, blue:0.8, opacity: 1),lineWidth: 4)
                    .frame(width: size, height: size)
                
                if isRecording {
                    Image(systemName: "stop.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size * 0.4, height: size * 0.4)
                        .clipped()
                        .foregroundColor(Color.red)
                        //.foregroundColor(color())
                    
                    Circle()
                        .trim(from: 0.0, to: 0.25)
                        .stroke(style: StrokeStyle(lineWidth: 4.0, lineCap: .round, lineJoin: .round))
                        .frame(width: size, height: size)
                        .rotationEffect(Angle(degrees: Double(degree)))
                        .animation(Animation.linear(duration: 2).repeatForever(autoreverses: false))
                        .onAppear {
                            rotate()
                        }
                        .foregroundColor(Color.red)
                } else {
                    Image(systemName: "circle.fill")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: size * 0.8, height: size * 0.8)
                        .clipped()
                        //.foregroundColor(color())
                        .foregroundColor(Color.red)

                /*Circle()
                    .fill(isRecording ? Color.red : Color.white)
                    .frame(width: 70, height: 70)
                    .shadow(radius: 5)
                Circle()
                    .fill(isRecording ? Color.white : Color.red)
                    .frame(width: 60, height: 60)
                    .scaleEffect(isRecording ? 1.2 : 1.0)
                Image(systemName: "mic.fill")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(isRecording ? Color.white : Color.red)
                    .frame(width: 30, height: 30)*/
                    
                }
            }
            .onTapGesture {
                isRecording.toggle()
            }
        }
        
        
    }
    func rotate() {
        self.degree = 270 + 360
    }
    
    /*func color() -> Color {
        return isRecording ? Color.green : Color.red
    }*/
}



        
        /*
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
*/

struct RecordButton_Previews: PreviewProvider {
    static var previews: some View {
        /*HStack {
            Button
            Spacer()
            RecordButton(isRecording: true)
        }.padding(.all)*/
        RecordButton(isRecording: false)
    }
}
