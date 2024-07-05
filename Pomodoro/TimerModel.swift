import AudioToolbox
import Foundation
import Combine
import SwiftUI

class TimerModel: ObservableObject {
    @Published var secondsLeft: Int = 1500 //1500 // 25 minutes * 60 seconds
    
    var timer: AnyCancellable?
    
    
    var isStartedT = false
    var isWorkingT = true
    
    var ifStartWorkText: String {
        get {
            if isStartedT == true {
                if isWorkingT == true {
                    return "Working"
                } else {
                    return "Resting"
                }
            } else {
                return"Paused"
            }
        }
        
    }
    
    var ifStartWorkColor: Color {
        get {
            if isStartedT == true {
                if isWorkingT == true {
                    return .red
                } else {
                    return .blue
                }
            } else {
                return .black
            }
        }
        
    }
    
    
    func start() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { [weak self] _ in
            self?.tick()
        }
        isStartedT = true
    }
    
    func tick() {
        if secondsLeft > 0 {
            secondsLeft -= 1
        } else {
            playAlarm()

            if isWorkingT {
                resetRest()
            } else {
                reset()
            }
            start()
        }
    }
    
    func stop() {
        timer?.cancel()
        isStartedT = false
    }
    
    func reset() {
        timer?.cancel()
        isStartedT = false
        isWorkingT = true
        secondsLeft = 1500 //25 * 60
    }
    
    func resetRest() {
        timer?.cancel()
        isStartedT = false
        isWorkingT = false
        secondsLeft = 300 //5 * 60
    }
    
    func playAlarm() {
        // Predefined sound ID for a built-in alarm sound
        let systemSoundID: SystemSoundID = 1009
        AudioServicesPlaySystemSound(systemSoundID)

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)

//            .SensoryFeedback(.success)

    }
    //    func playAlarm(alrm: UInt32) {
    //        // Predefined sound ID for a built-in alarm sound
    //        let systemSoundID: SystemSoundID = alrm
    //        AudioServicesPlaySystemSound(systemSoundID)
    //    like 1008, 1009
    //    }
    
}



