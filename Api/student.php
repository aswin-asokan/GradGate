<?php
include 'dbCon.php';

class studConClass {
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
      public function addStud($user_id, $clg_id,$stud_name,$department,$about,$phone,$img)
      {
        try{
        $stmt = $this->pdo->prepare("INSERT INTO students (user_id,department,name,coll_id,about,phone,imgUrl) VALUES (:user_id, :department, :name, :coll_id,:about, :phone, :imgUrl)");

    // Bind parameters to the SQL query
    $stmt->bindParam(':user_id', $user_id);//intval($user_id));
    $stmt->bindParam(':coll_id',$clg_id);
    $stmt->bindParam(':name', $stud_name);
    $stmt->bindParam(':department', $department);
    $stmt->bindParam(':about', $about);
    $stmt->bindParam(':phone', $phone);
    $stmt->bindParam(':imgUrl', $img);
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
    // retrieve job details
public function jobDetails($user_id)
{

    $st1 = $this->pdo->prepare("
    SELECT job_postings.job_title as job_title, applications.status as status,
    applications.application_id as application_id FROM job_postings 
    INNER JOIN applications ON applications.job_id = job_postings.job_id 
    INNER JOIN students ON students.student_id = applications.student_id
    INNER JOIN users ON users.id = students.user_id
    WHERE users.id = :user_id
");
$st1->bindParam(':user_id', $user_id, PDO::PARAM_INT); // Bind user_id
$st1->execute();
    
            // Fetch all job records as an array
            $jobData = $st1->fetchAll(PDO::FETCH_ASSOC);  // Fetch multiple rows
            return $jobData;
}
 // retrieve job list of student
 public function viewJob($user_id)
 {
    $status ='Active';
 
    $st1 = $this->pdo->prepare("
    SELECT 
        job_postings.job_title AS job_title,
        employer.company_name AS company_name,
        employer.location AS location,
        employer.imgUrl AS imgUrl,
        job_postings.end_date AS date,
        job_postings.job_type AS job_type,
        job_postings.job_description AS about,
        job_postings.salary AS salary,
        job_postings.job_id AS job_id
    FROM 
        job_postings
    INNER JOIN 
        employer 
        ON job_postings.emp_id = employer.eid
    INNER JOIN 
        students 
        ON FIND_IN_SET(students.department, job_postings.department) > 0
    INNER JOIN 
        users 
        ON users.id = students.user_id
    WHERE 
        users.id = :user_id AND 
        job_postings.status=:status
");
$st1->bindParam(':status', $status); 
$st1->bindParam(':user_id', $user_id); // Bind user_id
$st1->execute();
     
             // Fetch all job records as an array
             $jobData = $st1->fetchAll(PDO::FETCH_ASSOC);  // Fetch multiple rows
             return $jobData;
 }
// retrieve student details
public function stuDetails($user_id)
{

    // Fetch the user record
          // Fetch all job postings for this employer
             $st1 = $this->pdo->prepare("SELECT * FROM students  JOIN colleges ON coll_id =clg_id WHERE students.user_id  =:userid");
            $st1->bindParam(':userid', $user_id);
            $st1->execute();
    
            // Fetch all job records as an array
            $stdData = $st1->fetch(PDO::FETCH_ASSOC);
            return  $stdData;

}

//job apply
public function jobApply($user_id,$job_id,$status,$respose)
{
   
  try{

    
    // Fetch the employer ID (eid) using user ID
    $st = $this->pdo->prepare("SELECT * FROM students WHERE  user_id = :id");
    $st->bindParam(':id', $user_id);
    $st->execute();
    $userDet = $st->fetch(PDO::FETCH_ASSOC);
    $sid = $userDet['student_id'];

    $st = $this->pdo->prepare("SELECT COUNT(*) AS count FROM applications WHERE student_id = :id AND job_id = :jobid");
    $st->bindParam(':id', $sid, PDO::PARAM_INT);
    $st->bindParam(':jobid', $job_id, PDO::PARAM_INT);
    $st->execute(); 
    $userDet = $st->fetch(PDO::FETCH_ASSOC);
    $count = isset($userDet['count']) ? (int) $userDet['count'] : 0;

if($count==0){
    $stmt = $this->pdo->prepare("INSERT INTO applications (student_id,job_id,status,response) VALUES (:stud_id,:job_id,:status,:response)");
    
    // Bind parameters to the SQL query
    $stmt->bindParam(':stud_id', $sid);  // Removed extra space
    $stmt->bindParam(':job_id', $job_id);
    $stmt->bindParam(':status', $status);
    $stmt->bindParam(':response', $respose);
    $done = $stmt->execute();
if ( $done) {       
  return [
      'success' => true,
      'user_id' => $user_id,
  ];
} 
  }
  else{
    return [
        'success' => false,
        'user_id' => $user_id,
    ];
  }
}
catch (PDOException $e) {
  return [
      'success2' => false,
      'message' => 'Invalid request',
  ];
}

}

//job apply
public function offerUpdate($app_id, $op)
{
   
  try{
//accept
    if($op==1)
    {
        
      
      

        $stmt = $this->pdo->prepare("UPDATE applications
JOIN students ON students.student_id = applications.student_id
SET applications.response = 'accepted', 
    students.app_id = applications.application_id
WHERE applications.application_id =:app_id AND students.app_id=0");
    
        // Bind parameters to the SQL query
        $stmt->bindParam(':app_id', $app_id); 
        $done = $stmt->execute();
        $affectedRows = $stmt->rowCount();
        
        

    }else
    {
        $stmt = $this->pdo->prepare("UPDATE  applications SET  response='' WHERE application_id=:sid");
    
        // Bind parameters to the SQL query
        $stmt->bindParam(':sid', $app_id); 
        $done = $stmt->execute();

    }
if ( $affectedRows>0) {       
  return [
      'success' => true,
      
  ];
} else{
    return [
        'success' => false,
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

 // delAcc details 
 public function delAcc($user_id,$pwd)
 {
    try {

        $stmt = $this->pdo->prepare("SELECT * FROM users WHERE id = :id");
        $stmt->bindParam(':id', $user_id);
        $stmt->execute();

        // Fetch the user record
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && password_verify($pwd, $user['password'])) {
           
        // Start a transaction
        $this->pdo->beginTransaction();
    
        // Delete from applications where student_id matches
        $stmt = $this->pdo->prepare("
            DELETE FROM applications 
            WHERE student_id IN (SELECT student_id FROM students WHERE user_id = :user_id)
        ");
        $stmt->bindParam(':user_id', $user_id);
        $stmt->execute();
    
        // Delete from students where user_id matches
        $stmt = $this->pdo->prepare("
            DELETE FROM students 
            WHERE user_id = :user_id
        ");
        $stmt->bindParam(':user_id', $user_id);
        $stmt->execute();
    
        // Delete from users where id matches
        $stmt = $this->pdo->prepare("
            DELETE FROM users 
            WHERE id = :user_id
        ");
        $stmt->bindParam(':user_id', $user_id);
        $stmt->execute();
    
        // Commit the transaction
        $this->pdo->commit();
    
        return [
            'success' => 'deleted',
        ];}
        else{       
            return [
                'success' => 'noFound',
            ];

        }
    } catch (Exception $e) {
        // Rollback the transaction if something failed

        $this->pdo->rollBack();
        return [
            'success' => false,
            'message' => 'Invalid request',
        ];
    }
  

}
  
}


// Create User instance 
$user = new studConClass($pdo);

// Check if data is received
$action = $_GET['action'];
if (isset($action)) {
    if($action=='addStud')
    {
    if(method_exists($user,'addStud'))
    {
   
    $user_id =  $_POST['user_id'];
    $clg_id = $_POST['clg_id'];
    $stud_name = $_POST['stud_name'];
    $department = $_POST['department'];
    $about = $_POST['about'];
    $phone = $_POST['phone'];
    $img = $_POST['imgUrl'];
    if ($department == "Computer Science") {
        $department = "CSE";  // Set department1 to "CS"
    } else if ($department == "Computer Science DS") {
        $department = "DS";  
    }
    else if ($department == "Mechanical") {
        $department = "ME";  
    }
    else if ($department == "Civil") {
        $department = "CE";  
    }
    else if($department == "Electronics") {
        $department = "EC" ;
    }

    
    //add student dtails
    $result = $user->addStud($user_id, $clg_id,$stud_name,$department,$about,$phone,$img);

   echo json_encode($result);
}
else{
    echo json_encode(['success' => false, 'message' => 'Invalid request.']);
}


    }

    

    


//joblist

if($action == 'jobList') {
    $user_id = $_POST['userId'];
    $jobData = $user->jobDetails($user_id);

    if ($jobData) {
            

        // Return the job data in JSON format
       echo json_encode(['jobData' => $jobData]);
    } else {
        // If no employer found, return an empty array
       echo json_encode(['jobData' => []]);
    }
}

if($action == 'stdDet') {
    $user_id = $_POST['userId'];
    $stdData = $user->stuDetails($user_id);

    if ($stdData) {
            

        // Return the job data in JSON format
       echo json_encode($stdData);
    } 
    else{
        echo json_encode(['success' => false, 'message' => 'Invalid request.']);
    }
}


if($action == 'viewJob') {
    $user_id =  $_POST['userId'];
    $jobData = $user->viewJob($user_id);

    if ($jobData) {
            

        // Return the job data in JSON format
       echo json_encode(['jobData' => $jobData]);
    } else {
        // If no employer found, return an empty array
       echo json_encode(['jobData' => []]);
    }
}


if($action=='apply')
{
if(method_exists($user,'jobApply'))
{

$user_id =  $_POST['user_id'];
$job_id = $_POST['job_id'];
$status ="applied";
$response="waiting..";


//add student dtails
$result = $user->jobApply($user_id, $job_id,$status,$response);

echo json_encode($result);
}
else{
echo json_encode(['success' => false, 'message1' => 'Invalid request.']);
}


}
if($action=='offerUp')
{
if(method_exists($user,'offerUpdate'))
{

$app_id =  $_POST['app_id'];
$op = $_POST['op'];


//add student dtails
$result = $user->offerUpdate($app_id, $op);

echo json_encode($result);
}
else{
echo json_encode(['success' => false, 'message1' => 'Invalid request.']);
}


}

if($action=='delAcc')
{
if(method_exists($user,'delAcc'))
{

$user_id =  $_POST['userId'];
$password =  $_POST['password'];


//add student dtails
$result = $user->delAcc($user_id,$password);

echo json_encode($result);
}
else{
echo json_encode(['success' => false, 'message1' => 'Invalid request.']);
}


}

}

else {
    echo json_encode(['success' => false, 'message' => 'Invalid request.']);
}




?>
