# 2LEIC18T4 - Study@ Development Report
Documentation for the Study@ App from a high-level vision to low-level implementation decisions, a kind of Software Development Report, organized by type of activities: 

- [2LEIC18T4 - Study@ Development Report](#2leic18t4---study-development-report)
  - [Business Modeling](#business-modeling)
  - [Product Vision](#product-vision)
    - [Features and Assumptions](#features-and-assumptions)
    - [Elevator Pitch](#elevator-pitch)
  - [Requirements](#requirements)
    - [Domain Model](#domain-model)
  - [Architecture and Design](#architecture-and-design)
    - [Logical Architecture](#logical-architecture)
    - [Physical Architecture](#physical-architecture)
    - [Vertical Prototype](#vertical-prototype)
  - [Project Management](#project-management)
    - [Sprint 0 Board](#sprint-0-board)
    - [Sprint 1 Board](#sprint-1-board)
    - [Sprint 2 Board](#sprint-2-board)

```
This Project was Developed for ESOF 2023/2024 by:
- Afonso Pedro Maia de Castro 	                        (up202208026@up.pt)
- Clara Paulino Barros Sousa  	                        (up202207582@up.pt)
- João Vicente Pereira Mendes 	                        (up202208586@up.pt)
- Miguel Moita Caseira 	                                (up202207678@up.pt)
- Pedro Trindade Gonçalves Cadilhe Santos 	        (up202205900@up.pt)
- Rodrigo Dias Ferreira Loureiro de Sousa 	        (up202205751@up.pt)
```

## Business Modeling

The Goal that was proposed to us for this project was creating an app that aligns with the sustainable development goals [(SDGs)](https://www.eca.europa.eu/en/sustainable-development-goals) is a meaningful and impactful way to contribute to global challenges, in a FEUP-centric setting, that may be expanded to other faculties, possibly universities.
As such, we have arrived at a central theme:
- Finding Study Spots, which can be selected for their sustainability, energy efficiency, waste reduction and have interactive maps with user ratings and calendar events, for example.

## Product Vision
**If you are a student come and find your ideal study spot with our app, where productivity meets sustainability in every click!**


 

### Features and Assumptions
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////

### Elevator Pitch
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
## Requirements

### Domain Model

![domain_model.svg](out/docs/UML/domain_model/study@.svg)
> Note: The PlantUML code for UML can be found [here](docs/UML/domain_model.plantuml)
 
> Alternate [png](out/docs/UML/domain_model/study@.png)


In our app structure we have a User class, that contains in its atributes the main information related to all types of users: username and profile picture.

This later serves as the parent class to the Admin, Unregistered Student, and the Registered Student Classes, where this last one contains the rest of the information of the non-admin users that have created a account (password, email, university and reviews).
Related to the Registered Student, we have the Review class (with all the details of a review: rating and the comment), and related to the User, we have a GPS class with the latitude and longitude of the user's location.

Connected to the Review, the GPS and to the Registered Student (for the user's favourite locations), we then have an Location class where all the caracteristics of the various locations of the app are stored (name, image, adress, score, schedule, email, phone).

For last but not least, we have a Tag class (with a name atribute) connected to the Location, and an Achievement class with all its related info (name, time, date, rarity and level), linked to the user and also to the location.





 
## Architecture and Design

### Logical Architecture
![logical_architecture](out/docs/UML/logical_architecture/study@.svg)

> Note: The PlantUML code for UML can be found [here](docs/UML/logical_architecture.plantuml)
 
> Alternate [png](out/docs/UML/logical_architecture/study@.png)

### Physical Architecture
![physical_architecture](docs/pictures/uml/physical.png)

### UI Mockups
#### Starting Page
<img src="docs/UI_Mockups/Figma/Start Page.png" width="360" height="740">

#### Login Page
<img src="docs/UI_Mockups/Figma/Login.png" width="360" height="740">

#### Home Page
<img src="docs/UI_Mockups/Figma/Home.png" width="360" height="740">

#### Location Page
<img src="docs/UI_Mockups/Figma/Location.png" width="360" height="740">

#### Location Reviews Page
<img src="docs/UI_Mockups/Figma/Location Reviews.png" width="360" height="740">

#### Search Filters Page
<img src="docs/UI_Mockups/Figma/Search Filters.png" width="360" height="740">

#### Starred Page
<img src="docs/UI_Mockups/Figma/Starred.png" width="360" height="740">

#### Achievements Page
<img src="docs/UI_Mockups/Figma/Achievements.png" width="360" height="740">

#### Profile Page
<img src="docs/UI_Mockups/Figma/Profile.png" width="360" height="740">

### Vertical Prototype
#### Sprint 0
<img src="docs/screenshots/landing_page.png" width="360" height="740">
<img src="docs/screenshots/guest_popup.png" width="360" height="740">
<img src="docs/screenshots/home_screen_map.png" width="360" height="740">
<img src="docs/screenshots/other_navbar_pages.png" width="360" height="740">
<img src="docs/screenshots/debug_menu_drawer.png" width="360" height="740">
<img src="docs/screenshots/database_menu.png" width="360" height="740">
<img src="docs/screenshots/create_location.png" width="360" height="740">
<img src="docs/screenshots/item_details_popup.png" width="360" height="740">
<img src="docs/screenshots/edit_location.png" width="360" height="740">

#### Sprint 1
<img src="docs/screenshots/map1.jpg" width="360" height="740">
<img src="docs/screenshots/map2.jpg" width="360" height="740">
<img src="docs/screenshots/map3.jpg" width="360" height="740">
<img src="docs/screenshots/place.jpg" width="360" height="740">
<img src="docs/screenshots/profile.jpg" width="360" height="740">
<img src="docs/screenshots/debugsearch.jpeg" width="360" height="740">

#### Sprint 2
<img src="docs/screenshots/register.jpg" width="360" height="740">
<img src="docs/screenshots/login.jpg" width="360" height="740">
<img src="docs/screenshots/place2.jpg" width="360" height="740">
<img src="docs/screenshots/review_place.jpg" width="360" height="740">
<img src="docs/screenshots/starred.jpg" width="360" height="740">
<img src="docs/screenshots/discover@.jpg" width="360" height="740">
<img src="docs/screenshots/profile2.jpg" width="360" height="740">
<img src="docs/screenshots/edit_profile.jpg" width="360" height="740">
<img src="docs/screenshots/faculty.jpg" width="360" height="740">
<img src="docs/screenshots/guest.jpg" width="360" height="740">

## Project Management
In order to facilitate team communication and organization, [GitHub Projects](https://github.com/orgs/FEUP-LEIC-ES-2023-24/projects/74) was used to do the Project Management of this project.

The project has 7 columns: **User Stories**, **Product Backlog**, **Sprint Backlog**, **In progress**, **In Review**, **Done** and **Approved by PO**. It is important to note that, at the end of any iteration, the tasks that weren't finished are passed to the next one, so that the In Progress column appears empty at the end of every iteration.
### Sprint 0 Board

![sprint0_board](docs/pictures/sprint-boards/Sprint0.png)

For this Sprint, we organized all user stories that we have made in the **User Stories** Column and began sorting from there to the **Product Backlog**. We then moved the ones that we thought were essential to start off with to the **Sprint Backlog** to work with them. In the Sprint Backlog we also added the points that we had to deliver until the end of this sprint, such as UMLs and Prototypes.
All User Stories can be found [here](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T4/labels/user-story), highlighted with the tag `user-story`

### Sprint 1 Board
![sprint1_board](docs/pictures/sprint-boards/Sprint1.png)

For this First Official Sprint, we looked into the backlog and what we hadn´t managed to achieve and worked on getting what we got wrong corrected first. The Domain Modelling has its description and all the screenshots are here on this README.md. The first thing the backlog gave us was the map to improve. Next we moved on to the search bar and icons, as well as improving the database with tags for each location. We also started working on the profile page. Screenshots of the work can be found above, on Vertical Prototype, Sprint 1.

### Sprint 2 Board
![sprint2_board](docs/pictures/sprint-boards/Sprint2.png)

On this very important Sprint 2, we made lots of improvements. We created a fully functioning Starred Page, Place Page for each place and Reviews with some placeholders, Added a Share Location button and the most important, we can register and login into our own individual accounts, as well as edit them. Also, we have implemented accent colors corresponding to the user's faculty.

## Sprint Retrospective
### Sprint 1
This Sprint worked very well, we all worked on the project, doing our parts and helping each other on any problems that may have arised. The tasks were well defined and divided.
For the Second Sprint we need to improve two things:
 - Making a better Sprint Planning so we don't end the Sprint with items on the Sprint Backlog like this time;
 - Distributing the work along the two weeks and not just the last days, which happened this time, due to other circumstances that do not interfere with Sprint 2

One aspect that went wrong was the Search page in the Debug Menu. It went wrong because of our lack of Dart experience and the late start of this item.
The thing that went the best was changing the map and limiting it to just the Porto Area, as it was something that gave us some work but in the end works great.

### Sprint 2
This Sprint was focused on making functionality and aesthetics meet. Each person focused on a specific Page and converged to make them all work together seamlessly.
The Sprint went very well, we made lots of improvements and added a lot of functionalities, working well with the plans on the board.

For the third sprint:
- We need to finish the functionalities missing for the reviews and achievements.

One aspect that went very well was the amount of work that we got done, we are really proud of how the app is starting to look like, from the starred, to the sharing, everything is shaping up. 
The only thing that went wrong is that we are still stuck on the search page.