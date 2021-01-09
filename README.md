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
*	Company Size

![alt text](https://github.com/ahmed1salama/ds_glassdoor_salary_analysis_R/blob/master/graphs/postings_company_size.png "Postings by Company Size")

	*looks like that medium-large companies(501 - 1000, 1001 - 5000) are hiring the most
	

*	Company Size

![alt text]( "Postings by Company Type")

	*looks like that the private companies are hiring the most
	
	
*	Industry

![alt text]( "Postings by Company Industry")

	*from here we can see that the top most hiring industries are
		1. Biotech & Pharmaceuticals                 
		2. Insurance Carriers                         
		3. Computer Hardware & Software               
		4. IT Services                                
		5. Health Care Services & Hospitals           
		6. Enterprise Software & Network Solutions
			
			
*	State

![alt text]( "Postings by State")
![alt text]( "Postings by State Map")

	*from here we can see that there are very big opportunities in California, Massachusetts and New York
	
![alt text]( "Salary by State")
![alt text]( "Salary by State Map")

	*from here we can see that the top salaries are in California, Illinois and Washington D.C
	
	
*	Title

![alt text]( "Postings by Title")

	*the most wanted position is "Data Scientist"  followed by "Machine Learning Engineer"
	
![alt text]( "Salary by Title")
	
	*the top salaries are given to "Director"  followed by "Machine Learning Engineer"
	
![alt text]( "Postings of each position by Industry")

	*here we can see the top 3 positions in each industry"

![alt text]( "Postings of each position by state")

	*here we can see the top 3 positions in each state"
	
*	Skills

![alt text]( "Skills")

	*here we can see the percentage of wanted skills in the job postings
	
	
*	Company Age

![alt text]( "Company Age Distribution")

	*It seems like the Age is right skewed meaning that most of the companies in the data set are not old 
	
![alt text]( "Company Age - Salary relation")

	*There is no correlation between the Company Age and Salary
	

*	Job Description Length

![alt text]( "Description Length Distribution")

	*looks like the length of the job description is normally destributed
	
![alt text]( "Description Length - Salary relation")

	*seems like the length of the job description and the expected salary are not correlated
	

*	Number of Company Competitors

![alt text]( "Company Competitors Distribution")

	*looks like we got a "zero inflation" problem 
	*change number of competitors to a boolean "has competitor"
	
![alt text]( "Salary - Has Competitor relation")

	*from here we can see that the salary destribution for companies who have competitors and companies which do not have is almost the same  
	

*	Company Rating

![alt text]( "Company Raring Distribution")

	*looks like the rating is normally destriputed 
	
![alt text]( "Salary - Raring relation")

	*does not seem that the Rating is correlated with the Salary
	
	
	
	
	
	
	
	
	
	
	
	