# Robust Fault Tolerant Control of an Unmanned Aerial Vehicle in the Presence of Actuator Faults

This repository contains MATLAB code and experiments related to my Master's research, conducted at the College of EME, NUST, Islamabad, from 2014 to 2016. Three papers were published based on the research:

[1] Q. Fazal, M. Liaquat and M. Iftikhar, "Robust fault tolerant control of an unmanned aerial vehicle in the presence of actuator faults," 2016 IEEE/ION Position, Location and Navigation Symposium (PLANS), Savannah, GA, USA, 2016, pp. 757-763 (peer-reviewed), [doi:10.1109/PLANS.2016.747977](https://ieeexplore.ieee.org/document/7479770)

[2] Q. Fazal, M. Liaquat and N. Naz, "Robust fault tolerant control of a DC motor in the presence of actuator faults," 2015 16th International Conference on Sciences and Techniques of Automatic Control and Computer Engineering (STA), Monastir, Tunisia, 2015, pp. 301-333, [doi: 10.1109/ STA .2015.7505169](https://ieeexplore.ieee.org/abstract/document/7505169)

[3] U. -e. -. Aimen, M. Liaquat, R. Ali and Q. Fazal, "Linear Quadratic Tracking in Fault Tolerant Control of DC motor in the presence of actuator faults," 2017 6th International Conference on Systems and Control (ICSC), Batna, Algeria, 2017, pp. 611- 615, [10.1109/ICoSC.2017.795873](https://ieeexplore.ieee.org/abstract/document/7958738)

How to run:
- Open the Aerosonde_Parameters.m file
- Run the file. It automatically loads all the parameters of the Aerosonde UAV, robust observer, and the LQG parameters, and runs the FTC Simulink file
- The FTC.mdl file has the robust FTC framework implemented
- The magnify.m is loaded to facilitate viewing of the plots
