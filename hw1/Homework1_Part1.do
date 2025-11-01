clear  /* clear any existing file in the memory */
set more off 
cd "your_file_path/ECON120C-WI25/hw1"

*********************************************
*Econ 120C, WI25
*Source Code for HW1
*Name: 	
*Email: 
*PID: 
*********************************************


scalar beta0 =           /* choose an integer number between 1 and 20 */
scalar beta1 =           /* choose a number greater than 0 but less than 2 */
						 /* use one one decimal place for your number. */
						
capture postclose tempid 

postfile tempid beta1_hat se_beta1hat t_stat reject using ols_estimates_b,replace 
  /* declare the variable names and the filename of a (new) Stata dataset where
    results are to be stored. */

forvalues j = 1(1)2000 {   /* perform the experiement 2000 times */
drop _all                  /* drop all the variables in memory */
qui set obs 500            /* set the number of observations in each sample*/ 
gen x = runiform()         /* generate x  */
gen u = x - runiform()    /* generate u - first let's make it correlated with x
							and later, let's make it uncorrelated with x */
gen y = beta0 + beta1*x + u /* generate y according to y = beta0+ beta1*x+ u */
quietly reg y x,r          /* quietly regress y on x, suppressing all outputs */
scalar t = (_b[x]-beta1)/_se[x]

qui test x = beta1
sca reject= (r(p) < 0.05) 

post tempid (_b[x]) (_se[x]) (t) (reject)
                        /* post beta1_hat, the standard error (se), t-stat, and decision
						   to the Stata "dataset ols_estimates" */
}
postclose tempid

clear
use ols_estimates_b      /* this dataset contains the simulation results */
							 
									
sum                     		/* look at the output */
									
hist beta1_hat, normal title("sampling distribution of beta1_hat")         
                     /* graph the histogram of beta1_hat */
                     /* the "normal" option asks STATA to
					 overlay a normal density with the same mean and variance */ 
graph export beta_hat_biased.pdf, replace


hist t_stat, normal title("sampling distribution of t_stat")         
                     /* graph the histogram of t statistic */
                     /* the "normal" option askes STATA to 
					 overlay a normal density with the same mean and variance */ 
graph export t_stat_biased.pdf, replace



