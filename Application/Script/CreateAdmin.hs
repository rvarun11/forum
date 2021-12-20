#!/usr/bin/env run-script
module Application.Script.CreateAdmin where

import Application.Script.Prelude

import qualified Data.Text.IO as TIO
import qualified Data.Text as T

run :: Script
run = do
    let username = "admin"
        password = "admin"
    
    hashed <- hashPassword password

    existingUser <- query @User 
                |> findMaybeBy #email username

    user <- case existingUser of
        Just user -> do
            putStrLn $ username ++ " already existing, skipping..."
            return user
        _ -> do
            putStrLn $ "Inserting " ++ username ++ "..."
            hashed <- hashPassword password
            
            user <- newRecord @User
                |> set #email username
                |> set #passwordHash hashed
                |> set #isAdmin True
                |> createRecord
            putStrLn $ "Inserted " ++ username
            return user
    
    return ()