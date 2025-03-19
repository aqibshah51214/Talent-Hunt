//
//  APIHelper.swift
//  first swift app
//
//  Created by Zahid on 10/09/2024.
//

import Foundation
import AVKit
//
struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String

    init?(withImage image: UIImage, forKey key: String, imageName name: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = name
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}

class APIMessage {
    var responseCode: Int = 404
    var responseData: Data?
    var responseMessage: String = "OK"
}

class APIHelper {
    private let baseURLString = "http://192.168.1.11/FYP1Api/api/"
   // private let baseURLString = "http://172.16.12.54/WebApplicationApp/api/"
    static let baseImageURLString = "http://192.168.1.11/FYP1Api/Images/"

    func getMethodCall(controllerName: String, actionName: String, completion: @escaping (APIMessage) -> Void) {
        let apiMessage = APIMessage()
        let completePath = "\(baseURLString)\(controllerName)/\(actionName)"

        guard let url = URL(string: completePath) else {
            apiMessage.responseCode = 209
            apiMessage.responseMessage = "Error: cannot create URL"
            completion(apiMessage)
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        let session = URLSession.shared
        session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                apiMessage.responseMessage = error.localizedDescription
                completion(apiMessage)
                return
            }

            guard let responseData = data, let httpResponse = response as? HTTPURLResponse else {
                apiMessage.responseMessage = "Error: did not receive data"
                completion(apiMessage)
                return
            }

            apiMessage.responseCode = httpResponse.statusCode
            apiMessage.responseData = responseData
            apiMessage.responseMessage = String(data: data!, encoding: .utf8) ?? "Unknown error"
            completion(apiMessage)
        }.resume()
    }

    func postMethodCall(controllerName: String, actionName: String, httpBody: Data?, completion: @escaping (APIMessage) -> Void) {
        let apiMessage = APIMessage()
        let completePath = "\(baseURLString)\(controllerName)/\(actionName)"

        guard let url = URL(string: completePath) else {
            apiMessage.responseCode = 209
            apiMessage.responseMessage = "Error: cannot create URL"
            completion(apiMessage)
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"

        if let body = httpBody {
            urlRequest.httpBody = body
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        } else {
            urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        }

        urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")

        let session = URLSession.shared
        session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                apiMessage.responseMessage = error.localizedDescription
                completion(apiMessage)
                return
            }

            guard let responseData = data, let httpResponse = response as? HTTPURLResponse else {
                apiMessage.responseMessage = "Error: did not receive data"
                completion(apiMessage)
                return
            }

            apiMessage.responseCode = httpResponse.statusCode
            apiMessage.responseData = responseData
            apiMessage.responseMessage = String(data: data!, encoding: .utf8) ?? "Unknown error"
            completion(apiMessage)
        }.resume()
    }

    func uploadImages(images: [Media], parameters: [String: String]?, endPoint: String, completion: @escaping (APIMessage) -> Void) {
        let apiMessage = APIMessage()
        let todoEndpoint = "\(baseURLString)\(endPoint)"

        guard let url = URL(string: todoEndpoint) else {
            apiMessage.responseCode = 209
            apiMessage.responseMessage = "Error: cannot create URL"
            completion(apiMessage)
            return
        }

        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        let boundary = generateBoundary()
        urlRequest.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        let dataBody = createDataBody(parameters: parameters, media: images, boundary: boundary)
        urlRequest.httpBody = dataBody

        let session = URLSession.shared
        session.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                apiMessage.responseMessage = error.localizedDescription
                completion(apiMessage)
                return
            }

            guard let responseData = data, let httpResponse = response as? HTTPURLResponse else {
                apiMessage.responseMessage = "Error: did not receive data"
                completion(apiMessage)
                return
            }

            apiMessage.responseCode = httpResponse.statusCode
            apiMessage.responseData = responseData
            apiMessage.responseMessage = String(data: data!, encoding: .utf8) ?? "Unknown error"
            completion(apiMessage)
        }.resume()
    }

    private func generateBoundary() -> String {
        return "Boundary-\(UUID().uuidString)"
    }

    private func createDataBody(parameters: [String: String]?, media: [Media]?, boundary: String) -> Data {
        let lineBreak = "\r\n"
        var body = Data()

        if let parameters = parameters {
            for (key, value) in parameters {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(key)\"\(lineBreak + lineBreak)")
                body.append("\(value + lineBreak)")
            }
        }

        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.filename)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }

        body.append("--\(boundary)--\(lineBreak)")
        return body
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}

