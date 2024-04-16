# v0.2-sprint1 (2024-04-16)
## Sprint 1 of Study@ - finished!
This is the first official sprint iteration, some more improvements:

## Vertical prototype:
### Main screen:
- Changed the map
- Improved the top search bar, that allows the user to search locations on the Map, [**insert made with idk what**]
- Created location pins that point to the locations present on our database
- Limited the map to the Metropolitan Area of Porto
- Upon clicking a pin, a drawer shows up with more info

### Location screen
- Created a page for each location, with detailed info on the place

### Profile screen:
- Demo version for the profile
- Name, username and Biography
- History of past Reviews
- Medals 

### Database>
- JSON file and Firebase working

### UML
- Added detailed descriptions to our Domain Model

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