//
//  AlbumDetailTableViewController.swift
//  Albums
//
//  Created by Patrick Millet on 1/13/20.
//  Copyright © 2020 Patrick Millet. All rights reserved.
//

import UIKit

class AlbumDetailTableViewController: UITableViewController {

    //MARK: - Outlets
    
    @IBOutlet weak var albumNameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var genresTextField: UITextField!
    @IBOutlet weak var coverTextField: UITextField!
    
    // MARK: - Properties
        
        struct PropertyKeys {
            static let cell = "SongCell"
        }
        var albumController: AlbumController?
        var album: Album? {
            didSet {
                updateViews()
            }
        }
        var tempSongs: [Song] = []

        // MARK: - Lifecycle Methods
        override func viewDidLoad() {
            super.viewDidLoad()

            updateViews()
        }

        // MARK: - Actions
        
        @IBAction func saveTapped(_ sender: Any) {

            guard let name = albumNameTextField.text,
                let artist = artistTextField.text,
                let genres = genresTextField.text,
                let coverArt = coverTextField.text,
                let artURL = URL(string: coverArt) else { return }

            if let album = album {
                albumController?.update(album: album, id: album.id, name: name, artist: artist, genres: [genres], coverArt: [artURL], songs: tempSongs)
            } else {
                albumController?.createAlbum(id: UUID().uuidString, name: name, artist: artist, genres: [genres], coverArt: [artURL], songs: tempSongs)
            }

            self.navigationController?.popViewController(animated: true)
        }

        // MARK: - Private
        
        private func updateViews() {
            guard isViewLoaded else { return }
            if let album = album {
                albumNameTextField.text = album.name
                artistTextField.text = album.artist
                genresTextField.text = album.genres.joined(separator: ", ")
                coverTextField.text = "\(album.coverArt)"
                tempSongs = album.songs
            }
        }

        // MARK: - Table view data source
        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return tempSongs.count + 1
        }


        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.cell, for: indexPath) as? SongTableViewCell else { return UITableViewCell() }

            cell.delegate = self
            if indexPath.row == 0 {
                cell.song = nil
            } else {
                cell.song = tempSongs[indexPath.row - 1]
            }

            return cell
        }

        override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            if indexPath.row == 0 {
                return 140
            } else {
                return 100
            }
        }
    }


extension AlbumDetailTableViewController: SongTableViewCellDelegate {
    func addSong(with title: String, duration: String) {
        let song = Song(id: UUID().uuidString, name: title, duration: duration)
        tempSongs.append(song)
        tableView.reloadData()
        tableView.scrollToRow(at: [0, tempSongs.count], at: .bottom, animated: true)
    }
}
