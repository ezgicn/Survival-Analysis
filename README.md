## Survival-Analysis
#Cohort Study_Cox Regression

Library Loading: The necessary libraries are loaded at the beginning of the script.

Data Loading and Exploration: The lung dataset is loaded and its structure is checked with head() and str() to understand the variables present.

Survival Object Creation: A survival object is created using the Surv() function, which combines the survival time and the event status.

Cox Proportional Hazards Model: A Cox model is fitted to the data, examining how age, sex, and performance status (ph.karno) affect survival.

Hazard Ratios and Confidence Intervals: Hazard ratios and 95% confidence intervals are calculated and printed in a tidy data frame.

Survival Curves: Survival curves are created for different sexes, and a plot is generated using ggsurvplot(). The risk table and p-values are also included.

Log-Rank Test: A log-rank test compares survival between different sexes, and the result is printed.

Detailed Plot: An optional detailed survival plot is created with custom aesthetics, which shows survival probabilities and a risk table, enhancing the visualization.
