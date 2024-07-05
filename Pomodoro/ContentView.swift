//
//  ContentView.swift
//  Pomodoro
//
//  Created by James Staudte on 6/29/24.
//

import SwiftUI

struct BlueButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding(20)
            .font(.largeTitle)
            .background(Color.blue.gradient)
            .foregroundStyle(.white)
            .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

struct ContentView: View {
    @ObservedObject var timerModel = TimerModel()
    @State private var isPressed = false
    @State private var isPressed2 = false
    @State private var isStartWork: String = "Paused"

    var body: some View {
        ZStack {

            Color(ifStartWork().color) // this might need to be Work/Rest/Stopped
                .ignoresSafeArea()

            VStack {
                Spacer()

                VStack {
                    Text("Start: \(timerModel.isStartedT)")
                    Text("Work: \(timerModel.isWorkingT)")

                    Spacer()

                    Text(ifStartWork().isSW)
                        .font(.largeTitle)

                    Spacer()

                    Text("\(timeString(time: timerModel.secondsLeft))")
                        .font(.system(size: 80))
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .padding()

                    HStack {
                        Button(timerModel.isStartedT ? "Stop" : "Start") {
                            timerModel.isStartedT.toggle()
                            if (timerModel.isStartedT) {
                                self.timerModel.start()
                            } else {
                                self.timerModel.stop()
                            }

                        }
                        .buttonStyle(BlueButton())
                        .shadow(color: .gray, radius: isPressed ? 0 : 5, x: 0, y: 0)
                        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
                            withAnimation {
                                isPressed = pressing
                            }
                        }, perform: {})


                        Spacer()
                            .frame(width: 40)

                        Button("Reset") {
                            timerModel.isStartedT = false
                        }
                        .buttonStyle(BlueButton())
                        .simultaneousGesture(LongPressGesture().onEnded { _ in
                            self.timerModel.resetRest()
                            timerModel.isWorkingT = false
                        })
                        .simultaneousGesture(TapGesture(count: 1).onEnded { _ in
                            self.timerModel.reset()
                            timerModel.isWorkingT = true
                        })
                        .shadow(color: .gray, radius: isPressed2 ? 0 : 5, x: 0, y: 0)
                        .onLongPressGesture(minimumDuration: .infinity, pressing: { pressing in
                            withAnimation {
                                isPressed2 = pressing
                            }
                        }, perform: {})

                    }
                    Spacer()


                }
                .frame(width: 300, height: 300)
                .padding(20)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25))

                Spacer()
                Spacer()

            }
            .onAppear {
                print(timerModel.secondsLeft)
                print(timerModel.secondsLeft % 2)
                selectProgram()
            }
        }
    }

    func ifStartWork() -> (isSW: String, color: Color) {
        if timerModel.isStartedT {
            if timerModel.isWorkingT == true {
                return ("Working", .red)
            } else {
                return ("Resting", .blue)
            }
        } else {
            return ("Paused", .black)
        }

    }

    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }

    func selectProgram() {
        if timerModel.secondsLeft == 0 {
            if timerModel.isWorkingT {
                self.timerModel.resetRest()
                self.timerModel.start()
                //change to 5 min and start
            } else {
                self.timerModel.reset()
                self.timerModel.start()
                //change to 25 and start
            }
            timerModel.isWorkingT.toggle()

            //check which thing is running
            //then reset to the opposite
            //?change the color?
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



//import SwiftUI
//
//struct ContxentView: View {
//    @State var startDate = Date.now
//    @State var timeElapsed: Int = 25*60
//
//    // 1
//    @State var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//
//
//    var body: some View {
////        timer.upstream.connect().cancel()
//
//        VStack {
//            Text("\(timeElapsed)")
//                .onReceive(timer) { firedDate in
//                    print("timer fired")
//                    timeElapsed = timeElapsed-1
//                }
//            Button("Stop") {
//                timer.upstream.connect().cancel()
//            }
//            Button("Start") {
//                timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
//            }
//            Button("Reset") {
//            timeElapsed = 25*60
//                timer.upstream.connect().cancel()
//            }
//        }
//        .font(.largeTitle)
//    }
//}

//struct ContentView: View {
//    @State var timeRemaining = 25*60
////    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
////    let timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(fireTimer), userInfo: nil, repeats: true)
//
////    let timer: Text.DateStyle
//    let min25 = Date.now.addingTimeInterval(25*60)
//
//    var body: some View {
//
//        VStack {
//            Spacer()
//            var runCount = 0
//
//            let timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
//                print("Timer fired! \(runCount)")
//                runCount += 1
//            }
//
////            // make a timer style, automatically updating
////            Text(min25, style: .timer)
////                .font(.largeTitle)
////
////            Spacer()
////
//            Button("Stop") {
//                print("Button tapped!")
//                timer.invalidate()
//            }
//            .buttonStyle(.borderedProminent)
//            .font(.largeTitle)
//
//            Button("Start") {
//                print("Button tapped!")
//                timer.up
//            }
//            .buttonStyle(.borderedProminent)
//            .font(.largeTitle)
//
//
//            Spacer()
////            var runCount = 0
////
////            Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
////                print("Timer fired!")
////                runCount += 1
////
////                if runCount == 3 {
////                    timer.invalidate()
////                }
////            }
////
////            Spacer()
////
////            Text("\(timeRemaining)")
//////                .onReceive(timer) { _ in
////                    if timeRemaining > 0 {
////                        timeRemaining -= 1
////                    }
////                }
////            Spacer()
//
//       }
//
//
//     }
//
////@objc func fireTimer() {
////    print("Timer fired!")
////}
//}

#Preview {
    ContentView()
}
