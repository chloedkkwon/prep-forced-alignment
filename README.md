# Workflow for preparing the training data for forced alignment with kaldi (to be updated)

1. Create empty grid for each wav file using `create_empty_grid.m`.
2. Randomly select a train set to start manual labeling, using `choose_trainset.m`. The number of training data depends on the size of your data and amount of time you are willing to invest in manual labeling (I usually go for 10~20% of the total data, but this number varies by how complex the annotations are going to be). 
