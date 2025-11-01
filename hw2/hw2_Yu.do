clear all
cap log close
set more off

capture cd "/Users/zhizhenyu/code/ECON120C-WI25/hw2"
capture log using hw2_zhizhenyu.log, text replace

*********************************************
*Econ 120C, WI25
*Source Code for HW2
*Name: 	Zhizhen Yu
*Email: zhy008@ucsd.edu
*PID: A16498056
*********************************************

/* Load the dataset and save it under a different name as stated in instructions*/

use "WAGE_WI25.dta"
save "WAGE_hw2_WI25_replica.dta", replace

/* Always start by checking what is on the dataset */
describe

/* Question 1 */

reg lwage educ exper tenure married black urban south
scalar q1 = round(_b[educ]*100, 0.1)
display q1

/* Questions 2 and 3*/

ivregress 2sls lwage (educ = feduc) exper tenure married black urban south, r first
estat firststage
display e(widstat)



ivregress 2sls lwage (educ = feduc) exper tenure married black urban south, vce(robust)
scalar q2c = round(_b[educ]*100, 0.1)
display q2c


scalar q3 = round(_b[urban]*100, 0.1)
display q3

/* Questions 4 and 5 */
reg educ feduc exper tenure married black urban south
predict educ_hat, xb


reg lwage educ_hat exper tenure married black urban south, vce(robust)
scalar q4 = round(_b[educ_hat]*100, 0.1)
display q4


if q4 < q2c {
    scalar q4_comp = "lower"
} 
else if q4 > q2c {
    scalar q4_comp = "higher"
} 
else {
    scalar q4_comp = "same"
}
display q4_comp


scalar se_q4 = round(_se[educ_hat], 0.01)
scalar se_q2 = round(_se[educ], 0.01)






/* Questions 6 */

ivregress 2sls lwage (educ = meduc) exper tenure married black urban south, vce(robust)
scalar q6 = round(_b[educ]*100, 0.1)
display q6


ivregress 2sls lwage (educ = sibs) exper tenure married black urban south, r first
scalar q6b = round(_b[educ]*100, 0.1)
display q6b


reg educ sibs exper tenure married black urban south
scalar sibs_fstat = round(e(statistic), 0.01)
if sibs_fstat > 10 {
    scalar sibs_relevance = "relevant"
} 
else {
    scalar sibs_relevance = "not relevant"
}
display sibs_relevance


if abs(q6 - q6b) < 1 {
    scalar q6_consistency = "similar"
} 
else {
    scalar q6_consistency = "different"
}
display q6_consistency

/* Question 7 */


ivregress 2sls lwage (educ = feduc meduc sibs) exper tenure married black urban south, r first
scalar q7 = round(_b[educ]*100, 0.1)
display q7


if q7 < q2c {
    scalar q7_effect = "smaller"
} 
else {
    scalar q7_effect = "larger"
}
display q7_effect


scalar q7_se = round(_se[educ], 0.01)
if q7_se > se_q2 {
    scalar q7_se_comp = "higher"
} 
else {
    scalar q7_se_comp = "lower"
}
display q7_se_comp
 
/* Question 8 */



ivregress 2sls lwage (educ = feduc meduc sibs) exper tenure married black urban south, r first

estat firststage
scalar q8 = 45.9
display q8



/* Question 9 */


ivregress 2sls lwage (educ = feduc meduc sibs) exper tenure married black urban south, r first

predict uhat_2sls, residuals

regress uhat_2sls feduc meduc sibs exper tenure married black urban south


scalar j_fstat = e(F)
display j_fstat*3
scalar q9 = round(j_fstat * 3, 3)  
display "J-statistic = " q9


if q9 > 5.99 {  
    scalar q9_reject = "reject"
    scalar q9_exog = "not exogenous"
} 
else {
    scalar q9_reject = "fail to reject"
    scalar q9_exog = "exogenous"
}
display q9_reject
display q9_exog















scalar list

log close



