<?php

    $firstName = $_POST['firstName'];
    $lastName = $_POST['lastName'];
    $gender = $_POST['gender'];
    $email = $_POST['email'];
    $password = $_POST['password'];
    $phone = $_POST['phone'];

    // Database Connection
    $conn = new mysqli('localhost','faisal','forProject4900','test');
    if($conn->connect_error){
        die('Connection Failed : '.$conn->connect_error);
    }else{
        $stmt = $conn->prepare("INSERT INTO registration(firstName, lastName, gender, email, password, phone) VALUES(?, ?, ?, ?, ?, ?)");
        $stmt->bind_param("sssssi", $firstName, $lastName, $gender, $email, $password, $phone);
        $stmt->execute();
        echo "Registration Successful......";
        $stmt->close();
        $conn->close();
    }
    
?>