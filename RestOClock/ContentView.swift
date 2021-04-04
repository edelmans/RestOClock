//
//  ContentView.swift
//  RestOClock
//
//  Created by Arthur Edelmans on 4/4/21.
//

import SwiftUI

let defaultTImeRemaining: CGFloat = 60
let lineWidth: CGFloat = 20
let radius: CGFloat = 70

struct ContentView: View {
    
    @State private var isActive = false
    @State private var timeRemaining: CGFloat = defaultTImeRemaining
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ZStack {
            VStack(spacing: 25){
                ZStack(content: {
                    Circle()
                        .stroke(Color.white.opacity(0.3), style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                    Circle()
                        .trim(from: 0, to: 1 - ((defaultTImeRemaining - timeRemaining) / defaultTImeRemaining))
                        .stroke(timeRemaining > defaultTImeRemaining / 2 ? Color.green : timeRemaining > defaultTImeRemaining / 4 ? Color.yellow : Color.red, style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                        .rotationEffect(.degrees(-90))
                        .animation(.linear)
                    Text("\(timeRemaining == 0 ? "Done!" : "\(Int(timeRemaining))")")
                        .font(.largeTitle)
                        .fontWeight(.heavy).foregroundColor(.white)
                }).frame(width: radius * 3, height: radius * 3, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                HStack(spacing: 25){
                    Label("\(isActive ? "Pause" : !isActive && timeRemaining == defaultTImeRemaining ? "Play" : "Resume")", systemImage: "\(isActive ? "pause.fill" : "play.fill")").onTapGesture(perform: {
                        isActive.toggle()
                    }).foregroundColor(isActive ? .red : !isActive && timeRemaining < defaultTImeRemaining ? .yellow : .white)
                    Label("Reset", systemImage: "backward.fill").onTapGesture(perform: {
                        isActive = false
                        timeRemaining = defaultTImeRemaining
                    }).foregroundColor(.white)
                }
            }.onReceive(timer, perform: { _ in
                guard isActive else { return }
                
                if timeRemaining > 0 {
                    timeRemaining -= 1
                }else{
                    isActive = false
                    timeRemaining = defaultTImeRemaining
                }
        })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
            
    }
}
