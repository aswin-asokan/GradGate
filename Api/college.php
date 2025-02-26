<?php
include 'dbCon.php';
class collCont {
    private $pdo;
    public function  __construct($pdo)
    {
        $this->pdo=$pdo;
    }
  
            public function test($user_id)
            {
                $st = $this->pdo->prepare("SELECT eid FROM employer WHERE  user_id = :id");
                $st->bindParam(':id', $user_id);
                $st->execute();
        
                // Fetch the user record
               //$userDet = $st->fetch(PDO::FETCH_ASSOC);
            // Prepare the SQL statement
                   $userDet = $st->fetch(PDO::FETCH_ASSOC);

            $eid = $userDet['eid'];
                echo $eid;
            }
     

      //Add Employer details 
      public function addColl($user_id, $var_name,$location,$phone)
      {
        try{
        $stmt = $this->pdo->prepare("INSERT INTO colleges (user_id,college_name,location,phone) VALUES (:user_id, :name,:location, :phone)");

    // Bind parameters to the SQL query
    $stmt->bindParam(':user_id', $user_id);//intval($user_id));
    $stmt->bindParam(':name', $var_name);
    $stmt->bindParam(':phone', $phone);
    $stmt->bindParam(':location', $location);
    $done= $stmt->execute();
    if ( $done) {       
        return [
            'success' => true,
            'user_id' => $user_id,
        ];
    } 
}
    catch (PDOException $e) {
        return [
            'success' => false,
            'message' => 'Invalid request',
        ];
    }
   
    }

       // retrieve student details
public function stdDetails($user_id)
{

    $st1 = $this->pdo->prepare("
  SELECT 
    students.name AS stud_name,colleges.college_name as college_name ,users.mail as mail_id,
    students.student_id AS stud_id,students.department as dpartment,students.phone as phone,
    students.imgUrl AS img_url,students.about as about,
    employer.company_name AS company
FROM 
    applications
JOIN 
    students ON applications.student_id = students.student_id
 JOIN 
    users ON students.user_id = users.id
JOIN 
    colleges ON colleges.clg_id = students.coll_id
JOIN 
    job_postings ON applications.job_id = job_postings.job_id
JOIN 
    employer ON job_postings.emp_id = employer.eid
    
WHERE 
    applications.response = 'accepted'
    AND colleges.user_id=:user_id");
$st1->bindParam(':user_id', $user_id); // Bind user_id
$st1->execute();
    
            // Fetch all job records as an array
            $stdData = $st1->fetchAll(PDO::FETCH_ASSOC);  // Fetch multiple rows
            return $stdData;
}
// retrieve college details
public function colleDetails($user_id)
{

    // Fetch the user record
          // Fetch all job postings for this employer
             $st1 = $this->pdo->prepare("SELECT * FROM colleges  WHERE user_id = :userid");
            $st1->bindParam(':userid', $user_id);
            $st1->execute();
    
            // Fetch all job records as an array
            $empData = $st1->fetch(PDO::FETCH_ASSOC);
            return  $empData;

}
}


// Create collCont instance 
$user = new collCont($pdo);

// Check if data is received
$action = $_GET['action'];
if (isset($action)) {
    if($action=='addColl')
    {
    if(method_exists($user,'addColl'))
    {
 
    $user_id =  $_POST['user_id'];
    $var_name = $_POST['var_name'];

    $location = $_POST['location'];
    $phone = $_POST['phone'];
   

    
    //add student dtails
    $result = $user->addColl($user_id, $var_name,$location,$phone);

   echo json_encode($result);}
}

//stdlist

if($action == 'stdList') {
    $user_id = $_POST['userId'];
    $stuData = $user->stdDetails($user_id);

    if ($stuData) {
            

        // Return the job data in JSON format
       echo json_encode(['stdData' => $stuData]);
    } else {
        // If no employer found, return an empty array
       echo json_encode(['stdData' => []]);
    }
}

if($action == 'collDet') {
    $user_id = $_POST['userId'];
    $empData = $user->colleDetails($user_id);

    if ($empData) {
            

        // Return the job data in JSON format
       echo json_encode($empData);
    } 
    else{
        echo json_encode(['success' => false, 'message' => 'Invalid request.']);
    }
}


}

else {
    echo json_encode(['success' => false, 'message' => 'Invalid request.']);
}




?>
