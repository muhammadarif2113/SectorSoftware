<?php

    $connect = mysqli_connect("localhost", "faisal", "forProject4900", "testing");
    // This is the file we are using to get data
    $filename = "employee_data,json";
    // data is a variable and file_get_content is teh method to get data
    $data = file_get_contents($filename);
    // create an array of data
    $array = json_decode($data, true);

    foreach($array as $row)
    {
        $sql = "INSERT INTO employee (name, gender, designation) VALUES('".$row["name"]."', '".$row["gender"]."', '".$row["designation"].")";
        mysqli_query($connect, $sql);
    }
    echo "Employee Data Inserted";

?>