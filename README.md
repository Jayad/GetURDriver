# GetURDriver

Description
  
  The GoJekDriverAssignment JAR will provide two RESTful API
  1. PUT: Update a Driver's location on every 60 second
  2. GET: Get all Drivers Nearby for a given Customer ( Based on Customers Current Latitude and Longitude,for a Given Radius and Given Limit to display )
  
Prerequisite:
The Project will work seemlessly in container, which will contain necessary dependencies. The system should have a docker installed.

TechStack

1. Language: The Project is Built using Java on Spring Tool Suite. For using inbuilt features(Like Thread) and performance factor    of Java, I have decided to Go with Spring on Java. 

2. Database: 

 a. Mysql (configured on 127.0.0.1:3306:root/jaya )is used for storing and retrieving Users/Drivers Details, Logging of Details of pickup,drop and Rides etc
 
          Currently the Table contains 3 Tables. 
          
          database Name : Records 
          
          i) Table Name : driver_details;
          
             Will Contain : Drivers Details, Like Unique ID, Name, Registration City, Registration Date, Phone, Vehicle numer etc.
          ii) Table Name: user_details;
             Will Contain: Users Details like Unique ID, given Phone no and mail (For Android Lets say Gmail) together as unique key for an user , Residing  City  etc.
          iii) Table Name: ride_details;
              Will Contain: Unique Ride ID, from Starting lat/Long to Ending lat/Long , Start and End time, Fare etc.
          iv) Table Name: ride_Logger;
              Will contain: Driver ID to User ID mapping for a Given Ride, Driver ID and Customer ID mapping.
              
  b. Redis (configured on 127.0.0.1:6379:No Password) is used for Storing the periodic updates of the driver.
  
       The set is named as "location". It contains key as DriverID:currentTimeStamp which is unique, any entry with same unique key will overwrite the value. It will Store Longitude and Latitude for the same unique ID.
          1) "4:1489039230"
          2) "2544.2017"
          3) 1) "35.11321395635604858"
             2) "22.12321230294630681"
             
          Have used GeoRadius Feature (https://redis.io/commands/georadius) For storing and retrieving GeoLocations, Lat Long and Distance 
          Example:  GEORADIUS location 15.0 37.0 5000 km WITHDIST WITHCOORD
          
          
3. InfaStructure: 

       Docker Ubuntu Container is been created and Installed with Redis, MySql,Java8 and Jmeter.
       The fat JAR has been deployed post development on the same.
       Jmeter is been used for Load Testing.
       
4. Testing:

       Unit Testing has been written along with Source code, which will be executed along with Jar.
       Jmeter is used for running Load testing.
       
       Jmeter Test cases: 
       a. GetDriversReqInvalidLatLong:  Which will create random Lat Long and Call GET API (/drivers)
       b. GetDriversReqSuccess: Which will call GET API (/drivers) with fixed Latitude and Longitude
       c. UpdateDriversReq: will call PUT API(/drivers/{id}/location) with a fixed ID in a valid range
       d. UpdateDriversReqFail: Will call PUT API with an invalid Out of Range Driver ID .
       
Attachment Contains:

  1. Source code in tar format
  2. Jar of the source code.
  3. Shell scripts to run to bring up the container
  4. Results from Jmeter tests
  5. PostMan Test Screenshot.


Steps to Execute:

1. Download the tar in your local system.
2. Download the shell scripts , GoJek1.sh and GoJek2.sh
3. Execute the same as below:
  ./GoJek1.sh  #Which will pull the image and Start the Container
  From other terminal execute
  ./GoJek2.sh  #which will start all the services and copy necessary folders from local download to container
   once inside the container,
   execute
   ./GoJek3.sh  #which will start execute the jar

URL Endpoints:

1. Valid Driver Location updates : http://localhost:8080/drivers/200/location {"latitude":-17.11111, "longitude":-77.571111, "accuracy":0.7}
2. valid Driver Invalid Location: http://localhost:8080/drivers/200/location {"latitude":-1117.11111, "longitude":-717.571111, "accuracy":0.7} 
3. Get Drivers nearBy Success :   http://localhost:8080/drivers?longitude=-115.0&latitude=37.0&limit=4&radius=90000
4. Get Drivers nearby Failure :  http://localhost:8080/drivers?longitude=-115.0&latitude=37.0&limit=4&radius=900
  
