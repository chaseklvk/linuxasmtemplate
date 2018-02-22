Linux ASM Template
---
To take advantage of this repository for CS21, first fork it, then follow the instructions below.

On the newly created repo, find the green button that says "Clone or download." If you already have an SSH key setup, copy the text in the input, otherwise click "Use HTTPS" and copy the url. 

Next, create a project folder and run the following command:
```
git clone [paste the copied url from above]
```

When you want to start a new, clean project, create a new branch by running:
```
git checkout -b [project/branch name]
```

To switch branches run:
```
git checkout [branch name]
```

Any work done while on a branch remains only in that branch. For example, if I have a branch called 'project1' and I make changes to it, switching back to the master branch will reveal a clean project. If you want to create branches off of master, don't write any code in the master branch. To check your current branch run:
```
git branch
```

To save changes to your repository run:
```
git add . # Adds new/changed files 
git commit -m "[Some message summarizing the changes you've made]" 
git push origin [branch name] # This will push the changes to GitHub
```

