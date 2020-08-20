# <center> FOOD-INGREDIENTS </center>

Food Ingredients is a diet <ins>nutrients suggestion app</ins> which makes you aware of the nutrients over- and under- consumptions and thus, helps you mantain a balanced nutritious diet. It stores the nutritional information of all the food that you consume for a day and displays you a report showing where your nutrients consumption lacks/ exceeds the ideal limit.

Some of the features of this application are:
- Capture image from Camera.
- Pick image from Gallery.
- The nutrition consumption information stored locally is refreshed on daily basis.
- The backend to this application assumes that the identified food is prepared using the most common method.
- Different serving sizes are displayed to choose from.
- No login/signup required.

*This application works only when a backend server entertains POST request to one of its URL, processes the food image passed as a part of the request and then sends a JSON response containing the nutritional info. If the backend solution is hosted somewhere, a URL change should be made in the `imagePicker.dart` file within the definition of `sendImage` function. If the server is running locally over some computer, you may use tools such as ngrok to communicate between the frontend and the backend application.*

## Installing the application


#### **Prerequisites**
- Flutter installed on your local device. Make sure you can run the `flutter` command from inside the terminal at the location when you clone these files. If you are not able to, please try installing flutter/modifying the environment variables

    A few resources to get you started if this is your first Flutter project:
    - [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
    - [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)
    - For help getting started with Flutter, view the
    [online documentation](https://flutter.dev/docs) of flutter, which offers tutorials,
    samples, guidance on mobile development, and a full API reference.

- Android Studio installed on the device.
#### **Install Procedure**
- **Clone the repository**
    > ```git clone 'https://github.com/kadarsh835/learn_flutter-Food_ingredients'```
- **Check flutter setup** on your device and get your device ready for installation of a flutter application. Run the following command
    1. > `flutter doctor`
    2. > `flutter clean`

    in the terminal.
- **Get the required packages:** Inside of the flutter repository, run the command
    > `flutter pub get`

    to get all the dependent libraries for this application.
- **Connect you mobile** using a cable.
    - Make sure that the setting `USB Debugging` is enabled for your device.
- **Run the application:** 
    - Make sure that the server is up and running and is accepting respones. Also make sure that correct URL is embedded into the source code of the frontend application.
    - Run the command below in your terminal with your mobile screen on.
        > `flutter run`
    
- The app should start on the device.

I hope that the common public finds this useful and makes use of it in the best possible way for their better health.
<center> **Cheers to a healthy INDIA** </center>