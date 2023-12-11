# Film-IOS-Project
## IOS Project on Films and their detailed descriptions. 

## Used API:
* Kinopoisk API

## Databases used:
* Firebase
* Coredata

# App structure:
* ## Register and Login views.
  #### Login with "forgot password" ability, registered users are saved to Firebase database.
  <img src="https://github.com/TimurZheksimbaev/Film-IOS-Project/blob/main/Registration.png" alt="image" width="234" height="504">
  <img src="https://github.com/TimurZheksimbaev/Film-IOS-Project/blob/main/Login.png" alt="image" width="234" height="504">
* ## Main page
  #### Popular films are showed and stored in Collection View and additional Table View of films when pressing button
  <img src="https://github.com/TimurZheksimbaev/Film-IOS-Project/blob/main/Main.png" alt="image" width="234" height="504">
  <img src="https://github.com/TimurZheksimbaev/Film-IOS-Project/blob/main/All.png" alt="image" width="234" height="504">
* ## Search
  #### You can search film, get random film and get film by filters.
  <img src="https://github.com/TimurZheksimbaev/Film-IOS-Project/blob/main/Search.png" alt="image" width="234" height="504">
* ## Liked films
  #### Stores liked films in Core Data, when you press star button in Detailed View of film.
  <img src="https://github.com/TimurZheksimbaev/Film-IOS-Project/blob/main/LIked.png" alt="image" width="234" height="504">
* ## Profile
  #### You are able to choose your profile picture, see your email and delete account.
  <img src="https://github.com/TimurZheksimbaev/Film-IOS-Project/blob/main/Profile.png" alt="image" width="234" height="504">
* ## Film Details
  #### Shows detailed description of film, allows to visit Kinopoisk website using Webkit.
  

## Networking:
* #### All films are taken from Unofficial Kinopoisk API, on Main page for Collection View with popular films i make network call to this API and for Table View i store them in CoreData for faster access

