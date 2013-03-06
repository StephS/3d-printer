// Screw parameters
// diameter = 1
// head_dia_bottom = 2
// head_dia_top = 3
// head_hole_padding = 4
// head_height = 5
// multiplier = 6 (fractional values are multiplied by 25.4 to get metric, else is 1)

//************* 8020inc Fractional (inch) screws *************
// http://www.3dcontentcentral.com/parts/supplier/80%2020-Inc/9/14/620.aspx
// 8020 #3066 #3342 #3390 1/4-20
screw_8020_1_4_flange_head = [6.35, 13.08, 13.08, 2, 3.08, 1];
// 8020 #3330 #3340 5/16-18
screw_8020_5_16_flange_head = [7.94, 16.93, 16.93, 2, 4.13, 1];
// 8020 #3059 1/4-20
screw_8020_1_4_button_head = [6.35, 11.1, 11.1, 2, 3.35, 1];
// 8020 #3104 5/16-18
screw_8020_5_16_button_head = [7.94, 13.89, 13.89, 2, 4.22, 1];
// 8020 #3058 1/4-20
screw_8020_1_4_socket_head = [6.35, 9.52, 9.52, 2, 6.35, 1];
// 8020 #3106 5/16-18
screw_8020_5_16_socket_head = [7.94, 12.41, 12.41, 2, 8.45, 1];
// 8020 #3400 1/4-20 (countersunk screw)
screw_8020_1_4_flat_head = [6.35, 6.35, 13.56, 1, 4.14, 1];
// 8020 #3410 5/16-18 (countersunk screw)
screw_8020_5_16_flat_head = [7.94, 7.94, 16.66, 1, 5.07, 1];

//************* Generic Fractional (inch) screws *************
// Fractional (inch) #2 Button Head (Generic)
screw_inch_2_button_head = [0.086, 0.164, 0.164, 2, 0.046, 25.4];
// Fractional (inch) #3 Button Head (Generic)
screw_inch_3_button_head = [0.099, 0.188, , 2, 0.052, 25.4];
// Fractional (inch) #4 Button Head (Generic)
screw_inch_4_button_head = [0.112, 0.213, , 2, 0.059, 25.4];
// Fractional (inch) #5 Button Head (Generic)
screw_inch_5_button_head = [0.125, 0.238, , 2, 0.066, 25.4];
// Fractional (inch) #6 Button Head (Generic)
screw_inch_6_button_head = [0.138, 0.262, , 2, 0.073, 25.4];
// Fractional (inch) #8 Button Head (Generic)
screw_inch_8_button_head = [0.164, 0.312, , 2, 0.087, 25.4];
// Fractional (inch) #10 Button Head (Generic)
screw_inch_10_button_head = [0.190, 0.361, , 2, 0.101, 25.4];
// Fractional (inch) 1/4 Button Head (Generic)
screw_inch_1_4_button_head = [0.250, 0.437, , 2, 0.132, 25.4];
// Fractional (inch) 5/16 Button Head (Generic)
screw_inch_5_16_button_head = [0.3125, 0.547, , 2, 0.166, 25.4];
// Fractional (inch) 3/8 Button Head (Generic)
screw_inch_3_8_button_head = [0.375, 0.656, , 2, 0.199, 25.4];
// Fractional (inch) 1/2 Button Head (Generic)
screw_inch_1_2_button_head = [0.500, 0.675, , 2, 0.265, 25.4];

//************* Generic Metric screws *************
// Metric M3 Button Head (Generic)
screw_metric_M3_button_head = [3, 5.7, 5.7, 2, 1.65, 1];
// Metric M4 Button Head (Generic)
screw_metric_M4_button_head = [4, 7.6, 7.6, 2, 2.2, 1];
// Metric M5 Button Head (Generic)
screw_metric_M5_button_head = [5, 9.5, 9.5, 2, 2.75, 1];
// Metric M6 Button Head (Generic)
screw_metric_M6_button_head = [6, 10.5, 10.5, 2, 3.3, 1];
// Metric M8 Button Head (Generic)
screw_metric_M8_button_head = [8, 14, 14, 2, 4.4, 1];
// Metric M10 Button Head (Generic)
screw_metric_M10_button_head = [10, 17.5, 17.5, 2, 5.5, 1];

//************* Generic Metric washers *************
// inner diameter = 1
// outer diameter = 2
// thickness = 3
// multiplier = 4 (fractional values are multiplied by 25.4 to get metric, else is 1)
washer_M2p5 = [ 2.7,    6, 0.5, 1];
washer_M3 =   [ 3.2,    7, 0.5, 1];
washer_M3p5 = [ 3.7,    8, 0.5, 1];
washer_M4 =   [ 4.3,    9, 0.8, 1];
washer_M5 =   [ 5.3,   10, 1.0, 1];
washer_M6 =   [ 6.4, 12.5, 1.6, 1];
washer_M8 =   [ 8.4,   17, 1.6, 1];
washer_M10 =  [10.5,   21,   2, 1];

// Fender washers
washer_fender_M2p5 = [ 2.7,    8, 0.8, 1];
washer_fender_M3 =   [ 3.2,    9, 0.8, 1];
washer_fender_M4 =   [ 4.3,   12, 1.0, 1];
washer_fender_M5 =   [ 5.3,   15, 1.2, 1];
washer_fender_M6 =   [ 6.4,   18, 1.6, 1];
washer_fender_M8 =   [ 8.4,   24, 2.0, 1];
washer_fender_M10 =  [10.5,   30, 2.5, 1];

//************* Generic Fractional (inch) washers *************
// SAE standard washers
washer_inch_2 =          [  3/32,  7/32, 0.03, 25.4];
washer_inch_3 =          [  7/64,   1/4, 0.03, 25.4];
washer_inch_4 =          [   1/8,  5/16, 0.04, 25.4];
washer_inch_5 =          [  9/64,  9/32, 0.04, 25.4];
washer_inch_6 =          [  5/32,   3/8, 0.07, 25.4];
washer_inch_8 =          [  3/16,  7/16, 0.07, 25.4];
washer_inch_10 =         [  7/32,   1/2, 0.07, 25.4];
washer_inch_1_4 =        [  9/32,   5/8, 0.08, 25.4];
washer_inch_5_16 =       [ 11/32, 11/16, 0.08, 25.4];
washer_inch_3_8 =        [ 13/32, 13/16, 0.08, 25.4];
washer_inch_1_2 =        [ 17/32, 1+1/16, 0.13, 25.4];

washer_fender_inch_8 =          [ 11/64, 3/4, 0.05, 25.4];
washer_fender_inch_10 =         [ 13/64, 1/2, 0.05, 25.4];
washer_fender_inch_1_4_od_1_2 = [ 17/64, 1/2, 0.06, 25.4];
washer_fender_inch_1_4_od_1 =   [  9/32,   1, 0.06, 25.4];
washer_fender_inch_5_16 =       [ 11/32, 5/8, 0.08, 25.4];
washer_fender_inch_3_8 =        [ 13/32,   1, 0.08, 25.4];
washer_fender_inch_1_2 =        [ 17/32, 1.5, 0.08, 25.4];