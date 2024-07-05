import AudioToolbox
import Foundation
import Combine

class TimerModel: ObservableObject {
    @Published var secondsLeft: Int = 8 //1500 // 25 minutes * 60 seconds

    var timer: AnyCancellable?


    var isStartedT = false
    var isWorkingT = true

    func start() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { [weak self] _ in
            self?.tick()
        }
    }

    func tick() {
        if secondsLeft > 0 {
            secondsLeft -= 1
//            print(isWorking)
        } else {
            playAlarm()
            timer?.cancel()
        }
    }

    func stop() {
        timer?.cancel()
    }

    func reset() {
        timer?.cancel()
        secondsLeft = 8 //25 * 60
    }

    func resetRest() {
        timer?.cancel()
        secondsLeft = 4 //5 * 60
    }

    func playAlarm() {
        // Predefined sound ID for a built-in alarm sound
        let systemSoundID: SystemSoundID = 1009
        AudioServicesPlaySystemSound(systemSoundID)
    }
    //    func playAlarm(alrm: UInt32) {
    //        // Predefined sound ID for a built-in alarm sound
    //        let systemSoundID: SystemSoundID = alrm
    //        AudioServicesPlaySystemSound(systemSoundID)
    //    like 1008, 1009
    //    }

}
