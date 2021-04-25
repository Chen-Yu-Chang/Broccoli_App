//
//  DatabaseManager.swift
//  FoodTracker
//
//  Created by 張晨鈺 on 2021/4/25.
//

import FirebaseDatabase

public class DatabaseManager {
    static let shared = DatabaseManager()
    
    private let database = Database.database().reference()
    //Mark: - Public
    
    //Check if username and email is available
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void){
        completion(true)
    }
    
    //insert new user data to database
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void){
        database.child(email.safeDatabaseKey()).setValue(["username":username]){ error, _ in
            if error == nil {
                completion(true)
                return
            }
            else{
                completion(false)
                return
            }
            
        }
    }
}
