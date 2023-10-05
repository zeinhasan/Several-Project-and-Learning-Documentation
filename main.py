import os

def makeCommits(days):
    if days < 1:
        os.system('git push')
    else:
        dates = f"{days-1} days ago"
        with open('data.txt', 'a') as file:
            file.write(f'{dates} <- this was the commit for the day!!\n')
        # staging 
        os.system('git add data.txt')
        # commit 
        os.system('git commit --date="'+ dates +'" -m "Add Material!"')
        return days * makeCommits(days-1)

makeCommits(3) #
# Heheheheh Reforestation
# Reforestation12S
# Test1234
# Path: main.py
# Path: main.py
# Path: main.py