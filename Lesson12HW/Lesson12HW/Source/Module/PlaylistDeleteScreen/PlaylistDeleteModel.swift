//
//  PlaylistDeleteModel.swift
//  Lesson12HW
//

//

import Foundation

protocol PlaylistDeleteModelDelegate: AnyObject {
    func dataDidLoad() 
}

class PlaylistDeleteModel {
    var items: [Song] = []
    
    func loadData() {
        
        dataLoader.loadPlaylist { [weak self] playlist in
            
            self?.items = playlist?.songs ?? []
            self?.delegate?.dataDidLoad()
        }
    }
    weak var delegate: PlaylistDeleteModelDelegate?
    private let dataLoader = DataLoaderService()
}
