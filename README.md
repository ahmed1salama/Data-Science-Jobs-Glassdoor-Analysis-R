# Glassdoor Data Science Job Postings Analysis

This project analyzes 1000 job postings scrapped from glassdoor related to data science field to give some insights about the most wanted job position,
the most wanted skills, Salary ranges for each posititon, etc.


## Languages & Tools Used 

* R
* r-studio


## Libraries Used

* tidyverse
* usmap
* scales


## Data source credit

https://github.com/PlayingNumbers/ds_salary_proj/blob/master/glassdoor_jobs.csv


## Data Cleaning

* Categorical data:
	1. Size
	2. Type_of_ownership
	3. Industry 
	4. Sector
	5. Job_State
	6. Job_simp = Job title 
	7. Skills 
	
* Numerical data:
	1. Salary_Estimate_Mean (dependent variable)
	2. Company_Age = no. of years since this company was established
	3. Desc_len = the length of the job description 
	4. Num_comp =  no. of competitors of the company posting the job
	5. Rating

*	Changed column names 
*	Removed rows without salary 
*	Calculated Salary mean out of salary[by removing characters like "$" and getting the mean from the range taking into account hourly paid jobs]
*	Made a new column for company name [by removing the company rate from the company name]
*	Made a new column for state [by extracting the state from the location]
*	Made a new column for company age [by calculating the company age from the founded variable]
*	Added a column for if the job was at the company’s headquarters 
*	Made columns for if different skills were listed in the job description:
    * Python  
    * R  
    * Excel  
    * AWS  
    * Spark
	* SQL
*	Column for simplified job title and Seniority 
*	Column for description length 
*	Column for number of company’s competitors 


## Findings
1- Company Size
