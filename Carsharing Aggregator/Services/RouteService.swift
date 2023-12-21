//
//  LocationService.swift
//  Carsharing Aggregator
//
//  Created by Дарья Шишмакова on 20.12.2023.
//

import Foundation
import CoreLocation
import YandexMapsMobile

final class RouteService {
    
    // MARK: - Properties
    private let manager = CLLocationManager()
    private let pedestrianRouter: YMKPedestrianRouter = YMKTransport.sharedInstance().createPedestrianRouter()
    private var pedestrianSession: YMKMasstransitSummarySession?
    
    // MARK: - Methods
    func calculateTime(carCoordinates: Coordinates, completion: @escaping (String) -> Void) {
        guard let currentPosition = self.manager.location else { return }
        let currentPoint = YMKPoint(
            latitude: currentPosition.coordinate.latitude,
            longitude: currentPosition.coordinate.longitude
        )
        
        let requestPoints = [
            YMKRequestPoint(
                point: YMKPoint(
                    latitude: Double(carCoordinates.latitude),
                    longitude: Double(carCoordinates.longitude)),
                type: .waypoint,
                pointContext: nil,
                drivingArrivalPointId: nil),
            YMKRequestPoint(
                point: currentPoint,
                type: .waypoint,
                pointContext: nil,
                drivingArrivalPointId: nil
             )
        ]
        
        let pedestrianRouteHandler = { (pedestrianRoutes: [YMKMasstransitSummary]?, error: Error?) -> Void in
            if let error {
                print(error)
                completion("Время недоступно")
            }

            guard let pedestrianRoutes else { return }
            guard let routeTime = pedestrianRoutes.first?.weight.time.text else { return }
            completion(routeTime)
        }
        
        pedestrianSession = pedestrianRouter.requestRoutesSummary(
            with: requestPoints,
            timeOptions: YMKTimeOptions(),
            summaryHandler: pedestrianRouteHandler
        )
    }
}
