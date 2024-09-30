# Load necessary libraries
library(dplyr)      # For data manipulation
library(survival)   # For survival analysis
library(survminer)  # For visualizing survival curves
library(ggplot2)    # For additional plotting (if needed)

# Load the example dataset
data(lung)

# View the first few rows of the dataset
head(lung)

# Check the structure of the dataset
str(lung)

# Create a survival object
surv_object <- Surv(time = lung$time, event = lung$status)

# Fit a Cox proportional hazards model
cox_model <- coxph(surv_object ~ age + sex + ph.karno, data = lung)

# Summary of the Cox model
summary(cox_model)

# Calculate the hazard ratios and 95% confidence intervals
hazard_ratios <- exp(coef(cox_model))
conf_intervals <- exp(confint(cox_model))
results <- data.frame(
  Variable = names(hazard_ratios),
  Hazard_Ratio = hazard_ratios,
  CI_Lower = conf_intervals[, 1],
  CI_Upper = conf_intervals[, 2]
)

# Print the hazard ratios and confidence intervals
print(results)

# Create survival curves for the two sexes
surv_fit_sex <- survfit(cox_model, newdata = data.frame(sex = c(1, 2), age = 60, ph.karno = 90))

# Plot the survival curves by sex
ggsurv_plot <- ggsurvplot(surv_fit_sex,
                          data = lung,
                          risk.table = TRUE,           # Add risk table
                          pval = TRUE,                 # Show p-value
                          conf.int = TRUE,             # Show confidence intervals
                          title = "Survival Curves by Sex",
                          xlab = "Time (days)",
                          ylab = "Survival Probability",
                          palette = c("#E7B800", "#2E9FDF")) # Custom colors

# Print the survival plot
print(ggsurv_plot)

# Perform a log-rank test to compare survival between sexes
log_rank_test <- survdiff(surv_object ~ sex, data = lung)
cat("Log-rank test result:\n")
print(log_rank_test)

# Optional: Create a more detailed plot showing the survival curves with custom aesthetics
ggsurv_plot_detailed <- ggsurvplot(surv_fit_sex,
                                   data = lung,
                                   risk.table = TRUE,
                                   pval = TRUE,
                                   conf.int = TRUE,
                                   title = "Survival Curves by Sex with Risk Table",
                                   xlab = "Time (days)",
                                   ylab = "Survival Probability",
                                   palette = c("#E7B800", "#2E9FDF"),
                                   legend.title = "Sex",
                                   legend.labs = c("Male", "Female"),
                                   ggtheme = theme_minimal())

# Print the detailed survival plot
print(ggsurv_plot_detailed)
