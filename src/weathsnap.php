

<?php

// Sample from: https://www.wunderground.com/weather/api/d/docs?d=resources/code-samples#php

# $MY_WUNDER_KEY = process.env.WUNDER_APIKEY || fs.readFileSync(__dirname + '/../secrets/wunder-api-key', 'utf8').trim();


function getRiseAndSetStr($rise, $set) {
    return "rise: " . $rise->hour . ":" . $rise->minute . ", set: " . $set->hour . ":" . $set->minute;
}

function getNextConditions($loc) {
    global $MY_WUNDER_KEY;

    $resp = file_get_contents("http://api.wunderground.com/api/$MY_WUNDER_KEY/geolookup/conditions/q/$loc.json");
    $cond = json_decode($resp);
    return $cond;
}

function printLocationStats($nextConditions) {
    echo "Location: " . $nextConditions->{'location'}->{'city'} . ", " . $nextConditions->{'location'}->{'state'} .
        "   (" . $nextConditions->{'current_observation'}->{'observation_location'}->{'city'} . ", " . $nextConditions->{'current_observation'}->{'station_id'} . ")" . "\n";
    echo "Temp: " . $nextConditions->{'current_observation'}->{'temp_f'} . " F" . "   Humidity: " .$nextConditions->{'current_observation'}->{'relative_humidity'} .  "\n";
    echo "Wind: " . $nextConditions->{'current_observation'}->{'wind_string'} . ".  From the " . $nextConditions->{'current_observation'}->{'wind_dir'} .
        ", currently " . $nextConditions->{'current_observation'}->{'wind_mph'} . " mph, gusts " . $nextConditions->{'current_observation'}->{'wind_gust_mph'} . " mph." . "\n";
    echo "Precipitation: " . "Hourly Rate: " . $nextConditions->{'current_observation'}->{'precip_1hr_in'} . " F" . "   Day's Total: " .$nextConditions->{'current_observation'}->{'precip_today_in'} .  "\n";
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
        $nextConditions = getNextConditions($loc);
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
        $nextConditions = getNextConditions($loc);
        printLocationStats($nextConditions);
    }
?>
</PRE>
