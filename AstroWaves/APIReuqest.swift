import Foundation

class APIRequest {
    private let url = URL(string: "https://openet-api.org/raster/timeseries/point")!
    private let apiKey = "D2lMs9jCaeceREK1d63yAJ317PRXpPTTE5IYl25tLO8RIGEX7Ufy4cvEe5JI"

    func sendRequest(completion: @escaping (Result<Data, Error>) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("\(apiKey)", forHTTPHeaderField: "Authorization") // Ensure 'Bearer' is included

        // Get today's and yesterday's date formatted as strings
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd" // Format for API

        let today = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: today)!

        let formattedToday = formatter.string(from: today)
        let formattedYesterday = formatter.string(from: yesterday)

        // Prepare the request body with today's and yesterday's date
        let body: [String: Any] = [
            "date_range": [formattedYesterday, formattedToday], // Use yesterday's date and today's date
            "file_format": "JSON",
            "geometry": [-121.36322, 38.87626],
            "interval": "daily", // Interval set to daily
            "model": "Ensemble",
            "reference_et": "gridMET",
            "units": "mm",
            "variable": "ET"
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let data = data else {
                completion(.failure(NSError(domain: "DataError", code: -1, userInfo: nil)))
                return
            }
            completion(.success(data))
        }

        task.resume()
    }
}
