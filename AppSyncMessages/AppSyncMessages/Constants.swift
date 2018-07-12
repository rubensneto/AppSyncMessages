//
//  Constants.swift
//  AppSyncMessages
//
//  Created by Rubens Neto on 12/07/2018.
//  Copyright © 2018 T101. All rights reserved.
//

import Foundation
import AWSAppSync

let CognitoIdentityPoolId = "COGNITO_POOL_ID"
let CognitoIdentityRegion: AWSRegionType = .EUWest1
let AppSyncRegion: AWSRegionType = .EUWest1
let AppSyncEndpointURL: URL = URL(string: "https://srxfdcdltrgsviep2if6olhq44.appsync-api.eu-west-1.amazonaws.com/graphql")!
let database_name = "appsync-local-db"
let StaticAPIKey = "da2-c7s3ekv7kngbna6uql5ue7dxzm"


class APIKeyAuthProvider: AWSAPIKeyAuthProvider {
    func getAPIKey() -> String {
        // This function could dynamicall fetch the API Key if required and return it to AppSync client.
        return StaticAPIKey
    }
}
