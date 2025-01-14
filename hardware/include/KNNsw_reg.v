//START_TABLE sw_reg

//ENABLES
`SWREG_W(KNN_RESET,          1, 0) //Timer soft reset
`SWREG_W(KNN_ENABLE,         1, 0) //Timer enable
`SWREG_W(KNN_SAMPLE,         1, 0) //Sample time counter value into a readable register

//DATA TO USE IN VERILOG
`SWREG_W(COORD_XX, DATA_W, 0) //Abciss of the data we want to discover its label
`SWREG_W(COORD_DATAX, DATA_W, 0) // Abciss of the known data

`SWREG_W(COORD_DATAY, DATA_W, 0) // Y of the known data
`SWREG_W(COORD_XY, DATA_W, 0) // Y of the data we want to discover its label


//DATA TO USE IN C
`SWREG_R(DISTANCE_HIGH, DATA_W, 0) //High part of the timer value, which has twice the width of the data word width
`SWREG_R(DISTANCE_LOW,  DATA_W, 0) //Low part of the timer value, which has twice the width of the data word width
