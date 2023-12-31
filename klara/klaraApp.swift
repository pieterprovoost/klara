import SwiftUI
import AVKit

struct AppMenu: View {

    @Binding public var isPlaying: Bool
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

    @State public var isPlaying = false

    var body: some Scene {
        MenuBarExtra {
            AppMenu(isPlaying: $isPlaying)
        } label: {
            isPlaying ? Image(systemName: "hifispeaker.fill") : Image(systemName: "hifispeaker")
        }
    }
}
