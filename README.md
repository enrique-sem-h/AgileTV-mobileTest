# AgileTV-mobileTest
This is a repository created for storing the Mobile Engineering Test for **AgileTV Junior iOS Developer Role**  
**Candidate**: Enrique de Lima Carvalho

> **_Note_**: I was unable to use Swift 3.x because my computer runs macOS Sequoia, and Swift 3 was discontinued around Mojave. I attempted using a VM but that would have compromised my delivery deadline.

# Architecture
This project demonstrates an MVVM-based iOS application that fetches user profile data from the GitHub remote API and displays it in a table.

---
## Requirements
- **Xcode Version**: 14.x or higher
- **Swift Version**: 4.x
- **Minimum iOS Version**: 13.0
---

This project uses the Model-View-ViewModel `(MVVM)` architecture to ensure a clear separation of concerns:
- **Model**: Defines the data structures (e.g., user profile data).
- **View**: Responsible for the layout and UI elements displayed to the user.
- **ViewModel**: Handles the business logic and coordinates data fetching from the API, preparing it for display in the View.

### Protocol Communication

Communication between the View, ViewModel, and ViewController is handled through **Swift protocols**. This approach promotes loose coupling and better testability.

### Project Details

#### File Structure
- `HomeScreen` - This is the home view according to the challenge.
  - `View` - This is where the main view for the home screen is located.
  - `HomeScreenViewController` - Used to build the screen elements overall based on the view.
  
- `ProfileDetail` - The view used for displaying the API response for the user. 
  - `View` - This is where the main view for the profile detail is located.
    - `Components` - Had to create this folder to store the view's table view cell and its setup.
  - `ViewModel` - Used mostly for API calling and handling its response/errors.
  - `ProfileDetailViewController` - Used to build the screen elements overall based on the view and the view model.
  
- `Utilities`

* PS: I've decided to leave view controllers out of folders, because each view structure only has one, besides they are supposed to be a container for their views and ui functions  

### Contact
For any questions, feel free to reach out:
- Email: (carvalhoenrique33@gmail.com)
- LinkedIn: [Enrique Carvalho](https://www.linkedin.com/in/enrique-carvalho-bb075827a/)
