#!/bin/csh

# =============================================================================
# This code reads output generated by airsea_diagnostics_DB.csh as applied
# to several different models or experiments.
#
# It plots mean fields in a single column using uniform contour intervals.
#
# A maximum of 8 panels is allowed.  For more panels, see 
#	AirSea_MultiModel_Plot_Means_2col.sh
#
# The model cases can be arranged any way the user choses, but it is envisioned
# that the first case be either OBS/reanalysis, or a control run.  Subsequent
# cases would then be results from different models or experiments. 
#
# Environmental variable "modelname" must match one of those listed in
# airsea_definitions_DB.sh
#
# The user specifies the output directory with the "setenv dirp" commend
# =============================================================================

setenv 	nCases			4		# requires one block per case, below
setenv	dirp			"/Users/demott/Projects/MC_experiments/"		
setenv	panelLabStrt	0		# adjust panel labeling:  0=a, 1=b, 2=c, etc.

#foreach var	( PRECT SPD LHFLX SHFLX SST Qnet SWsfc LWsfc ctLH wdLH tdLH ecLH Qair Qsat delQ )
#foreach var	( comptotLH wdLH tdLH ecLH Qair Qsat delQ )
foreach var	( PRECT )

	setenv varName $var

	#----- case 0 ; 0-based indexing used in NCL, so we'll stick with that
	setenv 	modelname SPCAM4-ctrl
	#echo 	$modelname
	source 	../airsea_definitions_DB.sh # handle model-specific logic
	setenv	caseName0	$modelname
	setenv 	MODDIR0		$FILEDIR
	setenv 	MODNAME0	$modelname
	setenv	MODDATES0	$YMDSTRT"-"$YMDLAST
	setenv	SHORTNAME0	SPCAM4-ctrl	# if "" then use modelname in panel label
	
	#----- case 1
	setenv 	modelname SPCAM4-flatisland
	#echo 	$modelname
	source 	../airsea_definitions_DB.sh # handle model-specific logic
	setenv	caseName1	$modelname
	setenv 	MODDIR1		$FILEDIR
	setenv 	MODNAME1	$modelname
	setenv	MODDATES1	$YMDSTRT"-"$YMDLAST
	setenv	SHORTNAME1	SPCAM4-notopo
	
	#----- case 2
	setenv 	modelname SPCAM4-noland
	#echo 	$modelname
	source 	../airsea_definitions_DB.sh # handle model-specific logic
	setenv	caseName2	$modelname
	setenv 	MODDIR2		$FILEDIR
	setenv 	MODNAME2	$modelname
	setenv	MODDATES2	$YMDSTRT"-"$YMDLAST
	setenv	SHORTNAME2	SPCAM4-noland
	
	#----- case 3
	setenv 	modelname SPCAM4-nodc-landfrac30
	#echo 	$modelname
	source 	../airsea_definitions_DB.sh # handle model-specific logic
	setenv	caseName3	$modelname
	setenv 	MODDIR3		$FILEDIR
	setenv 	MODNAME3	$modelname
	setenv	MODDATES3	$YMDSTRT"-"$YMDLAST
	setenv	SHORTNAME3	SPCAM4-nodc
		
	ncl -Q ./plot_MultiModel_wkRatios_1col.ncl

end
