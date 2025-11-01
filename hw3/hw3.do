clear all
cap log close
set more off

capture cd "/Users/zhizhenyu/code/ECON120C-WI25/hw3"
capture log using "hw3_zhizhenyu.log", text replace

*********************************************
*Econ 120C, WI25
*Source Code for HW3
*Name: Zhizhen Yu
*Email: zhy008@ucsd.edu
*PID: A16498056
*********************************************

/* Load the dataset and save it under a different name as stated in instructions*/

use Seatbelts.dta, clear
save seatbelts_hw3.dta, replace


/* Always start by checking what is on the dataset */
describe

/* Question 1 */
gen lincome = ln(income)
regress fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lincome age


/* Questions 2 and 3 */
encode state, gen(state_id)
regress fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lincome age i.state_id



scalar q2 = -.0106957
display q2
scalar q3 = -0.0057748
display q2


/*Question 4 */

scalar q4 = 0.10 * -0.0057748
display q4

/* Question 5 */
tabulate year, generate(year_)
drop if year == 1983

list year year_1 year_2 year_3 year_4 if year <= 1986, sepby(year)
areg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lincome age ///
year_2 year_3 year_4 year_5 year_6 year_7 year_8 year_9 year_10 ///
year_11 year_12 year_13 year_14 year_15, absorb(state_id) vce(robust)


scalar q5a = -.0037457
display q5a

test year_2 year_3 year_4 year_5 year_6 year_7 year_8 ///
     year_9 year_10 year_11 year_12 year_13 year_14 year_15
	 
scalar q5b = 11.92
display q5b



/* Question 6 */
areg fatalityrate sb_useage speed65 speed70 ba08 drinkage21 lincome age ///
year_2 year_3 year_4 year_5 year_6 year_7 year_8 year_9 year_10 ///
year_11 year_12 year_13 year_14 year_15, absorb(state_id) vce(cluster state_id)





/* Question 7 */
summarize vmt


scalar q7 = 47
display q7


/* Question 8 */



scalar q8 = 34
display q8


/*Question 9 */
areg sb_useage primary secondary speed65 speed70 ba08 drinkage21 lincome age ///
year_2 year_3 year_4 year_5 year_6 year_7 year_8 year_9 year_10 ///
year_11 year_12 year_13 year_14 year_15, absorb(state_id) vce(cluster state_id)


/* Question 10 */
areg sb_useage primary secondary speed65 speed70 ba08 drinkage21 lincome age ///
      year_2 year_3 year_4 year_5 year_6 year_7 year_8 year_9 ///
      year_10 year_11 year_12 year_13 year_14 year_15, absorb(state) vce(cluster state)
scalar coef_primary = .206131
scalar coef_secondary = .1085065
scalar delta_usage = coef_primary - coef_secondary
display delta_usage


scalar q10 = 15
display q10


/* Display all the scalars saved */

scalar list 

/* Close/save your log file */

log close



