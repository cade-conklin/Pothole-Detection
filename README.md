# Pothole-Detection
A Mobile Application for detecting Potholes with other capabilities soon to come.

# To clone repository to Desktop
cd ~/Desktop

mkdir PotholeApp && cd PotholeApp

git clone git@github.com:[username]/Pothole-Detection.git


This clones using your git SSH Key
If you need help creating this key, refer to it here https://docs.github.com/en/free-pro-team@latest/github/authenticating-to-github/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent

cd Pothole-Detection

...

And you should be in!
"ls" to make sure the files are there and also "git status" to make sure you are on main"


# Workflow
Our default branch is called "main" instead of "master".  Git has elected to name that as the default as a part of their new update.
We should NOT be directly committing on main.  This will disrupt workflow for any conflicting changes we might make.
In order to implement new features, we should work on branches for each feature.  Branches should be named with the specific feature they implement.
For instance if I wanted to add a new clock, I would call the branch "new-clock"


BEFORE YOU START ADDING CODE

To make a new branch:


git branch [name-of-branch]

git checkout [name-of-branch]


To set remote tracking branch of new branch:


git --set-upstream origin [name-of-branch]


To check if there any updates to the main branch:


git pull origin main


AFTER YOU ADD CODE
We want to commit code frequently so we can see each others changes.

To commit code:


git status

git add .

git commit -m "[SPECIFIC COMMIT MESSAGE]"

git push


OPENING A PULL REQUEST
After you have made your first commit from a branch, a pull request can be opened.  Open this only when you think your branch is almost ready to be merged.
DO NOT merge a pull request on your own.  Ask for someone else to review the code and merge it themselves.  This will allow us to keep each other accountable.
