//
//  SongTableViewCell.swift
//  Albums
//
//  Created by Patrick Millet on 1/13/20.
//  Copyright © 2020 Patrick Millet. All rights reserved.
//

import UIKit

class SongTableViewCell: UITableViewCell {

   //MARK: - Outlets
    
    @IBOutlet weak var songTitleTextField: UITextField!
    @IBOutlet weak var songDurationTextField: UITextField!
    @IBOutlet weak var addSongButton: UIButton!
    
    
     // MARK: - Properties
        
        var song: Song? {
            didSet {
                updateViews()
            }
        }
        weak var delegate: SongTableViewCellDelegate?
    
    
    //MARK: - Actions
    @IBAction func addSongButtonTapped(_ sender: Any) {
        guard let title = songTitleTextField.text,
            let duration = songDurationTextField.text else { return }
        delegate?.addSong(with: title, duration: duration)
    }
    
        // MARK: - Private
        
        func updateViews() {
            if let song = song {
                addSongButton.isHidden = true

                songTitleTextField.text = song.name
                songDurationTextField.text = song.duration
            }
        }

        override func prepareForReuse() {
            songTitleTextField.text = ""
            songDurationTextField.text = ""
        }
    }

    protocol SongTableViewCellDelegate: AnyObject {
        func addSong(with title: String, duration: String)
    }
