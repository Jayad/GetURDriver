# GetURDriver

Description
  
  The GoJekDriverAssignment JAR will provide two RESTful API
  1. PUT: Update a Driver's location on every 60 second
  2. GET: Get all Drivers Nearby for a given Customer ( Based on Customers Current Latitude and Longitude,for a Given Radius and Given Limit to display )
  
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
       b. Redis (configured on 127.0.0.1:6379:<No Password>) is used for Storing the periodic updates of the driver.
              The set is named as "location". It contains key as DriverID:currentTimeStamp which is unique, any entry with same unique key will overwrite the value. It will Store Longitude and Latitude for the same unique ID.
          1) "4:1489039230"
          2) "2544.2017"
          3) 1) "35.11321395635604858"
             2) "22.12321230294630681"
             
          Have used GeoRadius Feature (https://redis.io/commands/georadius) For storing and retrieving GeoLocations, Lat Long and Distance 
          Example:  GEORADIUS location 15.0 37.0 5000 km WITHDIST WITHCOORD
3. InfaStructure: 
       Docker Ubuntu Container is been created and Installed with Redis and MySql and Jmeter.
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
       

