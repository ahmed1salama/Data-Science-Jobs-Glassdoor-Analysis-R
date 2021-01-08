library(tidyverse)
library(usmap)
data = read_csv("data_cleaned.csv")

summary(data)


# it looks like we have numerical variables which are:
# 1- Salary_Estimate_Mean (dependent variable)
# 2- Company_Age = no. of years since this company was established
# 3- Desc_len = the length of the job description 
# 4- Num_comp =  no. of competitors of the company posting the job
# 5- Rating


# it looks like we have categorical data also which are:
# 1- Size
# 2- Type_of_ownership
# 3- Industry 4- Sector
# 5- Job_State
# 6- Job_simp = Job title 

# now let's do some EDA to see the effect of the several indep. variables on the dep. variable (Salary)
# also on the no. of job postings


############################################################################
############################################################################
############################################################################
#                           Numerical                                      #
############################################################################
############################################################################
############################################################################

############################################################################
# 1- Company_Age = no. of years since this company was established
############################################################################
data %>% 
  filter(Company_Age > 0) %>%
  ggplot(aes(Company_Age)) +
  geom_density() 

#It seems like the Age is right skewed meaning that most of the companies in the data set are not old 

data %>% 
  filter(Desc_Len > 0) %>%
  ggplot(aes(Company_Age, Salary_Estimate_Mean)) +
  geom_point() +
  geom_smooth()

# There is no correlation between the Company Age and Salary

############################################################################
# 2- Desc_len = the length of the job description 
############################################################################
data %>% 
  filter(Desc_Len > 0) %>%
  ggplot(aes(Desc_Len)) +
  geom_density() 

# looks like the length of the job description is normally destributed

data %>% 
  filter(Desc_Len > 0) %>%
  ggplot(aes(Desc_Len, Salary_Estimate_Mean)) +
  geom_point() +
  geom_smooth()

# seems like the length of the job description and the expected salary are not correlated


############################################################################
# 3- Num_comp =  no. of competitors of the company posting the job
############################################################################

data %>%
  ggplot(aes(Num_Comp)) +
  geom_histogram()

# looks like we got a "zero inflation" problem 
# a better visualization would be 
data %>% 
  mutate(has_competitor = Num_Comp > 0) %>%
  ggplot(aes(y = Salary_Estimate_Mean, x = has_competitor)) +
  geom_boxplot() 
# from here we can see that the salary destribution for companies who have competitors
# and companies which do not have is almost the same  


############################################################################
# 4- Rating
############################################################################
data %>%
  filter(Rating >= 0) %>%
  ggplot(aes(Rating)) +
  geom_histogram()

# looks like the rating is normally destriputed 

data %>%
  filter(Rating >= 0) %>%
  ggplot(aes(Rating, Salary_Estimate_Mean)) +
  geom_point() +
  geom_smooth()
# does not seem that the Rating is correlated with the Salary


############################################################################
############################################################################
############################################################################
#                           Categorical                                    #
############################################################################
############################################################################
############################################################################

############################################################################
# 1- Size
############################################################################
table(data$Size)
data = data %>%
          mutate(Size = case_when(Size == "-1" ~ "Unknow", TRUE ~ Size),
                 Size_fct = factor(Size, levels = c("Unknown", "1 to 50 employees", "51 to 200 employees",
                                                   "201 to 500 employees", "501 to 1000 employees",
                                                   "1001 to 5000 employees", "5001 to 10000 employees",
                                                   "10000+ employees")))
table(data$Size_fct)

data %>%
  count(Size_fct) %>%
  ggplot(aes(fct_rev(fct_reorder(Size_fct, n)), n)) +
  geom_col(fill = "deepskyblue4") +
  theme(axis.text.x = element_text(angle=90))

# looks like that medium-large companies(501 - 1000, 1001 - 5000) are hiring the most

############################################################################
# 2- Type of Ownership 
############################################################################

table(data$Type_of_ownership)

data %>%
  count(Type_of_ownership) %>%
  ggplot(aes(fct_rev(fct_reorder(Type_of_ownership, n)), n)) +
  geom_col(fill = "deepskyblue4") +
  theme(axis.text.x = element_text(angle=90))

# looks like that the private companies are hiring the most

############################################################################
# 3- Industry
############################################################################

table(data$Industry)

data %>%
  count(Industry) %>%
  arrange(desc(n)) %>%
  head()

data %>%
  count(Industry) %>%
  ggplot(aes(fct_rev(fct_reorder(Industry, n)), n)) +
  geom_col(fill = "deepskyblue4") +
  theme(axis.text.x = element_text(angle=90))

# from here we can see that the top most hiring industries are
# 1 Biotech & Pharmaceuticals                 
# 2 Insurance Carriers                         
# 3 Computer Hardware & Software               
# 4 IT Services                                
# 5 Health Care Services & Hospitals           
# 6 Enterprise Software & Network Solutions    


############################################################################
# 5- State
############################################################################

table(data$Job_State)

data %>%
  count(Job_State) %>%
  arrange(desc(n)) %>%
  head()

data %>%
  count(Job_State) %>%
  ggplot(aes(fct_rev(fct_reorder(Job_State, n)), n)) +
  geom_col(fill = "deepskyblue4") +
  theme(axis.text.x = element_text(angle=90))


plot_usmap(data = data%>%count(Job_State)%>% mutate(state = Job_State), values = "n", color = "deepskyblue4", labels = TRUE) + 
  scale_fill_continuous(low = "white", high = "darkblue", name = "Job Postings Count", label = scales::comma) 


# from here we can see that there are very big opportunities in California, Massachusetts and New York

data %>%
  group_by(Job_State) %>%
  summarise(mean = mean(Salary_Estimate_Mean)) %>%
  ggplot(aes(fct_rev(fct_reorder(Job_State, mean)), mean)) +
  geom_col(fill ="deepskyblue4") +
  theme(axis.text.x = element_text(angle=90))



plot_usmap(data = data %>%
             group_by(Job_State) %>%
             summarise(mean = mean(Salary_Estimate_Mean)) %>% mutate(state = Job_State), values = "mean", color = "deepskyblue4", labels = TRUE) + 
  scale_fill_continuous(low = "white", high = "darkblue", name = "Job Postings Count", label = scales::comma)

############################################################################
# 6- Title
############################################################################
table(data$Job_Simp)

data %>%
  count(Job_Simp) %>%
  ggplot(aes(fct_rev(fct_reorder(Job_Simp, n)), n)) +
  geom_col(fill = "deepskyblue4") +
  theme(axis.text.x = element_text(angle=90))


data %>%
  group_by(Job_Simp) %>%
  summarise(mean = mean(Salary_Estimate_Mean)) %>%
  ggplot(aes(fct_rev(fct_reorder(Job_Simp, mean)), mean)) +
  geom_col(fill ="deepskyblue4") +
  theme(axis.text.x = element_text(angle=90))

