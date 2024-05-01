# v0.3-sprint2 (2024-04-16)
## Sprint 2 of Study@ - finished!
Second sprint finished: an important update!

## Vertical prototype:
### Place page:
- Better tag placement (now with real tags)
- Place location, working hours and Discover@ medal status (mockup)
- Place rating and share button (mockup)
- Star and unstar a place (working, but soon will have a different look)
- Accents with the user's faculty color

### Starred page:
- Cards with the places you star
- Accents with the user's faculty color
- Scrollable
- Clicking on a card takes you to its' place page
- Gradient on cards for a more modern look and better readability

### Discover@ page:
- A mockup for the soon-to-be-added Discover@ achievement system
- Scrollable categories
- Medals grouped by city zones

### Profile page:
- Name, username, biography, faculty and profile picture can now be added
- Each faculty has a different color
- The color of the faculty you select will be the same of the app's color accents
- Sign out button added

### Edit profile page:
- Ability to select profile picture from gallery and save it
- Boxes for name, username and biography editing
- Faculty selection dropdown menu with names and colors

### Login and register:
- Login via email/password
- Login via Google
- A new user will have its name and username set as what's before the @ on their email, which can later be edited
- Guest login will have to be fixed soon - not working at the moment (you can login with teste@gmail.com / teste123, for testing, if you don't want to create an account)



---

# v0.2-sprint1 (2024-04-16)
## Sprint 1 of Study@ - finished!
This is the first official sprint iteration! We did some more improvements:

## Vertical prototype:
### Main screen:
- Changed the map tile provider, allowing for a better performance and smoother look
- Creation of the top search bar, that allows the user to search locations on the map. Note that, on this first version, your input has to be precise, as it only returns the API's first result
- Created interactive location pins that point to the locations present on our database
- Limited the map to the Metropolitan Area of Porto and limited the zoom in and out values
- Upon clicking a pin, a card shows up with more info
- Upon clicking the image of the card, location screen shows up
- Current location icon - upon allowing access to location - the app displays your current location on the map, with gyro heading

### Location screen:
- Created a page for each location, with detailed info on the place (still in development)

### Profile screen:
- Demo version for the profile (simple mockup)
- Name, username and Biography
- History of past Reviews
- Medals

### Database:
- More places added to the database, fully working on-the-cloud via Firebase
- A local version, in JSON format, is also available at the "database" folder

### UML
- Added detailed descriptions to our Domain Model

### Debug menu:
- The debug menu now has an in-development Search Page. This page will appear if an user wants to perform a more detailed search.

---
# v0.1-sprint0 (2024-03-27)

## Sprint 0 of Study@ - finished!
On this first version, there's not much to look at yet - but there are interesting things!


## Vertical prototype:
### Initial UI:
- Guest button (a mockup of how login/register will look like)
- Guest warning

### Main screen:
- The bottom navigation bar, crafted with the help of the GNav package
- How the map will look like, on the home screen

### Debug menu:

We've included a debug menu to start working on some vital features of the app. At the time of release, this menu will only be available to devs with registered account. You can open it by clicking on the top right icon at the home screen. A drawer will show up with the database option.

At this screen, we started the implementation of a Firebase Realtime Database, which will be a very important element in the app's data. A few sample locations are included.

- By tapping on the plus sign, you can create a new location (name, location, image link and type - powered by a dropdown menu button)
- On any existing element, if you click on its' icon, you can see its type, a button to edit the data and a button to remove the element from the database.


## Mockups

On our source code's README, there are some of the mockups we will base our final app on. You can already see some of the future features such as Discover@ (medal collection game), the account menu and the map search.

## UML Diagrams

Check our README file, UML diagrams of this iteration are available.

## Acceptance tests & User Stories

Both of these topics are also available on our README!