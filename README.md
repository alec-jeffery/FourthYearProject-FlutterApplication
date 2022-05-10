# IoT_Smart_Urban_Gardening - Flutter Application

note: WILL NOT FUNCTION IF CLONED AND RAN AS NODE.JS IS NOT INCLUDED

## Purpose of this application

This flutter app was built for users of the IoT for Smart Urban Farming and Gardening Fourth Year Project. This application allows users to create an account and gives simple interaction with their node (a collection of plant-sensors like humidity, temperature, soil moisture connected to a raspberry pi) and their collected sensor data. 

## Application's Pages

Login pages:

- Login to your account -> Login Page

- Create a new account -> New User Page

Core pages: 

- View latest farm data -> Home Page 

- View compiled farm data -> My Farm Page 

- View interactive map -> My Map Page 

Menu pages: 

- Create node -> New Node Page 

- Create threshold for a plant and sensor -> New Threshold Page 

- View threshold -> View Thresholds Page 

- View notifications -> View Notifications Page 

## Demo Pictures

home page:
![image](https://user-images.githubusercontent.com/50333978/167695283-9f18925f-cf13-4940-972f-665fe05de9e4.png)

map page:
![image](https://user-images.githubusercontent.com/50333978/167695364-adbd0cf0-e06f-4b61-84d1-cd0f3fd3dbab.png)
![image](https://user-images.githubusercontent.com/50333978/167695430-6edf8750-89bb-48c2-b098-ecad5f75c314.png)

my farm page:
![image](https://user-images.githubusercontent.com/50333978/167695460-41ac0401-0b6f-43f9-a832-d98852e2bf6b.png)

new threshold page:
![image](https://user-images.githubusercontent.com/50333978/167695528-3463c926-a722-4687-8e10-b972c825a177.png)

## How to set up and run the flutter app

1.	Install Flutter and follow this guide (https://docs.flutter.dev/get-started/install)
	- You will most likely need to download Android Studio as well ([https://developer.android.com/studio/index.html#downloads](https://developer.android.com/studio/index.html#downloads))
	- You may also want to set up an android emulator (or use your android phone). Instructions to this can be found in the guide linked above.
2.	 If you have followed the instructions above. Next up would be to set up the editor ([https://docs.flutter.dev/get-started/editor?tab=vscode](https://docs.flutter.dev/get-started/editor?tab=vscode))
		- Visual Studio Code is recommended ([https://code.visualstudio.com/download](https://code.visualstudio.com/download))
3. From here, open the project in your editor and investigate the status bar. It should look similar to this if using an emulator
![image](https://user-images.githubusercontent.com/48695650/162821163-e32968fb-720e-45a7-a23d-1b25b9b19265.png)

Or this if using chrome (the default).
![image](https://user-images.githubusercontent.com/48695650/162821234-036e0dda-186f-4a26-ac96-5e70455300f5.png)

4. Navigate the project directory for “main.dart”
	- Here is the path "FourthYearProject-FlutterApplication\app\lib\main.dart"
5. Right click and select “Start Debugging”
	- If chrome was selected, a web browser will open up and the homepage of the app will be displayed (The APIs will fail here. Please follow the next set of instructions to test web locally)
	- If your android device was selected, the homepage will appear there

