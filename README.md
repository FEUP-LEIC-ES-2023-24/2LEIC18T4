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

![domain_model.png](out/docs/UML/domain_model/study@.svg)
> Note: The PlantUML code for UML can be found [here](docs/UML/domain_model.plantuml)
 
> Alternate [png](out/docs/UML/domain_model/study@.png)
 
## Architecture and Design

### Logical Architecture
![logical_architecture](out/docs/UML/logical_architecture/study@.svg)

> Note: The PlantUML code for UML can be found [here](docs/UML/logical_architecture.plantuml)
 
> Alternate [png](out/docs/UML/logical_architecture/study@.png)

### Physical Architecture
![physical_architecture](docs/pictures/uml/physical.png)

### UI Mockups
#### Starting Page
<img src="docs/UI_Mockups/Figma/Start Page/Start Page-1.png" width="360" height="740">

#### Login Page
<img src="docs/UI_Mockups/Figma/Login/Login-1.png" width="360" height="740">

#### Home Page
<img src="docs/UI_Mockups/Figma/Home_Search 2/Home_Search 2-1.png" width="360" height="740">

#### Location Page
<img src="docs/UI_Mockups/Figma/Search Results 1/Search Results 1-1.png" width="360" height="740">

#### Location Reviews Page
<img src="docs/UI_Mockups/Figma/Search Result 2/Search Result 2-1.png" width="360" height="740">

#### Location Review Posting Page
<img src="docs/UI_Mockups/Figma/Search Results 3/Search Results 3-1.png" width="360" height="740">

#### Search Filters Page
<img src="docs/UI_Mockups/Figma/Search Filters 2/Search Filters 2-1.png" width="360" height="740">












### Vertical Prototype
<img src="docs/screenshots/landing_page.png" width="360" height="740">
<img src="docs/screenshots/guest_popup.png" width="360" height="740">
<img src="docs/screenshots/home_screen_map.png" width="360" height="740">
<img src="docs/screenshots/other_navbar_pages.png" width="360" height="740">
<img src="docs/screenshots/debug_menu_drawer.png" width="360" height="740">
<img src="docs/screenshots/database_menu.png" width="360" height="740">
<img src="docs/screenshots/create_location.png" width="360" height="740">
<img src="docs/screenshots/item_details_popup.png" width="360" height="740">
<img src="docs/screenshots/edit_location.png" width="360" height="740">

## Project Management
In order to facilitate team communication and organization, [GitHub Projects](https://github.com/orgs/FEUP-LEIC-ES-2023-24/projects/74) was used to do the Project Management of this project.

The project has 6 columns: **User Stories**, **Product Backlog**, **Sprint Backlog**, **In progress**, **In Review** and **Done**. It is important to note that, at the end of any iteration, the tasks that weren't finished are passed to the next one, so that the In Progress column appears empty at the end of every iteration.
### Sprint 0 Board

![sprint0_board](docs/pictures/sprint-boards/Sprint0.png)


For this Sprint, We organized all user stories that we have made in the **User Stories** Column and began sorting from there to the **Product Backlog**. We then moved the ones that we thought were essential to start off with to the **Sprint Backlog** to work with them. In the Sprint Backlog we also added the points that we had to deliver until the end of this sprint, such as UMLs and Prototypes.
All User Stories can be found [here](https://github.com/FEUP-LEIC-ES-2023-24/2LEIC18T4/labels/user-story), highlighted with the tag `user-story`
