# Optus-POC

Created Weather app to display weather of selected City
MVVM model followed to develop this application
By default 3 City i.e. Sydney, Melbourne and Brisbane weather is displayed inside the application.
Weather data will be auto updated every 15 mins
User can add more Cities by tapping + icon on weather app launch screen.
Provided feature to swipe and delete City name from list apart from the default added cities 
User can select if he want to see temp in Celsius or Fahrenheit by tapping on button on launch screen footer
User can tap on any city and navigated to detail screen, where user can see more details about the city temp and can also see temp for next 24 hours in the interval of 3 hours 
Table view is used to display weather details and collection view is used to display hourly data
Slight animation is provided to weather image and wind speed image to provide fun element 
City Json is added locally which will be used to display city data as user perform filtering on search view controller 
All selected City ID’s are stored locally using user default 
Same city cannot be added twice to display weather list screen
Some unit test cases are added for City add screen and Weather list screen
Activity indicator is used as application perform any operation to indicate user
Application support all mobile device sizes and orientation
