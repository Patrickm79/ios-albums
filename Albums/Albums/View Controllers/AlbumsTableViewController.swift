//
//  AlbumsTableViewController.swift
//  Albums
//
//  Created by Patrick Millet on 1/13/20.
//  Copyright © 2020 Patrick Millet. All rights reserved.
//

import UIKit

class AlbumsTableViewController: UITableViewController {

     // MARK: - Properties
        
        let albumController = AlbumController()

        struct PropertyKeys {
            static let cell = "AlbumCell"
            static let addSegue = "ShowAddAlbumSegue"
            static let detailSegue = "ShowAlbumDetailSegue"
        }

        // MARK: - Lifecycle Methods
        override func viewDidLoad() {
            super.viewDidLoad()

            albumController.getAlbums { error in
                if let error = error {
                    print(error)
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            tableView.reloadData()
        }

        override func viewDidAppear(_ animated: Bool) {
            super.viewDidAppear(animated)
            tableView.reloadData()
        }

        // MARK: - Table view data source


        override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            // #warning Incomplete implementation, return the number of rows
            return albumController.albums.count
        }


        override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.cell, for: indexPath)

            cell.textLabel?.text = albumController.albums[indexPath.row].name
            cell.detailTextLabel?.text = albumController.albums[indexPath.row].artist

            return cell
        }
    
        // MARK: - Navigation
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == PropertyKeys.detailSegue {
                guard let detailVC = segue.destination as? AlbumDetailTableViewController,
                    let indexPath = tableView.indexPathForSelectedRow else { return }
                detailVC.albumController = albumController
                detailVC.album = albumController.albums[indexPath.row]
            } else if segue.identifier == PropertyKeys.addSegue {
                guard let addVC = segue.destination as? AlbumDetailTableViewController else { return }
                addVC.albumController = albumController
            }
        }
    }
