import SwiftUI
import AVKit

class RadioStreamer: NSObject, ObservableObject {
    @Published var itemTitle: String = "Klara"
    
    public let player: AVPlayer?
    private let playerItem: AVPlayerItem?

    override init() {
        self.playerItem = AVPlayerItem(url: URL(string: "http://icecast.vrtcdn.be/klara-high.mp3")!)
        self.player = AVPlayer(playerItem: self.playerItem)
        super.init()

        let metaOutput = AVPlayerItemMetadataOutput(identifiers: nil)
        metaOutput.setDelegate(self, queue: DispatchQueue.main)
        self.playerItem?.add(metaOutput)
    }
}

extension RadioStreamer: AVPlayerItemMetadataOutputPushDelegate {
    func metadataOutput(_ output: AVPlayerItemMetadataOutput, didOutputTimedMetadataGroups groups: [AVTimedMetadataGroup], from track: AVPlayerItemTrack?) {

        for group in groups {
            for item in group.items {
                if let metadata = item as? AVMetadataItem, let metadataValue = metadata.value {
                    self.itemTitle = metadataValue as! String
                }
            }
        }
    }
}

struct AppMenu: View {
    @Binding public var isPlaying: Bool
    @StateObject var streamer: RadioStreamer = RadioStreamer()

    func quitApp() {
        NSApplication.shared.terminate(self)
    }

    func togglePlay() {
        if isPlaying {
            self.streamer.player?.pause()
        } else {
            self.streamer.player?.play()
        }
        isPlaying.toggle()
    }
    
    var body: some View {
        VStack {
            Text(self.streamer.itemTitle)
            Button(action: togglePlay, label: { Text(isPlaying ? "Pause" : "Play") })
            Button(action: quitApp, label: { Text("Quit") })
        }
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
