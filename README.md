# Pothole-Detection
A Mobile Application for detecting Potholes in cooperation with the Oregon Department of Transportation (ODOT).  This application uses the built in IOS library *CoreMotion* to measure accelerometer data.  The spikes in change of accelerometer data trigger pothole detection.  The UI includes a map that displays all potholes that have been detected before, ODOT user login, car sensitivity settings, and dark mode/light mode capabilities.  The backend is built with a Firebase Database with overlaying Ruby.

![](pothole-gif.gif)


# To clone repository to Desktop
```
cd ~/Desktop

mkdir PotholeApp && cd PotholeApp

git clone git@github.com:[username]/Pothole-Detection.git
```

This clones using your git SSH Key
If you need help creating this key, refer to it [here:](https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

```
cd Pothole-Detection
```

And you should be in!
`ls` to make sure the files are there and also `git branch` to make sure you are on main





# Workflow
Our default branch is called  **main** instead of ~~master~~. 
*DO NOT be directly committ on main.*  This will disrupt workflow for any conflicting changes we might make.
In order to implement new features, we should work on branches for each feature.  Branches should be named with the specific feature they implement.
For instance if I wanted to add a new clock, I would call the branch `new-clock`


### BEFORE YOU START ADDING CODE

##### To make a new branch:

```
git branch [name-of-branch]

git checkout [name-of-branch]
```

##### To set remote tracking from main of new branch:

```
git --set-upstream origin [name-of-branch]
```

##### To check if there any updates to the main branch:

```
git pull origin main
```

### AFTER YOU ADD CODE

We want to commit code frequently so we can see each others changes.

##### To commit code:

```
git status

git add [specific files that were changed/added]

git commit -m "[DESCRIPTIVE COMMIT MESSAGE]"

git push
```


### OPENING A PULL REQUEST

After you have made your first commit from a branch, a pull request can be opened.  Open this only when you think your branch is almost ready to be merged.
DO NOT merge a pull request on your own.  Ask for someone else to review the code and merge it themselves.  This will allow us to keep each other accountable.


# To Work on Project

For this project, you will need the most updated version of *Xcode* in order to contribute.  This is an IDE that allows users to run the application on a simulator locally on their desktop, or directly on an IOS device.

### TO NAVIGATE TO THE FILES TO EDIT
```
cd ~/Desktop/PotholeApp/Pothole-Detection
open .
```
From there, the file system will open presenting you with a list of files at the root of the repository.  While the files are actually located in the *Insert where they are here* directory, you will need to open up the workspace version to edit in Xcode.  The proper file to open is title `Pothole-Detection.xcworkspace`

Once that is open, you can make changes to the files.  To run, press the arrow in the top left corner.
