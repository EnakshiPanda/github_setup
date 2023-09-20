//Importing the final cleaned, merged and appended dataset
clear 
use "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\FinalCleanedFile.dta"

//Summary statistics calculation
summarize HCValue COValue, detail

//Plotting the density graph of manufacturing year 
histogram Mfg_year
graph save 
graph export 

twoway histogram Mfg_year || kdensity Mfg_year

//Splitting the main dataset into year-wise files (PUC Issuance year)

preserve 
keep if year == 2015
save Year_2015
restore 

preserve 
keep if year == 2016
save Year_2016
restore 

preserve 
keep if year == 2017
save Year_2017
restore 

preserve 
keep if year == 2018
save Year_2018
restore 

preserve 
keep if year == 2019
save Year_2019
restore 

preserve 
keep if year == 2020
save Year_2020
restore 

preserve 
keep if year == 2021
save Year_2021
restore 

//Splitting the main dataset into Pass-fail PUC results
preserve 
keep if t_1_certificate_vehicle_test_res == "pass"
save PassResults_Clean
restore

preserve
keep if t_1_certificate_vehicle_test_res == "fail"
save FailResults_Clean
restore

//Calculating the percentage of certifcates who have undertaken the PUC test over the years 

tab t_1_certificate_vehicle_test_res year, column 

//Calculating the BS values over the years (for pass and failed PUC results)
clear
use "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\PUC Results\PassResults_Clean.dta"
compress 
save 
 
preserve 
keep if VehicleCategory == 3
collapse (mean) COValue HCValue, by (year t_3_mas_vehicle_emission_norms) cw
export delimited using "Pass_EmissionNorms_Values"

//*Cleaning and rearranging the dataset

//Passed Vehicles 
//CO_EmissionValues 
import excel "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\PUC Results\EmissionNorms_Pass.xlsx", sheet("CO_Value") firstrow

twoway (line BS_one year) (line BS_two year) (line BS_three year) (line BS_four year) (line BS_six year) , ytitle(Average CO emissions(in %)) ytitle(, size(small)) ylabel(0(0.25)1) yline(0.5, lpattern(shortdash)) yline(0.3, lpattern(shortdash)) ylabel(, labsize(small) labcolor(black)) xtitle(Year of issuance of PUC certificate) xtitle(, size(small)) xlabel(#7) xlabel(, labsize(small) labcolor(black)) title(CO emissions over the years, size(medsmall)) note(red dotted line refers to the prescribed emission limit for BSII/BSIII) graphregion(fcolor(white)) plotregion(fcolor(white))

graph save "Graph" "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\PUC Results\Pass_CO_4W.gph"

graph export "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\PUC Results\Pass_CO_4W.pdf", as(pdf) name("Graph")

//HC_EmissionValues

import excel "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\PUC Results\EmissionNorms_Pass.xlsx", sheet("HC_Value") firstrow

twoway (line BS_one year) (line BS_two year) (line BS_three year) (line BS_four year) (line BS_six year) , ytitle(Average HC emissions(in ppm)) ytitle(, size(small))  ylabel(0(50)250) yline(200, lpattern(shortdash)) ylabel(, labsize(small) labcolor(black)) xtitle(Year of issuance of PUC certificate) xtitle(, size(small)) xlabel(#7) xlabel(, labsize(small) labcolor(black)) title(HC emissions over the years for passed vehicles, size(medsmall)) note(Red dashed line refers to the prescribed emission limit for BSIV/BSVI) graphregion(fcolor(white)) plotregion(fcolor(white))

graph save "Graph" "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\PUC Results\Pass_HC_4W.gph"

graph export "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\PUC Results\Pass_HC_4W.pdf", as(pdf) name("Graph")

//Failed Vehicles 
//CO emission values 

import excel "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\PUC Results\Data Sheets\EmissionValues_Fail.xlsx", sheet("CO_Value") firstrow

twoway (line BS_one year) (line BS_two year) (line BS_three year) (line BS_four year) (line BS_six year) , ytitle(Average CO emissions(in %)) ytitle(, size(small)) ylabel(0(1)4) yline(0.5, lpattern(shortdash)) yline(0.3, lpattern(shortdash)) ylabel(, labsize(small) labcolor(black)) xtitle(Year of issuance of PUC certificate) xtitle(, size(small)) xlabel(#7) xlabel(, labsize(small) labcolor(black)) title(CO emissions for failed vehicles over the years, size(medsmall)) note(Red dashed line refers to the prescribed emissions limit for BSI; Green dashed line for BSII/BSIII and Blue for BSIV/BSVI) graphregion(fcolor(white)) plotregion(fcolor(white))

graph save "Graph" "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\PUC Results\Fail_CO_Emission.gph"

graph export "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\PUC Results\Fail_CO_Emission.pdf", as(pdf) name("Graph")

//HC Emission Values 

import excel "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\PUC Results\Data Sheets\EmissionValues_Fail.xlsx", sheet("HC_Value") firstrow

twoway (line BS_one year) (line BS_two year) (line BS_three year) (line BS_four year) (line BS_six year) , ytitle(Average HC emissions(in ppm)) ytitle(, size(small)) yline(1500, lpattern(shortdash)) yline(750, lpattern(shortdash)) yline(200, lpattern(shortdash)) ylabel(, labsize(small) labcolor(black)) xtitle(Year of issuance of PUC certificate) xtitle(, size(small)) xlabel(#7) xlabel(, labsize(small) labcolor(black)) title(HC emissions for failed vehicles over the years, size(medsmall)) note(Red dashed line refers to the prescribed emissions limit for BSI; Green dashed line for BSII/BSIII and Blue for BSIV/BSVI) graphregion(fcolor(white)) plotregion(fcolor(white))

graph save "Graph" "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\PUC Results\Fail_HC_Emission.gph"

graph export "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\PUC Results\Fail_HC_Emission.pdf", as(pdf) name("Graph")

//Pass and Fail variation over manufacturing year and emission norms 

preserve 
gen Pass_dummy = 1 if t_1_certificate_vehicle_test_res == "pass"
gen Fail_dummy = 1 if t_1_certificate_vehicle_test_res == "fail"
egen total = Pass_dummy + Fail_dummy
collapse (sum) Pass_dummy Fail_dummy, by ( Mfg_year t_3_mas_vehicle_emission_norms)
Pass_rate = Pass_dummy/Total
Fail_rate = Fail_dummy/Total
restore 

*Pass Rate Graph 
clear
import excel "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\Pass_Fail_Rate_MfgYear.xlsx", sheet("Pass_Rate") firstrow

twoway (line BS_one year) (line BS_two year) (line BS_three year) (line BS_four year) (line BS_six year) , ytitle(Pass percentage) ytitle(, size(small)) ylabel(, labsize(small) labcolor(black)) xtitle(Year of manufacturing) xtitle(, size(small)) xlabel(#7) xlabel(, labsize(small) labcolor(black)) title(Distribution of pass rates over the years, size(medsmall)) graphregion(fcolor(white)) plotregion(fcolor(white))

graph save "Graph" "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\Graphs\PassRate_Norms.gph"

graph export "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\Graphs\PassRate_Norms.pdf", as(pdf) name("Graph")

*Fail Rate Graph 
clear
import excel "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\Pass_Fail_Rate_MfgYear.xlsx", sheet("Fail_Rate") firstrow

twoway (line BS_one year) (line BS_two year) (line BS_three year) (line BS_four year) (line BS_six year) , ytitle(Fail percentage) ytitle(, size(small)) ylabel(, labsize(small) labcolor(black)) xtitle(Year of manufacturing) xtitle(, size(small)) xlabel(#7) xlabel(, labsize(small) labcolor(black)) title(Distribution of fail rates over the years, size(medsmall)) graphregion(fcolor(white)) plotregion(fcolor(white))

graph save "Graph" "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\Graphs\FailRate_Norms.gph"

graph export "C:\Users\Uchicago\Box\EPIC - Transport Collaboration\4. Analysis\PUC\Analysis_Enakshi\2. Output\Graphs\FailRate_Norms.pdf", as(pdf) name("Graph")

//Presrcibed vs Observed Values 


preserve
gen number_plate="UP" if strpos( t_1_certificate_vehicle_number, "up")>0
keep if number_plate=="UP"
tab t_1_certificate_vehicle_number_s
keep if length( t_1_certificate_vehicle_number)==10
tab t_1_certificate_vehicle_number_s
tempfile file1
save `file1'

restore

preserve
gen number_plate="HR" if strpos( t_1_certificate_vehicle_number, "hr")>0
keep if number_plate=="HR"
tab t_1_certificate_vehicle_number_s
keep if length( t_1_certificate_vehicle_number)==10
tab t_1_certificate_vehicle_number_s
tempfile file2
save `file2'

restore


preserve
gen number_plate="DL" if strpos( t_1_certificate_vehicle_number, "dl")>0
keep if number_plate=="DL"
tab t_1_certificate_vehicle_number_s
keep if length( t_1_certificate_vehicle_number)==10
tab t_1_certificate_vehicle_number_s
tempfile file3
save `file3'

restore


preserve
gen number_plate="CH" if strpos( t_1_certificate_vehicle_number, "ch")>0
keep if number_plate=="CH"
tab t_1_certificate_vehicle_number_s
keep if length( t_1_certificate_vehicle_number )==10
tab t_1_certificate_vehicle_number_s
tempfile file4
save `file4'


restore

preserve
gen number_plate="PB" if strpos( t_1_certificate_vehicle_number, "pb")>0
keep if number_plate=="PB"
tab t_1_certificate_vehicle_number_s
keep if length( t_1_certificate_vehicle_number)==10
tab t_1_certificate_vehicle_number_s
tempfile file5
save `file5'

restore


preserve
gen number_plate="RJ" if strpos( t_1_certificate_vehicle_number, "rj")>0
keep if number_plate=="RJ"
tab t_1_certificate_vehicle_number_s
keep if length(t_1_certificate_vehicle_number )==10
tab t_1_certificate_vehicle_number_s
tempfile file6
save `file6'

restore
*Append

clear
forvalues i=1(1)6 {
	append using `file`i''
	erase `file`i''
}


//Analyzing the variations in preserved and observed values by year/BS norm


preserve
keep time thApril
gen dummy_day = 1
rename thApril PM
tempfile day1
save `day1'
restore

preserve
keep time C
gen dummy_day = 2
rename C PM
tempfile day2
save `day2'
restore

preserve
keep time D
rename D PM
gen dummy_day = 3
tempfile day3
save `day3'
restore

preserve
keep time E
gen dummy_day = 4
rename E PM
tempfile day4
save `day4'
restore

preserve
keep time F
rename F PM
gen dummy_day = 5
tempfile day5
save `day5'
restore

preserve
keep time G
rename G PM
gen dummy_day = 6
tempfile day6
save `day6'
restore

preserve
keep time H
rename H PM
gen dummy_day = 7
tempfile day7
save `day7'

append using `day1' `day2' `day3' `day4' `day5' `day6'

save Download, replace
use Download, clear


label define day 1 "Fourth_April" 2 "Fifth_April" 3 "Sixth_April" 4 "Seventh_April" 5 "Eigth_April" 6 "Ninth_April" 7 "Tenth_April"
label values dummy_day day

rename dummy_day day_of_the_week

twoway (line PM time), ytitle(Average PM2.5 concentration (ug/m3)) ytitle(, size(small)) ylabel(#4) ylabel(, labsize(vsmall)) xtitle(Hour of the day) xtitle(, size(small)) xlabel(0(3)23) xlabel(, labsize(vsmall) labcolor(black)) by(, title(Hourly average PM2.5 concentration by day, size(medsmall)) note(, size(vsmall))) by(day_of_the_week, yrescale xrescale iyaxes ixaxes iytick ixtick iylabel ixlabel noiytitle noixtitle) graphregion(fcolor(white) ifcolor(white)) plotregion(fcolor(white) ifcolor(white))
