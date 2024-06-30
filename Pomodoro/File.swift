//
//  File.swift
//  Pomodoro
//
//  Created by James Staudte on 6/29/24.
//

import SwiftUI

struct ContentView: View {
    // Example date string
    let timeString = "1500"

    // DateFormatter to parse the time string
    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmm"
        return formatter
    }()

    // Convert the string to a date
    var parsedDate: Date? {
        return dateFormatter.date(from: timeString)
    }

    var body: some View {
        VStack {
            if let date = parsedDate {
                Text("Parsed date: \(date)")
            } else {
                Text("Invalid date string")
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
