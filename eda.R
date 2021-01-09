library(tidyverse)
library(usmap)
library(scales)
library(png)
data = read_csv("data_cleaned.csv")

summary(data)


# it looks like we have categorical data which are:
# 1- Size
# 2- Type_of_ownership
# 3- Industry 4- Sector
# 5- Job_State
# 6- Job_simp = Job title 
# 7- Skills 


# it looks like we have numerical variables which are:
# 1- Salary_Estimate_Mean (dependent variable)
# 2- Company_Age = no. of years since this company was established
# 3- Desc_len = the length of the job description 
# 4- Num_comp =  no. of competitors of the company posting the job
# 5- Rating




# now let's do some EDA to see the effect of the several indep. variables on the dep. variable (Salary)
# also on the no. of job postings



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
  filter(Size_fct != "NA") %>%
  ggplot(aes(fct_rev(fct_reorder(Size_fct, n)), n)) +
  geom_col(fill = "deepskyblue4") +
  theme(axis.text.x = element_text(angle=90)) + 
  ggtitle("Number of job postings Vs. Company size") +
  labs(y= "Job Postings", x = "Company Size") +
  theme(plot.title = element_text(hjust = 0.5)) 
dev.copy(png, file="postings_company_size.png", width=480, height=480)
dev.off()

# looks like that medium-large companies(501 - 1000, 1001 - 5000) are hiring the most

############################################################################
# 2- Type of Ownership 
############################################################################

table(data$Type_of_ownership)

data %>%
  count(Type_of_ownership) %>%
  filter(Type_of_ownership != "-1") %>%
  ggplot(aes(fct_rev(fct_reorder(Type_of_ownership, n)), n)) +
  geom_col(fill = "deepskyblue4") +
  theme(axis.text.x = element_text(angle=90)) + 
  ggtitle("Number of job postings Vs. Company type") +
  labs(y= "Job Postings", x = "Company Type") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("postings_company_type.png")

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
  filter(Industry != -1) %>%
  ggplot(aes(fct_rev(fct_reorder(Industry, n)), n)) +
  geom_col(fill = "deepskyblue4") +
  theme(axis.text.x = element_text(angle=90)) + 
  ggtitle("Number of job postings Vs. Industry") +
  labs(y= "Job Postings", x = "Industry") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("postings_industry.png")
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
  theme(axis.text.x = element_text(angle=90)) + 
  ggtitle("Number of job postings Vs. State") +
  labs(y= "Job Postings", x = "State") +
  theme(plot.title = element_text(hjust = 0.5))+
  ggsave("postings_state.png")


plot_usmap(data = data%>%count(Job_State)%>% mutate(state = Job_State), values = "n", color = "deepskyblue4", labels = TRUE) + 
  scale_fill_continuous(low = "white", high = "darkblue", name = "Job Postings Count", label = scales::comma) + 
  ggtitle("Number of job postings Vs. State") +
  theme(plot.title = element_text(hjust = 0.5))+
  ggsave("postings_state_map.png")


# from here we can see that there are very big opportunities in California, Massachusetts and New York

data %>%
  group_by(Job_State) %>%
  summarise(mean = mean(Salary_Estimate_Mean)) %>%
  ggplot(aes(fct_rev(fct_reorder(Job_State, mean)), mean)) +
  geom_col(fill ="deepskyblue4") +
  theme(axis.text.x = element_text(angle=90)) + 
  ggtitle("Salary Estimate Vs. State") +
  labs(y= "Salary", x = "State") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("salary_state.png")



plot_usmap(data = data %>%
             group_by(Job_State) %>%
             summarise(mean = mean(Salary_Estimate_Mean)) %>% mutate(state = Job_State), values = "mean", color = "deepskyblue4", labels = TRUE) + 
  scale_fill_continuous(low = "white", high = "darkblue", name = "Salary", label = scales::comma) + 
  ggtitle("Salary Estimate Vs. State") +
  theme(plot.title = element_text(hjust = 0.5)) + 
  ggsave("salary_state_map.png")




############################################################################
# 6- Title
############################################################################
table(data$Job_Simp)

data %>%
  count(Job_Simp) %>%
  filter(Job_Simp != "NA") %>%
  ggplot(aes(fct_rev(fct_reorder(Job_Simp, n)), n)) +
  geom_col(fill = "deepskyblue4") +
  theme(axis.text.x = element_text(angle=90)) + 
  ggtitle("Number of job postings Vs. Title") +
  labs(y= "Job Postings", x = "Title") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("postings_title.png")


data %>%
  group_by(Job_Simp) %>%
  summarise(mean = mean(Salary_Estimate_Mean)) %>%
  filter(Job_Simp != "NA") %>%
  ggplot(aes(fct_rev(fct_reorder(Job_Simp, mean)), mean)) +
  geom_col(fill ="deepskyblue4") +
  theme(axis.text.x = element_text(angle=90)) + 
  ggtitle("Salary Estimate Vs. Title") +
  labs(y= "Salary", x = "Title") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("salary_title.png")


# top wanted positions in each Industry
data %>%
  filter(Industry != "NA" , Industry != "-1", Job_Simp != "NA") %>%
  group_by(Industry, Job_Simp) %>%
  summarize(n = n()) %>%
  arrange(desc(n)) %>%
  top_n(3) %>%
  ungroup() %>%
  ggplot(aes(fct_rev(fct_reorder(Industry, n)), n, fill = Job_Simp)) +
  geom_bar(stat = "Identity") +
  theme(axis.text.x = element_text(angle=90)) + 
  ggtitle("Top wanted positions in each industry") +
  labs(y= "Job Postings", x = "Industry", fill = "Title") +
  theme(plot.title = element_text(hjust = 0.5))+
  ggsave("postings_industry_positions.png")



# top wanted positions in each State
data %>%
  filter(Job_State != "NA" , Job_State != "-1", Job_Simp != "NA") %>%
  group_by(Job_State, Job_Simp) %>%
  summarize(n = n()) %>%
  arrange(desc(n)) %>%
  top_n(3) %>%
  ungroup() %>%
  ggplot(aes(fct_rev(fct_reorder(Job_State, n)), n, fill = Job_Simp)) +
  geom_bar(stat = "Identity") +
  theme(axis.text.x = element_text(angle=90)) + 
  ggtitle("Top wanted positions in each state") +
  labs(y= "Job Postings", x = "State", fill = "Title") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("postings_state_positions.png")


############################################################################
# 6- skills 
############################################################################

data = data %>%
  mutate(sql = case_when(str_detect(str_to_lower(Job_Description), "sql") ~ 1, TRUE ~ 0))
python_percent = sum(data$Python) / nrow(data)
R_percent = sum(data$R) / nrow(data)
aws_percent = sum(data$aws) / nrow(data)
spark_percent = sum(data$spark) / nrow(data)
excel_percent = sum(data$excel) / nrow(data)
sql_percent = sum(data$sql) / nrow(data)

skills_percent = c(python_percent, R_percent, aws_percent, spark_percent, excel_percent, sql_percent)
skills_name = c("python", "R", "aws", "spark", "excel", "sql")
skills = data.frame(skills_name, skills_percent)
skills %>%
  ggplot(aes(fct_rev(fct_reorder(skills_name, skills_percent)) , skills_percent)) +
  geom_bar(fill = "deepskyblue4", stat = "identity") + 
  scale_y_continuous(labels = percent) +
  geom_text(aes(label= round(skills_percent * 100, 2))) + 
  ggtitle("Percentage of skills required") +
  labs(y= "Percntage", x = "Skill") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("skills.png")


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
  geom_density() +
  ggtitle("Company age distribution") +
  labs(y= "Density", x = "Company Age") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("company_age_dist.png")

#It seems like the Age is right skewed meaning that most of the companies in the data set are not old 

data %>% 
  filter(Desc_Len > 0) %>%
  ggplot(aes(Company_Age, Salary_Estimate_Mean)) +
  geom_point() +
  geom_smooth() +
  ggtitle("Salary Vs. Company age") +
  labs(y= "Salary", x = "Company Age") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("salary_company_age.png")

# There is no correlation between the Company Age and Salary

############################################################################
# 2- Desc_len = the length of the job description 
############################################################################
data %>% 
  filter(Desc_Len > 0) %>%
  ggplot(aes(Desc_Len)) +
  geom_density() +
  ggtitle("Job description length destribution") +
  labs(y= "Density", x = "Description Length") +
  theme(plot.title = element_text(hjust = 0.5))+
  ggsave("description_len_dist.png")

# looks like the length of the job description is normally destributed

data %>% 
  filter(Desc_Len > 0) %>%
  ggplot(aes(Desc_Len, Salary_Estimate_Mean)) +
  geom_point() +
  geom_smooth() +
  ggtitle("Salary Vs. Description length") +
  labs(y= "Salary", x = "Description Length") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("salary_description_length.png")

# seems like the length of the job description and the expected salary are not correlated


############################################################################
# 3- Num_comp =  no. of competitors of the company posting the job
############################################################################

data %>%
  ggplot(aes(Num_Comp)) +
  geom_histogram() +
  ggtitle("Company competitors destribution") +
  labs(y= "Count", x = "Number of Competitors") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("competitors_dist.png")

# looks like we got a "zero inflation" problem 
# a better visualization would be 
data %>% 
  mutate(has_competitor = Num_Comp > 0) %>%
  ggplot(aes(y = Salary_Estimate_Mean, x = has_competitor)) +
  geom_boxplot() +
  ggtitle("Salary Vs. Has competitors") +
  labs(y= "Salary", x = "Has competitors") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("salary_has_competitor.png")
# from here we can see that the salary destribution for companies who have competitors
# and companies which do not have is almost the same  


############################################################################
# 4- Rating
############################################################################
data %>%
  filter(Rating >= 0) %>%
  ggplot(aes(Rating)) +
  geom_density() +
  ggtitle("Rating Destribution") +
  labs(y= "Density", x = "Rating") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("rating_dist.png")

# looks like the rating is normally destriputed 

data %>%
  filter(Rating >= 0) %>%
  ggplot(aes(Rating, Salary_Estimate_Mean)) +
  geom_point() +
  geom_smooth() +
  ggtitle("Salary Vs. Rating") +
  labs(y= "Salary", x = "Rating") +
  theme(plot.title = element_text(hjust = 0.5)) +
  ggsave("salary_rating.png")
# does not seem that the Rating is correlated with the Salary



            