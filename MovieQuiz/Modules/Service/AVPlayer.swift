import Foundation
import AVFoundation


class Player {
    private var quizPlayer: AVAudioPlayer!
    private var playeritem: AVPlayerItem!
    private var backgroundMusicPlayer: Player!
    
    func playBackgroundMusic() {
        guard let musicURL = Bundle.main.url(forResource: "MarchaImperial", withExtension: "mp3") else { return }
        
        let playeritem = AVPlayerItem(url: musicURL)
        let backgroundMusicPlayer = Player(playerItem: playeritem)
        backgroundMusicPlayer.volume = 0.1
        backgroundMusicPlayer.play()
        
        backgroundMusicPlayer.addPeriodicTimeObserver(forInterval: CMTimeMakeWithSeconds(1, preferredTimescale: 1), queue: nil) { [weak self] (time) in
            guard let songDuration = self?.playeritem.duration.seconds else { return }
            
            let percent = time.seconds / songDuration
            self?.homeView?.soundBarView.soundSlider.setValue(Float(percent), animated: true)
        }
    }
}
