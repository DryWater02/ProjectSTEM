#include <linkbot.h> //allows the linkbot to connect
// Keybinds for RoboSim:
    // n toggles grid numbering
    // t toggles tracing
    // r toggles robot visibility
CLinkbotI jump, broke; //connects the linkbot
double radius = 1.75;
double width = 3.69;
double x, y, z;

while(1){
    jump.driveDistanceNB(1, radius);
    broke.getAccelerometerData(x, y, z);
    printf("Accelerometer: x: %lf y: %lf z: %lf\n", x, y, z);
    if (y < 0){
    jump.driveTime(0.1);
    break;
    }
}
broke.driveTime(4);
