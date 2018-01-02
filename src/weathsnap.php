

<?php

// Get API key for making calls to Wunderground API
$MY_WUNDER_KEY = getenv("WUNDER_API_KEY");
if ($MY_WUNDER_KEY === FALSE) {
    $apikeyFileHandle = fopen("../data/secrets/wunder-api-key", 'r');
    if (($apikeyFileHandle) && (($line = fgets($apikeyFileHandle)) !== FALSE) ) {
        $MY_WUNDER_KEY = trim($line);
    }
}
if (($MY_WUNDER_KEY === FALSE) || (strlen($MY_WUNDER_KEY) == 0)) {
    // ERROR: No API key for Wunderground
    throw new Exception("No API key found for Wunderground.");
}


/**
 * Formats display string for sun/moon rise/set
 * @param $rise
 * @param $set
 * @return string
 */
function getRiseAndSetStr($rise, $set) {
    return "rise: " . $rise->hour . ":" . $rise->minute . ", set: " . $set->hour . ":" . $set->minute;
}

/**
 * Calls Wunderground API for weather conditions at given location
 * @param string $location Passed as "query" (aka location) parameter here: https://www.wunderground.com/weather/api/d/docs?d=data/index&MR=1#standard_request_url_format
 * @return mixed Response from Wunderground, as json converted to PHP type
 * @throws Exception Can occur if Wunderground rejects the API key.
 */
function fetchNextConditions($location) {
    global $MY_WUNDER_KEY;

    $resp = file_get_contents("http://api.wunderground.com/api/$MY_WUNDER_KEY/geolookup/conditions/q/$location.json");
    // var_dump($http_response_header);
    // var_dump($resp);
    $cond = json_decode($resp);
    $error = $cond->{'response'}->{'error'}->{'type'};
    if (strcasecmp($error, "keynotfound") == 0) {
        throw new Exception("The Wunderground API service responded with error: \"" . $error . "\".  Using key value: " . "\"$MY_WUNDER_KEY\"");
    }

    return $cond;
}

/**
 * Echo's out display string for given weather conditions
 * @param $conditions stdClass Weather conditions
 */
function printLocationStats($conditions) {
    echo "Location: " . $conditions->{'location'}->{'city'} . ", " . $conditions->{'location'}->{'state'} .
        "   (" . $conditions->{'current_observation'}->{'observation_location'}->{'city'} . ", " . $conditions->{'current_observation'}->{'station_id'} . ")" . "\n";
    echo "Temp: " . $conditions->{'current_observation'}->{'temp_f'} . " F" . "   Humidity: " .$conditions->{'current_observation'}->{'relative_humidity'} .  "\n";
    echo "Wind: " . $conditions->{'current_observation'}->{'wind_string'} . ".  From the " . $conditions->{'current_observation'}->{'wind_dir'} .
        ", currently " . $conditions->{'current_observation'}->{'wind_mph'} . " mph, gusts " . $conditions->{'current_observation'}->{'wind_gust_mph'} . " mph." . "\n";
    echo "Precipitation: " . "Hourly Rate: " . $conditions->{'current_observation'}->{'precip_1hr_in'} . " F" . "   Day's Total: " .$conditions->{'current_observation'}->{'precip_today_in'} .  "\n";
}

?>



<PRE>
<?php
    // HEADER AND MAIN LOCATION
    $myLocation = "pws:KORBEAVE91";
    $response = file_get_contents("http://api.wunderground.com/api/$MY_WUNDER_KEY/geolookup/conditions/q/$myLocation.json");
    $conditions = json_decode($response);
    $response = file_get_contents("http://api.wunderground.com/api/$MY_WUNDER_KEY/geolookup/astronomy/q/$myLocation.json");
    $astronomy = json_decode($response);

    echo "Local time:       " . $conditions->{'current_observation'}->{'local_time_rfc822'} . "\n";
    echo "Observation time: " . $conditions->{'current_observation'}->{'observation_time_rfc822'} . "\n";
    echo "\n";
    echo " Sun: " . getRiseAndSetStr($astronomy->{'sun_phase'}->{'sunrise'}, $astronomy->{'sun_phase'}->{'sunset'}) . "\n";
    echo "Moon: " . getRiseAndSetStr($astronomy->{'moon_phase'}->{'moonrise'}, $astronomy->{'moon_phase'}->{'moonset'}) .
        "   age:" . $astronomy->{'moon_phase'}->{'ageOfMoon'} . " illum:" . $astronomy->{'moon_phase'}->{'percentIlluminated'} .
        " phase:" . $astronomy->{'moon_phase'}->{'phaseofMoon'} . " hemisphere:" . $astronomy->{'moon_phase'}->{'hemisphere'} . "\n";
    echo "\n";
    printLocationStats($conditions);

    // BEAVERCREEK LOCATIONS
    //                        SWCD DemoFarm     Kamrath & Caras     Lwr Highland     Hopkins DemoForest       Larkin
    $locationsBeavercreek = ["pws:KORBEAVE91", "pws:KORBEAVE148", "pws:KORBEAVE290", "pws:KOROREGO37", "pws:KORBEAVE156"];
    foreach ($locationsBeavercreek as $loc) {
        $nextConditions = fetchNextConditions($loc);
        printLocationStats($nextConditions);
    }
?>
</PRE>

<HR> <!-- ============================================================== -->

<PRE>
<?php
    // PORTLAND LOCATIONS
    //                     Portland Heights
    $locationsPortland = ["pws:KORPORTL814"];
    foreach ($locationsPortland as $loc) {
        $nextConditions = fetchNextConditions($loc);
        printLocationStats($nextConditions);
    }
?>
</PRE>
