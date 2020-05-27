# Optus-POC

1.	Created Weather app to display weather of selected City
2.	MVVM model followed to develop this application
3.	By default 3 City i.e. Sydney, Melbourne and Brisbane weather is displayed inside the application.
4.	Weather data will be auto updated every 15 mins
5.	User can add more Cities by tapping + icon on weather app launch screen.
6.	Provided feature to swipe and delete City name from list apart from the default added cities 
7.	User can select if he want to see temp in Celsius or Fahrenheit by tapping on button on launch screen footer
8.	User can tap on any city and navigated to detail screen, where user can see more details about the city temp and can also see temp for next 24 hours in the interval of 3 hours 
9.	Table view is used to display weather details and collection view is used to display hourly data
10.	Slight animation is provided to weather image and wind speed image to provide fun element 
11.	City Json is added locally which will be used to display city data as user perform filtering on search view controller 
12.	All selected City ID’s are stored locally using user default 
13.	Same city cannot be added twice to display weather list screen
14.	Some unit test cases are added for City add screen and Weather list screen
15.	Activity indicator is used as application perform any operation to indicate user
16.	Application support all mobile device sizes and orientation
17. Open Weather group api "https://api.openweathermap.org/data/2.5/group" is used to fetch weather details for all added cities and forcast api "https://api.openweathermap.org/data/2.5/forecast" is used to get hourly weather detail for particular city
18. City ID provided for Melbourne in requirnment pointing to wrong city so I modified City ID from 4163971 to 2158177. So it will point to Aus Melbourne
19. All background images used inside the applciation are downlaoded from pintrest website and icons from iconfiender. Weather icons are loaded from openweather API
