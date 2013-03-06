// Nuts_screws.scad
// Released under Attribution 3.0 Unported (CC BY 3.0) 
// http://creativecommons.org/licenses/by/3.0/
// Stephanie Shaltes

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
screw_8020_1_4_flange_head =  [6.35, 13.08, 13.08, 2, 3.08, 1];
// 8020 #3330 #3340 5/16-18
screw_8020_5_16_flange_head = [7.94, 16.93, 16.93, 2, 4.13, 1];
// 8020 #3059 1/4-20
screw_8020_1_4_button_head =  [6.35,  11.1,  11.1, 2, 3.35, 1];
// 8020 #3104 5/16-18
screw_8020_5_16_button_head = [7.94, 13.89, 13.89, 2, 4.22, 1];
// 8020 #3058 1/4-20
screw_8020_1_4_socket_head =  [6.35,  9.52,  9.52, 2, 6.35, 1];
// 8020 #3106 5/16-18
screw_8020_5_16_socket_head = [7.94, 12.41, 12.41, 2, 8.45, 1];
// 8020 #3400 1/4-20 (countersunk screw)
screw_8020_1_4_flat_head =    [6.35,  6.35, 13.56, 1, 4.14, 1];
// 8020 #3410 5/16-18 (countersunk screw)
screw_8020_5_16_flat_head =   [7.94,  7.94, 16.66, 1, 5.07, 1];

//************* Generic Fractional (inch) screws *************
// Fractional (inch) #2 Button Head (Generic)
screw_inch_2_button_head =    [0.086,  0.164, 0.164, 2, 0.046, 25.4];
// Fractional (inch) #3 Button Head (Generic)
screw_inch_3_button_head =    [0.099,  0.188, 0.188, 2, 0.052, 25.4];
// Fractional (inch) #4 Button Head (Generic)
screw_inch_4_button_head =    [0.112,  0.213, 0.213, 2, 0.059, 25.4];
// Fractional (inch) #5 Button Head (Generic)
screw_inch_5_button_head =    [0.125,  0.238, 0.238, 2, 0.066, 25.4];
// Fractional (inch) #6 Button Head (Generic)
screw_inch_6_button_head =    [0.138,  0.262, 0.262, 2, 0.073, 25.4];
// Fractional (inch) #8 Button Head (Generic)
screw_inch_8_button_head =    [0.164,  0.312, 0.312, 2, 0.087, 25.4];
// Fractional (inch) #10 Button Head (Generic)
screw_inch_10_button_head =   [0.190,  0.361, 0.361, 2, 0.101, 25.4];
// Fractional (inch) 1/4 Button Head (Generic)
screw_inch_1_4_button_head =  [0.250,  0.437, 0.437, 2, 0.132, 25.4];
// Fractional (inch) 5/16 Button Head (Generic)
screw_inch_5_16_button_head = [0.3125, 0.547, 0.547, 2, 0.166, 25.4];
// Fractional (inch) 3/8 Button Head (Generic)
screw_inch_3_8_button_head =  [0.375,  0.656, 0.656, 2, 0.199, 25.4];
// Fractional (inch) 1/2 Button Head (Generic)
screw_inch_1_2_button_head =  [0.500,  0.675, 0.675, 2, 0.265, 25.4];

// Fractional (inch) #2 Socket Head (Generic)
screw_inch_2_socket_head =    [0.086, 0.140, 0.140, 2, 0.086, 25.4];
// Fractional (inch) #3 Socket Head (Generic)
screw_inch_3_socket_head =    [0.099, 0.161, 0.161, 2, 0.099, 25.4];
// Fractional (inch) #4 Socket Head (Generic)
screw_inch_4_socket_head =    [0.112, 0.183, 0.183, 2, 0.112, 25.4];
// Fractional (inch) #5 Socket Head (Generic)
screw_inch_5_socket_head =    [0.125, 0.205, 0.205, 2, 0.125, 25.4];
// Fractional (inch) #6 Socket Head (Generic)
screw_inch_6_socket_head =    [0.138, 0.226, 0.226, 2, 0.138, 25.4];
// Fractional (inch) #8 Socket Head (Generic)
screw_inch_8_socket_head =    [0.164, 0.270, 0.270, 2, 0.164, 25.4];
// Fractional (inch) #10 Socket Head (Generic)
screw_inch_10_socket_head =   [0.190, 0.312, 0.312, 2, 0.190, 25.4];
// Fractional (inch) 1/4 Socket Head (Generic)
screw_inch_1_4_socket_head =  [0.250,  0.375, 0.375, 2,  0.250, 25.4];
// Fractional (inch) 5/16 Socket Head (Generic)
screw_inch_5_16_socket_head = [0.3125, 0.469, 0.469, 2, 0.3125, 25.4];
// Fractional (inch) 3/8 Socket Head (Generic)
screw_inch_3_8_socket_head =  [0.375,  0.563, 0.563, 2,  0.375, 25.4];
// Fractional (inch) 1/2 Socket Head (Generic)
screw_inch_1_2_socket_head =  [0.500,  0.750, 0.750, 2,  0.500, 25.4];

// Fractional (inch) #2 Flat Head (countersunk screw) (Generic)
screw_inch_2_flat_head =    [0.086,  0.086,  0.197, 2, 0.064, 25.4];
// Fractional (inch) #3 Flat Head (countersunk screw) (Generic)
screw_inch_3_flat_head =    [0.099,  0.099,  0.226, 2, 0.073, 25.4];
// Fractional (inch) #4 Flat Head (countersunk screw) (Generic)
screw_inch_4_flat_head =    [0.112,  0.112,  0.255, 1, 0.083, 25.4];
// Fractional (inch) #5 Flat Head (countersunk screw) (Generic)
screw_inch_5_flat_head =    [0.125,  0.125,  0.281, 1, 0.090, 25.4];
// Fractional (inch) #6 Flat Head (countersunk screw) (Generic)
screw_inch_6_flat_head =    [0.138,  0.138,  0.307, 1, 0.097, 25.4];
// Fractional (inch) #8 Flat Head (countersunk screw) (Generic)
screw_inch_8_flat_head =    [0.164,  0.164,  0.359, 1, 0.112, 25.4];
// Fractional (inch) #10 Flat Head (countersunk screw) (Generic)
screw_inch_10_flat_head =   [0.190,  0.190,  0.411, 1, 0.127, 25.4];
// Fractional (inch) 1/4 Flat Head (countersunk screw) (Generic)
screw_inch_1_4_flat_head =  [0.250,  0.250,  0.531, 1, 0.161, 25.4];
// Fractional (inch) 5/16 Flat Head (countersunk screw) (Generic)
screw_inch_5_16_flat_head = [0.3125, 0.3125, 0.656, 1, 0.198, 25.4];
// Fractional (inch) 3/8 Flat Head (countersunk screw) (Generic)
screw_inch_3_8_flat_head =  [0.375,  0.375,  0.781, 1, 0.234, 25.4];
// Fractional (inch) 1/2 Flat Head (countersunk screw) (Generic)
screw_inch_1_2_flat_head =  [0.500,  0.500,  0.938, 1, 0.251, 25.4];

//************* Generic Metric screws *************
// Metric M3 Button Head (Generic)
screw_M3_button_head =  [ 3,  5.7,  5.7, 2, 1.65, 1];
// Metric M4 Button Head (Generic)
screw_M4_button_head =  [ 4,  7.6,  7.6, 2,  2.2, 1];
// Metric M5 Button Head (Generic)
screw_M5_button_head =  [ 5,  9.5,  9.5, 2, 2.75, 1];
// Metric M6 Button Head (Generic)
screw_M6_button_head =  [ 6, 10.5, 10.5, 2,  3.3, 1];
// Metric M8 Button Head (Generic)
screw_M8_button_head =  [ 8,   14,   14, 2,  4.4, 1];
// Metric M10 Button Head (Generic)
screw_M10_button_head = [10, 17.5, 17.5, 2,  5.5, 1];

// Metric M3 Socket Head (Generic)
screw_M2p5_socket_head = [2.5, 4.5, 4.5, 2, 2.5, 1];
// Metric M3 Socket Head (Generic)
screw_M3_socket_head =   [  3, 5.5, 5.5, 2,   3, 1];
// Metric M4 Socket Head (Generic)
screw_M4_socket_head =   [  4,   7,   7, 2,   4, 1];
// Metric M5 Socket Head (Generic)
screw_M5_socket_head =   [  5, 8.5, 8.5, 2,   5, 1];
// Metric M6 Socket Head (Generic)
screw_M6_socket_head =   [  6,  10,  10, 2,   6, 1];
// Metric M8 Socket Head (Generic)
screw_M8_socket_head =   [  8,  13,  13, 2,   8, 1];
// Metric M10 Socket Head (Generic)
screw_M10_socket_head =  [ 10,  16,  16, 2,  10, 1];

// Metric M3 Flat Head (Generic)
screw_M3_flat_head =  [ 3,  3,  6.72, 1,  1.83, 1];
// Metric M4 Flat Head (Generic)
screw_M4_flat_head =  [ 4,  4,  8.96, 1,  2.48, 1];
// Metric M5 Flat Head (Generic)
screw_M5_flat_head =  [ 5,  5,  11.2, 1,  3.10, 1];
// Metric M6 Flat Head (Generic)
screw_M6_flat_head =  [ 6,  6, 13.44, 1,  3.72, 1];
// Metric M8 Flat Head (Generic)
screw_M8_flat_head =  [ 8,  8, 17.92, 1,  4.96, 1];
// Metric M10 Flat Head (Generic)
screw_M10_flat_head = [10, 10,  22.4, 1,  6.20, 1];

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

// Metric Fender washers
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

// Fractional (inch) Fender washers
washer_fender_inch_8 =          [ 11/64, 3/4, 0.05, 25.4];
washer_fender_inch_10 =         [ 13/64, 1/2, 0.05, 25.4];
washer_fender_inch_1_4_od_1_2 = [ 17/64, 1/2, 0.06, 25.4];
washer_fender_inch_1_4_od_1 =   [  9/32,   1, 0.06, 25.4];
washer_fender_inch_5_16 =       [ 11/32, 5/8, 0.08, 25.4];
washer_fender_inch_3_8 =        [ 13/32,   1, 0.08, 25.4];
washer_fender_inch_1_2 =        [ 17/32, 1.5, 0.08, 25.4];

//************* Generic Metric nuts *************
// inner diameter = 1
// flat size = 2
// thickness = 3
// multiplier = 4 (fractional values are multiplied by 25.4 to get metric, else is 1)
nut_M2p5 = [ 2.5,   5,   2, 1];
nut_M3 =   [   3, 5.5, 2.4, 1];
nut_M4 =   [   4,   7, 3.2, 1];
nut_M5 =   [   5,   8,   4, 1];
nut_M6 =   [   6,  10,   5, 1];
nut_M8 =   [   8,  13, 6.5, 1];
nut_M10 =  [  10,  16,   8, 1];

// Jam nuts, also known as half height nuts
nut_jam_M2p5 = [ 2.5,   5, 1.6, 1];
nut_jam_M3 =   [   3, 5.5, 1.8, 1];
nut_jam_M4 =   [   4,   7, 2.2, 1];
nut_jam_M5 =   [   5,   8, 2.7, 1];
nut_jam_M6 =   [   6,  10, 3.2, 1];
nut_jam_M8 =   [   8,  13,   4, 1];
nut_jam_M10 =  [  10,  16,   5, 1];

//************* Generic Fractional (inch) nuts *************
// inner diameter = 1
// flat size = 2
// thickness = 3
// multiplier = 4 (fractional values are multiplied by 25.4 to get metric, else is 1)
nut_inch_2 =        [0.086,  3/16,  1/16, 25.4];
nut_inch_3 =        [0.099,  3/16,  1/16, 25.4];
nut_inch_4 =        [0.112,   1/4,  3/32, 25.4];
nut_inch_5 =        [0.125,  5/16,  7/64, 25.4];
nut_inch_6 =        [0.138,  5/16,  7/64, 25.4];
nut_inch_8 =        [0.164, 11/32,   1/8, 25.4];
nut_inch_10 =       [0.190,   3/8,   1/8, 25.4];
nut_inch_1_4 =      [  1/4,  7/16,  7/32, 25.4];
nut_inch_5_16 =     [ 5/16,   1/2, 17/64, 25.4];
nut_inch_3_8 =      [  3/8,  9/16, 21/64, 25.4];
nut_inch_1_2 =      [  1/2,   3/4,  7/16, 25.4];

// Jam nuts, also known as half height nuts
nut_jam_inch_1_4 =  [  1/4, 7/16, 5/32, 25.4];
nut_jam_inch_5_16 = [ 5/16,  1/2, 3/16, 25.4];
nut_jam_inch_3_8 =  [  3/8, 9/16, 7/32, 25.4];
nut_jam_inch_1_2 =  [  1/2,  3/4, 5/16, 25.4];