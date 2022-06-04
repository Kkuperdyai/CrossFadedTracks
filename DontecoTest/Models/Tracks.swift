//
//  Tracks.swift
//  DontecoTest
//
//  Created by Александр on 08.04.2022.
//

import Foundation

struct Track: Equatable {
    let name: String
    var indx: Int
}

var tracks: [Track] = [
                       Track(name: "1234", indx: 0),
                       Track(name: "12345", indx: 1)
                       ]

var playTracks: [Track?] = []
