import SwiftUI
import AVKit

struct AppMenu: View {

    @State private var isPlaying = false
    @State var player: AVPlayer?

    let radioURL = URL(string: "http://icecast.vrtcdn.be/klara-high.mp3")!

    func quitApp() {
        NSApplication.shared.terminate(self)
    }
    
    func togglePlay() {
        isPlaying.toggle()

        if self.player == nil {
            let playerItem = AVPlayerItem(url: radioURL)
            self.player = AVPlayer(playerItem: playerItem)
        }

        if isPlaying {
            self.player?.play()
        } else {
            self.player?.pause()
        }
    }

    var body: some View {
        Button(action: togglePlay, label: { Text(isPlaying ? "Pause Klara" : "Play Klara") }).padding()
        Button(action: quitApp, label: { Text("Quit") })
    }
}

@main
struct klaraApp: App {
    var body: some Scene {
        MenuBarExtra("UtilityApp", systemImage: "music.note") {
            AppMenu()
        }
    }
}
