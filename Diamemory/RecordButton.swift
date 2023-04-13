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
    
    private var recordingEnable : Bool!
    @State var diaryContent = ""
    
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        recognitionTask?.cancel()
        self.recognitionTask = nil
        
        // Configure the audio session for the app.
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        let inputNode = audioEngine.inputNode

        // Create and configure the speech recognition request.
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to create a SFSpeechAudioBufferRecognitionRequest object") }
        recognitionRequest.shouldReportPartialResults = true
        
        // Keep speech recognition data on device
        if #available(iOS 13, *) {
            recognitionRequest.requiresOnDeviceRecognition = false
        }
        
        // Create a recognition task for the speech recognition session.
        // Keep a reference to the task so that it can be canceled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                // Update the text view with the results.
                self.diaryContent = result.bestTranscription.formattedString
                isFinal = result.isFinal
                print("Text \(result.bestTranscription.formattedString)")
            }
            
            if error != nil || isFinal {
                // Stop recognizing speech if there is a problem.
                self.audioEngine.stop()
                inputNode.removeTap(onBus: 0)

                self.recognitionRequest = nil
                self.recognitionTask = nil

                self.recordingEnable = true
                //self.recordButton.setTitle("Start Recording", for: [])
            }
        }

        // Configure the microphone input.
        let recordingFormat = inputNode.outputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 1024, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        try audioEngine.start()
        
        // Let the user know to start talking.
        diaryContent = "(Go ahead, I'm listening)"
    }
    
    func recordButtonTapped() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordingEnable = false
            //recordButton.setTitle("Stopping", for: .disabled)
        } else {
            do {
                try startRecording()
                //recordButton.setTitle("Stop Recording", for: [])
            } catch {
                //recordButton.setTitle("Recording Not Available", for: [])
            }
        }
    }
    
}


struct RecordButton: View {
    @State var isRecording: Bool
    var size : CGFloat = 70
        
    @State private var degree: Int = 270

    var body: some View {
        VStack {
            
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


//@State var diaryContent = ""
struct InputText: View {
    var body: some View {
        VStack {
            //Spacer().frame(height: 100)
            
            /*TextField("今日は何がありましたか？", text: $diaryContent)
                .padding()
            Text("\(diaryContent)")
                .padding()*/
            
            Spacer()
        }
    }
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
        VStack {
            InputText()
            Spacer()
            Text("Haaa")
            Spacer()
            RecordButton(isRecording: false)
        }
    }
}
