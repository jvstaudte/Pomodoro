import AudioToolbox
import Foundation
import Combine

class TimerModel: ObservableObject {
    @Published var secondsLeft: Int = 1500 // 25 minutes * 60 seconds

    var timer: AnyCancellable?

    func start() {
        timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect().sink { [weak self] _ in
            self?.tick()
        }
    }

    func tick() {
        if secondsLeft > 0 {
            secondsLeft -= 1
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
        secondsLeft = 25 * 60
    }

    func resetRest() {
        timer?.cancel()
        secondsLeft = 5 * 60
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
