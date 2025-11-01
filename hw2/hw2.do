clear all
cap log close
set more off

capture cd "your-file-path/ECON120C-WI25/hw2"
capture log using hw2_yourname.log, text replace

*********************************************
*Econ 120C, WI25
*Source Code for HW2
*Name: 	
*Email: 
*PID: 
*********************************************

/* Load the dataset and save it under a different name as stated in instructions*/

use "dataset_name"
save "new_dataset_name", replace

/* Always start by checking what is on the dataset */
describe

/* Question 1 */


scalar q1 = 
display q1

/* Questions 2 and 3*/


scalar q2c = 
display q2c
scalar q3 = 
display q3

/* Questions 4 and 5 */





/* Questions 6 */



/* Question 7 */


scalar q7 = 
display q7
 
/* Question 8 */






scalar q8 = 
display q8

/* Question 9 */





scalar q9 = 
display "J-stat=" q9















scalar list

log close



