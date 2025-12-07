# 1635 Final Project

## App pitch
The idea for this application was to create a product similar to letterboxd. We wanted to create a system where users could have a profile of movies that they have seen and reviewed as well as have a lists of friends who could also see these reviews. We also wanted a section to list out your favorite movies.

The main feature of the app is to be able to search for any movie, click on it, and leave a review for that movie. This review will be included on your profile which your friends will be able to view.

You are also able to add and remove friends from your friends-list. When a friend is removed you will no longer see the review that they have left for you. 

### Screen shots of application

Home Page
![alt text](https://github.com/clifford04/1635-MPX/raw/main/homepage.png "Homepage")

Add/Remove Friends page  
![alt text](https://github.com/clifford04/1635-MPX/raw/main/friends.png "Homepage")

Reviews page  
![alt text](https://github.com/clifford04/1635-MPX/raw/main/review.png "Homepage")

Search page  
![alt text](https://github.com/clifford04/1635-MPX/raw/main/search.png "Homepage")

Writing Reviews page  
![alt text](https://github.com/clifford04/1635-MPX/raw/main/stars.png "Homepage")
## API Used

the API we used was omdbapi, we used this API as a way to search for movies and movie details


## MVVM Diagram

## Build Instructions and Dependencies

### Models
We have four models in our project: 
* MovieDetail
* Movie
* Review
* User
The role of all of these classes is to simply hold information based on their type. User holds user information, Movie holds cursory information on a movie, while MovieDetail holds extra information on a movie. The model classes have no other methods. 

### ViewModels
We have five ViewModels in our project:
* base
* home
* movie_detail
* movie_list
* user_profile
These ViewModels contain methods that utilize the Models as well as store lists of Models, such as a list containing all UserModels. These are also the only ways that new objects can be created; for example, movie_detail allows the user to create a new Review. The ViewModels are the only place the Models are accessed. The methods in ViewModel are also asynchronous.

### Views
We have four Views in our project:
* home
* movie_detail
* movie_list
* user_profile
Each View is directly connected to a ViewModel from which it gets its information. The methods in each of their respective ViewModels are called in the View. None of the Views access data structures directly; only through ViewModel methods - a View is simply a widget tree. Most importantly, the Views are unable to change any state, only read them.
## Video Link

https://youtu.be/ZWvK2mq8y2I


## Self and Peer evaluations 

### Connor 

### Aza 

