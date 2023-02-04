use projectportfolio;

##creating covid deaths table
CREATE TABLE `c_deaths` (
  `iso_code` text,
  `continent` text,
  `location` text,
  `population` bigint DEFAULT NULL,
  `date2` text,
  `total_cases` int DEFAULT NULL,
  `new_cases` int DEFAULT NULL,
  `new_cases_smoothed` text,
  `total_deaths` text,
  `new_deaths` text,
  `new_deaths_smoothed` text,
  `total_cases_per_million` double DEFAULT NULL,
  `new_cases_per_million` double DEFAULT NULL,
  `new_cases_smoothed_per_million` text,
  `total_deaths_per_million` text,
  `new_deaths_per_million` text,
  `new_deaths_smoothed_per_million` text,
  `reproduction_rate` text,
  `icu_patients` text,
  `icu_patients_per_million` text,
  `hosp_patients` text,
  `hosp_patients_per_million` text,
  `weekly_icu_admissions` text,
  `weekly_icu_admissions_per_million` text,
  `weekly_hosp_admissions` text,
  `weekly_hosp_admissions_per_million` text,
  `date4` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
load data infile 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\covid_deaths.csv' into table c_deaths FIELDS TERMINATED BY ',' enclosed by '"' LINES TERMINATED BY '\n' 
(iso_code,
  continent,  location,
  @population ,date2 ,
  @total_cases ,
  @new_cases ,
  new_cases_smoothed ,
  @total_deaths,
  new_deaths ,
  new_deaths_smoothed ,
  @total_cases_per_million,
  @new_cases_per_million ,
  new_cases_smoothed_per_million ,
  total_deaths_per_million,
  new_deaths_per_million,
  new_deaths_smoothed_per_million ,
  reproduction_rate,
  icu_patients ,
  icu_patients_per_million,
  hosp_patients,
  hosp_patients_per_million,
  weekly_icu_admissions ,
  weekly_icu_admissions_per_million ,
weekly_hosp_admissions ,
  weekly_hosp_admissions_per_million )
set new_cases = if(@new_cases='', null, @new_cases),total_cases_per_million= if(@total_cases_per_million='', null, @total_cases_per_million),new_cases_per_million= if(@new_cases_per_million='', null, @new_cases_per_million),total_cases= if(@total_cases='', null, @total_cases),population= if(@population='', null, @population),total_deaths=if(@total_deaths='',null,@total_deaths); ;

##deleted few rows to reduce the file size as query took too long to process
DELETE FROM c_deaths WHERE continent IN ('Africa','Oceania','North America','South America');
DELETE FROM c_deaths WHERE location IN ('North America','South America','Africa','Oceania');

ALTER TABLE c_deaths MODIFY COLUMN continent text NULL DEFAULT null;

##adding another column of date with date as a datatype cuz the previous date2 column was in text datatype 
alter table c_deaths
add column date4 date;
update c_deaths
set date4= STR_TO_DATE(date2, "%d-%m-%Y");

## creating covid vaccination table
CREATE TABLE `c_vacc` (
  `iso_code` text,
  `continent` text,
  `location` text,
  `date2` text,
  `total_tests` text,
  `new_tests` text,
  `total_tests_per_thousand` text,
  `new_tests_per_thousand` text,
  `new_tests_smoothed` text,
  `new_tests_smoothed_per_thousand` text,
  `positive_rate` text,
  `tests_per_case` text,
  `tests_units` text,
  `total_vaccinations` text,
  `people_vaccinated` text,
  `people_fully_vaccinated` text,
  `total_boosters` text,
  `new_vaccinations` text,
  `new_vaccinations_smoothed` text,
  `total_vaccinations_per_hundred` text,
  `people_vaccinated_per_hundred` text,
  `people_fully_vaccinated_per_hundred` text,
  `total_boosters_per_hundred` text,
  `new_vaccinations_smoothed_per_million` text,
  `new_people_vaccinated_smoothed` text,
  `new_people_vaccinated_smoothed_per_hundred` text,
  `stringency_index` double(10,4) DEFAULT NULL,
  `population_density` double(10,4) DEFAULT NULL,
  `median_age` double DEFAULT NULL,
  `aged_65_older` double DEFAULT NULL,
  `aged_70_older` double DEFAULT NULL,
  `gdp_per_capita` double DEFAULT NULL,
  `extreme_poverty` text,
  `cardiovasc_death_rate` double(10,4) DEFAULT NULL,
  `diabetes_prevalence` double DEFAULT NULL,
  `female_smokers` text,
  `male_smokers` text,
  `handwashing_facilities` double(10,4) DEFAULT NULL,
  `hospital_beds_per_thousand` double DEFAULT NULL,
  `life_expectancy` double DEFAULT NULL,
  `human_development_index` double DEFAULT NULL,
  `excess_mortality_cumulative_absolute` text,
  `excess_mortality_cumulative` text,
  `excess_mortality` text,
  `excess_mortality_cumulative_per_million` text,
  `date3` date DEFAULT NULL,
  `date4` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

load data infile 'D:\\Data Analytics\\SQL youtube\\covid_vacc.csv' into table c_vacc FIELDS TERMINATED BY ',' enclosed by '"' LINES TERMINATED BY '\n'
(iso_code,
  continent,
  location,
  date2,
  total_tests,
  @new_tests,
  total_tests_per_thousand,
  new_tests_per_thousand,
  new_tests_smoothed,
  new_tests_smoothed_per_thousand,
  positive_rate,
  tests_per_case,
  tests_units,
  total_vaccinations,
people_vaccinated,
  people_fully_vaccinated,
  total_boosters,
  new_vaccinations,
  new_vaccinations_smoothed,
  total_vaccinations_per_hundred,
  people_vaccinated_per_hundred,
  people_fully_vaccinated_per_hundred,
  total_boosters_per_hundred,
  new_vaccinations_smoothed_per_million,
  new_people_vaccinated_smoothed,
  new_people_vaccinated_smoothed_per_hundred,
  @stringency_index,
  @population_density,
  @median_age,
  @aged_65_older,
  @aged_70_older,
  @gdp_per_capita,
  extreme_poverty,
  @cardiovasc_death_rate,
  @diabetes_prevalence,
  female_smokers,
  male_smokers,
  @handwashing_facilities,
  @hospital_beds_per_thousand,
  @life_expectancy,
  @human_development_index,
  @excess_mortality_cumulative_absolute,
  excess_mortality_cumulative,
  excess_mortality,
  excess_mortality_cumulative_per_million)
  set new_tests = if(@new_tests='', null, @new_tests),stringency_index = if(@stringency_index='', null, @stringency_index), cardiovasc_death_rate= if(@cardiovasc_death_rate='', null, @cardiovasc_death_rate),handwashing_facilities= if(@handwashing_facilities='', null, @handwashing_facilities),population_density= if(@population_density='', null, @population_density),median_age= if(@median_age='', null, @median_age),aged_65_older= if(@aged_65_older='', null, @aged_65_older),aged_70_older= if(@aged_70_older='', null, @aged_70_older),
  gdp_per_capita=if(@gdp_per_capita='', null, @gdp_per_capita),diabetes_prevalence=if(@diabetes_prevalence='', null, @diabetes_prevalence),hospital_beds_per_thousand=if(@hospital_beds_per_thousand='',null, @hospital_beds_per_thousand),life_expectancy=if(@life_expectancy='',null,@life_expectancy),human_development_index=if(@human_development_index= '',null,@human_development_index),excess_mortality_cumulative_absolute=if(@excess_mortality_cumulative_absolute= '',null,@excess_mortality_cumulative_absolute);
  
  ##deleted all continents except asia & europe since query took too long to process 
  ## analysis is just made for Europe & Asia continents
DELETE FROM c_vacc WHERE continent IN ('Africa','Oceania','North America','South America');
DELETE FROM c_vacc WHERE location IN ('North America','South America','Africa','Oceania');

##adding another column of date with date as a datatype cuz the previous date2 column was in text datatype 
alter table c_vacc 
add column date4 date;
update c_vacc
set date4= STR_TO_DATE(date2, "%d-%m-%Y");


##Data exploration
#Q1
##global numbers
select sum(new_cases) as tot_cases,sum(cast(new_deaths as signed)) as tot_deaths,(sum(cast(new_deaths as signed))/sum(new_cases))*100 as deathpercentage from c_deaths where continent!=''order by 1,2;

--select sum(new_cases) as tot_cases,sum(cast(new_deaths as signed)) as tot_deaths,(sum(cast(new_deaths as signed))/sum(new_cases))*100 as deathpercentage from c_deaths where continent='' and location in ('Asia','Europe')order by 1,2;
--Above two queries gives the same result;

#Q2
##total cases vs total deaths
##shows likelihood of dying if you contract covid in your country
select continent,location,sum(new_cases) as total_cases,cast(sum(new_deaths) as signed) as total_deaths, concat(round((sum(new_deaths)/sum(new_cases))*100,2),'%') as deathpc from c_deaths where continent!='' group by location order by deathpc desc;

#Q3
##total cases vs population
select location,date4,total_cases,population, concat(round((total_cases/population)*100,2),'%') as highestinfectioncount from c_deaths where location not in( 'World', 'European Union', 'International') order by location,date4;


#Q4
##looking at countries with highest infection rate compared to population
select location,population, max(total_cases) as highestinfectioncount,max((total_cases/population))*100 as percentpopulationinfected from c_deaths where continent!=''  group by location order by percentpopulationinfected desc;
##Cyprus has the most infection ratio of 67.26%

#Q5
##showing countries with highest death count 
##here i used cast() to convert new_deaths datatype text to integer
##also i think there is some data mismatch in new_deaths column for afghanistan as i was getting decimal value for sum(new_deaths).so i changed the data type
select location,population, max(cast(total_deaths as signed)) as totaldeathcount from c_deaths where continent!='' group by location order by totaldeathcount desc;
##India has seen maximum deaths 

#Q6
##Breakdown by continent
select continent,(population), sum(cast(new_deaths as signed)) as totaldeathcount from c_deaths where continent!=''  group by continent order by totaldeathcount desc;
select location,population, sum(cast(new_deaths as signed)) as totaldeathcount from c_deaths where continent='' group by location order by totaldeathcount desc;


##query took long time to process huge data upon joining.Hence deleteing few columns to reduce the size & fast processing
ALTER TABLE c_vacc
drop new_vaccinations_smoothed_per_million,drop new_people_vaccinated_smoothed_per_hundred, drop excess_mortality_cumulative_per_million,drop excess_mortality_cumulative_absolute,
drop handwashing_facilities,drop new_vaccinations_smoothed,drop new_tests_smoothed_per_thousand,drop new_tests_per_thousand,drop total_vaccinations_per_hundred,drop hospital_beds_per_thousand,drop handwashing_facilities,
drop total_tests_per_thousand,drop people_vaccinated_per_hundred,drop total_boosters_per_hundred,drop gdp_per_capita,drop extreme_poverty,drop excess_mortality_cumulative,
drop human_development_index,drop new_tests_smoothed,drop tests_per_case;

 ALTER TABLE c_deaths drop total_cases_per_million, drop
new_cases_per_million,drop new_cases_smoothed_per_million,drop total_deaths_per_million,drop new_deaths_per_million,drop new_deaths_smoothed_per_million,drop reproduction_rate,drop icu_patients_per_million,drop hosp_patients, drop hosp_patients_per_million,drop weekly_icu_admissions,
drop weekly_icu_admissions_per_million,drop weekly_hosp_admissions,drop weekly_hosp_admissions_per_million;

#Q6
##total population vs vaccination
select d.continent,d.location,d.population,d.date4,v.new_vaccinations,sum(v.new_vaccinations )
 over (partition by d.location order by d.location,d.date4) as rolling_count_of_vacc from c_deaths d join c_vacc v on d.location=v.location and d.date4=v.date4 where d.continent!=''order by continent,location,d.date4;

##Percentage of population got vaccinated
##create a CTE
with popvsvac (continent,location,population,new_vacc,rolling_count_of_vacc)
as(
select d.continent,d.location,d.population,v.new_vaccinations,sum(v.new_vaccinations )
 over (partition by d.location order by d.location) as rolling_count_of_vacc from c_deaths d join c_vacc v on d.location=v.location and d.date4=v.date4 where d.continent!='')
 select *, (rolling_count_of_vacc/population)*100 as vacc_rate from popvsvac group by location order by vacc_rate desc ;
 
 
 ##creating view for later visualisations
Create view vacc_rate as
Select d.continent, d.location, d.date4, d.population, v.new_vaccinations
, SUM(cast(v.new_vaccinations as signed)) OVER (Partition by d.Location Order by d.location, d.date4) as RollingPeopleVaccinated
From c_deaths d
Join c_vacc v
	On d.location = v.location
	and d.date4 = v.date4
where d.continent is not null ;
 select * from vacc_rate ;
 
--
--
--
--
##Queries for tableau project
#total cases vs population for tableau project 
#Q1
select sum(new_cases) as tot_cases,sum(cast(new_deaths as signed)) as tot_deaths,(sum(cast(new_deaths as signed))/sum(new_cases))*100 as deathpercentage from c_deaths where continent!=''order by 1,2;

##tot_cases vs tot_deaths & deathpc(countrywise)
#Q7
select continent,location,sum(new_cases) as total_cases,cast(sum(new_deaths) as signed) as total_deaths, concat(round((sum(new_deaths)/sum(new_cases))*100,2),'%') as deathpc from c_deaths where continent!='' group by location order by deathpc desc;
##tot_cases vs tot_deaths & deathpc(continent wise)
#Q2
select continent,sum(new_cases) as total_cases,cast(sum(new_deaths) as signed) as total_deaths, concat(round((sum(new_deaths)/sum(new_cases))*100,2),'%') as deathpc from c_deaths where continent!='' group by continent order by deathpc desc;
#Q3
select location,population,sum(new_cases) as highestinfectioncount, round((sum(new_cases)/population)*100,3) as percentpopulationinfected from c_deaths where continent!=''group by location order by percentpopulationinfected desc;
 
 #Q4
 select location,date4,population,sum(new_cases) as highestinfectioncount, round((sum(new_cases)/population)*100,3) as percentpopulationinfected from c_deaths where continent!=''group by location,population,date4 order by percentpopulationinfected desc;

#Q5
##total population vs vaccination
select d.continent,d.location,d.population,v.new_vaccinations,sum(v.new_vaccinations )
 over (partition by d.location order by d.location,d.date4) as rolling_count_of_vacc from c_deaths d join c_vacc v on d.location=v.location where d.continent!=''order by continent,location;

#Q6
#Vaccination rate
with popvsvac (continent,location,population,rolling_count_of_vacc)
as(
select d.continent,d.location,d.population,max(v.total_vaccinations )
 over (partition by d.location order by d.location) as vaccination_count from c_deaths d join c_vacc v on d.location=v.location and d.date4=v.date4 where d.continent!='')
 select *, (rolling_count_of_vacc/population)*100 as vacc_rate from popvsvac group by location order by vacc_rate desc ;

select * from c_vacc;