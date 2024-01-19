//
//  ReviewAndRatingViewModel.swift
//  Carsharing Aggregator
//
//  Created by Viktoria Lobanova on 16.01.2024.
//

import Foundation

class ReviewAndRatingViewModel {
    weak var coordinator: ReviewAndRatingCordinator?
    private var reviewAndRatingService = ReviewAndRatingService.shared
    var modelCar: String = ""
    var onError: ((String) -> Void)?
    
    func saveReviewAndRating(rating: Int, comment: String) {
        sendReviewAndRating(rating: rating, comment: comment)
        deleteCarFromUserDefaults()
    }
    
    private func deleteCarFromUserDefaults() {
        let defaults = UserDefaults.standard
        defaults.removeObject(forKey: "car")
    }
    
    private func sendReviewAndRating(rating: Int, comment: String) {
        let reviewAndRatindModel = ReviewAndRating(rating: rating, comment: comment)
        let defaults = UserDefaults.standard
        if let savedCarData = defaults.dictionary(forKey: "car") {
            guard let idCar = savedCarData["id"] as? Int else { return }
            
            reviewAndRatingService.createReviewAndRating(
                with: reviewAndRatindModel,
                idCar: idCar) { result in
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        UIProgressHUD.show()
                        switch result {
                        case .success(let review):
                            print("Отзыв отправлен \(review)")
                        case .failure(let error):
                            UIProgressHUD.dismiss()
                            if case NetworkError.customError(let errorMessage) = error {
                                self.onError?(errorMessage)
                            } else {
                                switch error {
                                case .customError(let errorMessage):
                                    self.onError?(errorMessage)
                                    
                                case .httpStatusCode(let statusCode):
                                    let statusMessage = "Ошибка HTTP: \(statusCode)"
                                    self.onError?(statusMessage)
                                    
                                case .urlSessionError:
                                    self.onError?("Ошибка сессии URL")
                                    
                                case .urlRequestError(let error):
                                    self.onError?("Ошибка запроса: \(error.localizedDescription)")
                                    
                                case .decode:
                                    self.onError?("Ошибка декодирования данных")
                                    
                                default:
                                    self.onError?("Неизвестная ошибка")
                                }
                            }
                            
                        }
                    }
                }
        }
    }
}
