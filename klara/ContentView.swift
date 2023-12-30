import SwiftUI
import AVKit

struct ContentView: View {

    @State private var isPlaying = false
    @State var player: AVPlayer?

    let radioURL = URL(string: "http://icecast.vrtcdn.be/klara-high.mp3")!

    var body: some View {
        VStack {
            Button(action: {
                self.togglePlay()
            }) {
                Text(isPlaying ? "Stop" : "Play")
            }
        }
        .padding()
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
}
