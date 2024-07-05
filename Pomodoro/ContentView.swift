//
//  ContentView.swift
//  Pomodoro
//
//  Created by James Staudte on 6/29/24.
//

//still needs haptic
//and set times back to default

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
    @State private var randomNumber = 0.0


    @ObservedObject var timerModel = TimerModel()
    @State private var isPressed = false
    @State private var isPressed2 = false

    var body: some View {
        ZStack {

            Color(timerModel.ifStartWorkColor)
                .ignoresSafeArea()

            VStack {
                Spacer()

                VStack {
                    Spacer()

                    Text(timerModel.ifStartWorkText)
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
                .padding(10)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 25))

                Spacer()
                Spacer()

            }
        }
    }
//        .sensoryFeedback(.success, trigger: randomNumber)
}


func timeString(time: Int) -> String {
    let minutes = time / 60
    let seconds = time % 60
    return String(format: "%02d:%02d", minutes, seconds)
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


#Preview {
    ContentView()
}
