//
//  ProfileDetailViewModel.swift
//  AgileTV-MobileTest
//
//  Created by Enrique Carvalho on 08/02/25.
//

import UIKit
import Foundation

// This is the View Model for the ProfileDetail View Controller, this handles the API Calls logic
class ProfileDetailViewModel {
    
    // MARK: Variables
    var delegate: ProfileDetailViewModelDelegate?
    var user: User? {
        didSet {
            delegate?.updateViewWithUser()
        }
    }
    
    var fetchError: FetchError? = nil {
        didSet {
            guard let fetchError = fetchError else { return }
            delegate?.showErrorAlert(for: fetchError)
        }
    }
    
    // MARK: Initializer
    init(username: String) {
        fetchUserFromAPI(username: username)
    }
    
    // MARK: View Model functions
    // here we fetch a user and handle any errors in the process
    private func fetchUserFromAPI(username: String) {
        // define a url
        guard let url = URL(string: "https://api.github.com/users/\(username)") else {
            self.fetchError = FetchError.networkError
            return
        }
        
        // lets define a url request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        // here we create a task to retrieve data from the url
        URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.fetchError = .networkError
                }
                return
            }
            
            if let res = response as? HTTPURLResponse {
                if res.statusCode != 200 {
                    DispatchQueue.main.async {
                        self.fetchError = .notFound
                    }
                    return
                }
            }
            
            if let data = data {
                do {
                    try self.handleDataParsing(data)
                } catch {
                    DispatchQueue.main.async {
                        self.fetchError = .networkError
                    }
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            }
            
            }.resume()
    }
    
    // The following function handles the API call to fetch users repositories
    private func getUserRepos(endpoint: String, completion: @escaping ([Repository]?) -> Void) {
        // here we set a url
        guard let url = URL(string: endpoint) else { return completion(nil) }
        
        // here we set a request
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        
        // here we create a task to retrieve data from the url
        URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            if let error = error {
                print("Failed to load repositories: \(error.localizedDescription)")
            }
            
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let repositories = try decoder.decode([Repository].self, from: data)
                    completion(repositories)
                } catch {
                    print("Failed to parse repositories: \(error)")
                    completion(nil)
                }
            }
            
            }.resume()
    }
    
    private func getData(for url: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: url) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            completion(data)
            }.resume()
    }
    
    private func handleDataParsing(_ data: Data) throws {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let user = try decoder.decode(User.self, from: data)
        
        // here the json object is retrieved so we can get the user's image and the repos endpoint
        if let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] {
            /// this is where we fetch the user's image and set it to our user instance
            let avatarURL = jsonObject["avatar_url"] as? String
            let reposEndpoint = jsonObject["repos_url"] as? String
            
            let dispatchGroup = DispatchGroup() // I've defined a dispatch group so we only attribute the local user (the one from the function) to the outside user after having the avatar and repositories
            
            /// This function is called to retrive the user's image as data from the url provided by the API
            if let avatarURL = avatarURL{
                dispatchGroup.enter()
                self.getData(for: avatarURL) { data in
                    user.image = data
                    dispatchGroup.leave()
                }
            }
            
            if let reposEndpoint = reposEndpoint{
                dispatchGroup.enter()
                self.getUserRepos(endpoint: reposEndpoint) { repositories in
                    user.repositories = repositories
                }
                dispatchGroup.leave()
            }
            
            dispatchGroup.notify(queue: .main) {
                self.user = user
            }
        }
    }
}
