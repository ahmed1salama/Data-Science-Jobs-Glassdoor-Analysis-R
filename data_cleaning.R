library(tidyverse)

data = read_csv("glassdoor_jobs.csv")

str(data)

# removing the unecessary index field 
data = data %>%
  select(- X1)


# changing spaces in column names into _
names = names(data)
names_cleaned = sapply(names, str_replace_all, pattern = " ", replacement = "_")
names_cleaned
names(data) = names_cleaned
names(data)


# summary of the data
str(data)
summary(data)


# 1- salary needs to be a number through some cleaning by removing the "k", "$", etc.
data = data %>%
          filter(Salary_Estimate != "-1") %>%
          mutate(
                 Salary_Cleaned = str_to_lower(str_replace_all(Salary_Estimate," ","")),
                 Salary_Cleaned = str_replace_all(Salary_Cleaned, "\\(glassdoorest.\\)|\\(employerest.\\)|(\\$)|(k)|(employerprovidedsalary:)|(perhour)|", ""),
                 Salary_Cleaned = str_split(Salary_Cleaned, "-"),
                 Salary_Cleaned_Min = as.numeric(sapply(Salary_Cleaned, "[[", 1)),
                 Salary_Cleaned_Max = as.numeric(sapply(Salary_Cleaned, "[[", 2)),
                 Salary_Estimate_Mean = (Salary_Cleaned_Min + Salary_Cleaned_Max) / 2) 

# 2- company name needs to be text only by removing the extra "rating"
data = data %>%
          mutate(
                Company_txt = case_when(Rating > 0 ~ str_sub(Company_Name, end = -4), TRUE ~ Company_Name),
                Company_txt = str_replace_all(Company_txt, "[\r\n]" , ""))


# 3- extract the state from the location into a separate field
data = data %>%
          mutate(
                Job_State = str_trim(sapply(str_split(Location, ","), "[[", 2), side = "left"),
                Same_State = as.numeric(Location == Headquarters))

# 4- create company age field from founded field
data = data %>%
          mutate(
                Company_Age = case_when(Founded > 0 ~ 2020 - Founded, TRUE ~ Founded)
          )
# 5- extract skills info from job description "python", "R", etc.
# Python 
data = data %>%
          mutate(
                Python = case_when(str_detect(str_to_lower(Job_Description), fixed("python")) ~ 1, TRUE ~ 0)
          )

# R 
data = data %>%
  mutate(
    R = case_when(str_detect(str_to_lower(Job_Description), fixed("r studio")) | str_detect(str_to_lower(Job_Description), fixed("r-studio")) ~ 1, TRUE ~ 0)
  )

# spark
data = data %>%
  mutate(
    spark = case_when(str_detect(str_to_lower(Job_Description), fixed("spark")) ~ 1, TRUE ~ 0)
  )

# aws
data = data %>%
  mutate(
    aws = case_when(str_detect(str_to_lower(Job_Description), fixed("aws")) ~ 1, TRUE ~ 0)
  )

# excel
data = data %>%
  mutate(
    excel = case_when(str_detect(str_to_lower(Job_Description), fixed("excel")) ~ 1, TRUE ~ 0)
  )

# removing the un necessary Salary_Cleaned column
data = data %>% 
          select(- Salary_Cleaned)

# writing data into data_cleaned.csv
write_csv(data, "data_cleaned.csv")
