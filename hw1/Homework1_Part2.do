clear all
cap log close

cd "/Users/zhizhenyu/code/ECON120C-WI25/hw1"
log using hw1_Yu.log, replace

*********************************************
*Econ 120C, WI25
*Source Code for HW1
*Name: 	Zhizhen Yu
*Email: zhy008@ucsd.edu
*PID: A16498056
*********************************************

set obs 1000

set seed 8056				/*set seed using the last 4 digits of your student ID */

gen U =  runiform(-1, 1)				/* generate an uniform between -1 and 1 */
gen V =  runiform(-1, 1)				/* generat an uniform between -1 and 1 */

gen P = 3 + (U - V) / 4			 /* write down solution P in terms of u and v */
gen Q = 8 + (U + 3*V) / 4			 /* write down solution Q in terms of u and v */

sum P Q

/* compute covariances between P and u, and P and v. Confirm that they have the 
expected sign. */

corr P U, covariance
corr P V, covariance

/* Generate the true lines for demand and supply (when supply and demand 
shifters are at their mean).  */

gen Demand = 17 - 3*P
gen Supply = 5+P

/* Create a graph where you plot the data (scatter) the fitted line (lfit), and
the true supply and demand functions you generated above. */
 
twoway (scatter Q P) (line Demand P)  (line Supply P) (lfit Q P)

/* Now regress Quantity on Price, using robust standard errors. */

reg Q P,r

/* Test the null hypotesis that the slope coefficient equals the true demand 
curve slope and the null hypohtesis that it equals the true supply slope.*/

test P = -3
test P = +1

log close
