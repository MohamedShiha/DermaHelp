//
//  MachineLearningServerAPI.swift
//  DermaHelp
//
//  Created by Mohamed Shiha on 6/27/20.
//  Copyright © 2020 Mohamed Shiha. All rights reserved.
//

import UIKit

class MachineLearningServerAPI {
    
    typealias AnalysisCompletion = (Result<ClassifiedCancerClass,NSError>) -> Void
    
    private class func constructUrl() -> URL? {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "51.132.242.41"
        components.port = 5000
        components.path = "/predict"
        return components.url
    }
    
    class func analyze(image: UIImage?, _ completion: @escaping AnalysisCompletion) {
        
        guard let url = constructUrl() else { return }
        let boundary = generateBoundary()
        let params = [
            "key": "file"
        ]
        
        let body = multipartBody(parameters: params, image: image, boundary: boundary)
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        request.httpBody = body
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            guard error == nil else {
                completion(.failure(NSError()))
                return
            }
            
            guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                completion(.failure(NSError()))
                return
            }
            
            guard (200...299).contains(statusCode) else {
                completion(.failure(NSError()))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError()))
                return
            }
            
            if let classificationResult = try? JSONDecoder().decode(ClassifiedCancerClass.self, from: data) {
                completion(.success(classificationResult))
            }
        }.resume()
    }
    
    private class func generateBoundary() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    private class func multipartBody(parameters: [String:String]?, image: UIImage?, boundary: String) -> Data {
        var body = Data()
        let lineBreak = "\r\n"
        body.append("--\(boundary + lineBreak)") // body beginning
        if let params = parameters {
            for value in params.values {
                body.append("Content-Disposition:form-data; name=\"\(value)\"")
            }
        }
        if let image = image {
            body.append("; filename=\"image.png\"\(lineBreak)")
            body.append("Content-Type: \"content-type header\"\(lineBreak + lineBreak)")
            body.append(image.pngData() ?? Data())
            body.append(lineBreak)
        }
        body.append("--\(boundary)--\(lineBreak)") // body ending
        return body
    }
}
