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
            timer?.cancel()
        }
    }

    func stop() {
        timer?.cancel()
    }

    func reset() {
        timer?.cancel()
        secondsLeft = 1500
    }
}
