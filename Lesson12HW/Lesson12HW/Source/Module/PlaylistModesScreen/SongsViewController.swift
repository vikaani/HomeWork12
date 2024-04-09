//
//  SongsViewController.swift
//  Lesson12HW
//
//  Created by Vika on 09.04.2024.
//

import UIKit

class SongsViewController: NSObject, UITableViewDataSource, UITableViewDelegate {
    private let songs: [Song]
    
    init(songs: [Song]) {
        self.songs = songs
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "MainPlaylistCell", for: indexPath) as? MainPlaylistCell else {
            assertionFailure()
            return UITableViewCell()
        }
        
        let item = songs[indexPath.row]
        
        cell.authorLabel.text = item.author
        cell.songTitleLabel.text = item.songTitle
        cell.albumTitle.text = item.albumTitle
        cell.genreLabel.text = item.genre
        
        return cell
    }
}
