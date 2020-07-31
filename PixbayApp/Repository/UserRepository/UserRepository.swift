//
//  UserRepository.swift
//  PixbayApp
//
//  Created by Tarek Abdallah on 7/31/20.
//  Copyright © 2020 Personal. All rights reserved.
//

import Foundation
import CoreData

struct UserRepository: UserRepositoryType {
    func create(user: User) {
        let coreDataUser = CDUser(context: PersistentStorage.shared.context)
        coreDataUser.email = user.email
        coreDataUser.password = user.password?.sha512()
        coreDataUser.age = user.age
        PersistentStorage.shared.saveContext()

    }

    func get(with email: String) -> User? {
        let fetchRequest = NSFetchRequest<CDUser>(entityName: "CDUser")
        let predicate = NSPredicate(format: "email==%@", email as CVarArg)

        fetchRequest.predicate = predicate
        do {
            guard let result = try PersistentStorage
                .shared
                .context
                .fetch(fetchRequest).first else { return nil }

            return result.convertToUser()

        } catch let error {
            debugPrint(error)
        }

        return nil

    }
}
