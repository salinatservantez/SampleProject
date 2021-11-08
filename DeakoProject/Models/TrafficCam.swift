//
//  TrafficCam.swift
//  DeakoProject
//
//

import Foundation
import CoreLocation

// data structure for API data 
struct TrafficCam {

    var sid: String = ""
    var id: String = ""
    var position: Int = 0
    var created_at: Int = 0
    var created_meta: Int = 0
    var updated_at: Int = 0
    var updated_meta: Int = 0
    var meta: String = ""
    var ownershipcd: String = ""
    var cameralabel: String = ""
    var imageurl: String = ""
    var videourl: String = ""
    var weburl: String = ""
    var xpos: Double = 0.0
    var ypos: Double = 0.0
    var location: CLLocation = CLLocation()
    var plan_area: String = ""
    var census_tracts: String = ""
    var council_dist: String = ""
    var spdbeats: String = ""
    var zipcode: String = ""
}
