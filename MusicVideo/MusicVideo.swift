//
//  MusicVideo.swift
//  MusicVideo
//
//  Created by Rex Jason Alobba on 27/6/16.
//  Copyright © 2016 Rex Jason Alobba. All rights reserved.
//

import Foundation

class Videos {
    
    var vRank = 0
    // Data Encapsulation
    
    fileprivate var _vName:String
    fileprivate var _vRights:String
    fileprivate var _vPrice:String
    fileprivate var _vImageUrl:String
    fileprivate var _vArtist:String
    fileprivate var _vVideoUrl:String
    fileprivate var _vImid:String
    fileprivate var _vGenre:String
    fileprivate var _vLinkToiTunes:String
    fileprivate var _vReleaseDte:String
    
    
    var vImageData: Data?
    
    //Make a getter
    
    var vName: String {
        return _vName
    }
    
    var vArtist: String {
        return _vArtist
    }
    
    var vImageUrl: String {
        return _vImageUrl
    }
    
    var vVideoUrl: String {
        return _vVideoUrl
    }
    
    var vRights: String {
        return _vRights
    }
    
    var vPrice: String {
        return _vPrice
    }
    
    var vImid: String {
        return _vImid
    }
    
    var vGenre: String {
        return _vGenre
    }
    
    var vLinkToiTunes: String {
        return _vLinkToiTunes
    }
    
    var vReleaseDte: String {
        return _vReleaseDte
    }
    
    init(data: JSONDictionary) {
        
        
        //If we do not initialize all properties we will get error message
        //Return from initializer without initializing all stored properties
        
        
        // Video name
        if let name = data["im:name"] as? JSONDictionary,
            let vName = name["label"] as? String {
            self._vName = vName
        }
        else
        {
            //You may not always get data back from the JSON - you may want to display message
            // element in the JSON is unexpected
            
            _vName = ""
        }

        // The Studio Name
        if let rights = data["rights"] as? JSONDictionary,
            let vRights = rights["label"] as? String {
            self._vRights = vRights
        }
        else
        {
            _vRights = ""
        }

        // Price of Video
        
        if let price = data["im:price"] as? JSONDictionary,
            let vPrice = price["label"] as? String {
            self._vPrice = vPrice
        }
        else
        {
            _vPrice = ""
        }
        
        
        
        // The Video Image
        if let img = data["im:image"] as? JSONArray,
            let image = img[2] as? JSONDictionary,
            let immage = image["label"] as? String {
            _vImageUrl = immage.replacingOccurrences(of: "100x100", with: "600x600")
        }
        else
        {
            _vImageUrl = ""
        }
        
        // The Artist Name
        if let artist = data["im:artist"] as? JSONDictionary,
            let vArtist = artist["label"] as? String {
            self._vArtist = vArtist
        }
        else
        {
            _vArtist = ""
        }

        
        
        //Video Url
        if let video = data["link"] as? JSONArray,
            let vUrl = video[1] as? JSONDictionary,
            let vHref = vUrl["attributes"] as? JSONDictionary,
            let vVideoUrl = vHref["href"] as? String {
            self._vVideoUrl = vVideoUrl
        }
        else
        {
            _vVideoUrl = ""
        }
        
        // The Artist ID for iTunes Search API
        if let imid = data["id"] as? JSONDictionary,
            let vid = imid["attributes"] as? JSONDictionary,
            let vImid = vid["im:id"] as? String {
            self._vImid = vImid
        }
        else
        {
            _vImid = ""
        }

        // The Genre
        if let genre = data["category"] as? JSONDictionary,
            let rel2 = genre["attributes"] as? JSONDictionary,
            let vGenre = rel2["term"] as? String {
            self._vGenre = vGenre
        }
        else
        {
            _vGenre = ""
        }
        
        
        // Video Link to iTunes
        if let release2 = data["id"] as? JSONDictionary,
            let vLinkToiTunes = release2["label"] as? String {
            self._vLinkToiTunes = vLinkToiTunes
        }
        else
        {
            _vLinkToiTunes = ""
        }
        
        
        
        // The Release Date
        if let release2 = data["im:releaseDate"] as? JSONDictionary,
            let rel2 = release2["attributes"] as? JSONDictionary,
            let vReleaseDte = rel2["label"] as? String {
            self._vReleaseDte = vReleaseDte
        }
        else
        {
            _vReleaseDte = ""
        }
        
        
    }
    
}
