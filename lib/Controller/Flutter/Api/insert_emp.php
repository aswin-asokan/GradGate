<?php
include 'dbCon.php';

class UserData {
    private $pdo;
    public function  __construct($pdo)
    {
        $this->pdo=$pdo;
    }
    public function userDet($id) {
        try{
        // Prepare the SQL statement
        $stmt = $this->pdo->prepare("SELECT mail, user_type FROM users WHERE id = :id");
        $stmt->bindParam(':id', $id);
        $stmt->execute();

        // Fetch the user record
        $userDet = $stmt->fetch(PDO::FETCH_ASSOC);
            if ( $userDet) {
                return [
                    'mail' => $userDet['mail'],
                    'user_type' => $userDet['user_type'],
                    
                ];
            } 
        }
            catch (PDOException $e) {
                return [
                    'success' => false,
                    'message' => 'Invalid Username or Password',
                ];
            }
           
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
      public function addEmp($user_id, $comp_name,$ind_type,$location,$about,$phone,$img)
      {
        try{
        // Prepare the SQL statement
        $st =$this->userDet($user_id);
        $mail = $st['mail'];
        $stmt = $this->pdo->prepare("INSERT INTO employer (user_id,e_mail,company_name,industry_type,location,about,e_phone,imgUrl) VALUES (:user_id, :e_mail, :company_name, :industry_type, :location, :about, :e_phone, :imgUrl)");

    // Bind parameters to the SQL query
    $stmt->bindParam(':user_id', $user_id);//intval($user_id));
    $stmt->bindParam(':e_mail',$mail);
    $stmt->bindParam(':company_name', $comp_name);
    $stmt->bindParam(':industry_type', $ind_type);
    $stmt->bindParam(':location', $location);
    $stmt->bindParam(':about', $about);
    $stmt->bindParam(':e_phone', $phone);
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
  //post job details 
  public function postJob($user_id, $job_title,$job_description,$salary,$job_type,$department,$requirements,$end_date,$status)
  {
    try{
        $st = $this->pdo->prepare("SELECT eid FROM employer WHERE  user_id = :id");
        $st->bindParam(':id', $user_id);
        $st->execute();

        // Fetch the user record
       $userDet = $st->fetch(PDO::FETCH_ASSOC);
    // Prepare the SQL statement
    
    $eid = $userDet['eid'];
    $stmt = $this->pdo->prepare("INSERT INTO job_postings (emp_id,job_title,job_description,salary,job_type,department,requirements,end_date,status) VALUES (:emp_id,:job_title,:job_description,:salary,:job_type,:department,:requirements,:end_date,:status)");

// Bind parameters to the SQL query
$stmt->bindParam(':emp_id', $eid);//intval($user_id));
$stmt->bindParam(':job_title',$job_title);
$stmt->bindParam(':job_description', $job_description);
$stmt->bindParam(':salary', $salary);
$stmt->bindParam(':job_type', $job_type);
$stmt->bindParam(':department', $department);
$stmt->bindParam(':requirements', $requirements);
$stmt->bindParam(':status', $status);
$stmt->bindParam(':end_date', $end_date);


$done = $stmt->execute();
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
        'message' => 'invalid request',
    ];
}

}

// retrieve job details
public function jobDetails($user_id)
{
    // Fetch the employer ID (eid) using user ID
    $st = $this->pdo->prepare("SELECT eid FROM employer WHERE  user_id = :id");
    $st->bindParam(':id', $user_id);
    $st->execute();

    // Fetch the user record
   $userDet = $st->fetch(PDO::FETCH_ASSOC);
   $eid = $userDet['eid'];
          // Fetch all job postings for this employer
             $st1 = $this->pdo->prepare("SELECT * FROM job_postings WHERE emp_id = :id");
            $st1->bindParam(':id', $eid);
            $st1->execute();
    
            // Fetch all job records as an array
            $jobData = $st1->fetchAll(PDO::FETCH_ASSOC);  // Fetch multiple rows
            return $jobData;
}

// retrieve empolyer details
public function empDetails($user_id)
{

    // Fetch the user record
          // Fetch all job postings for this employer
             $st1 = $this->pdo->prepare("SELECT * FROM employer  WHERE user_id = :userid");
            $st1->bindParam(':userid', $user_id);
            $st1->execute();
    
            // Fetch all job records as an array
            $empData = $st1->fetch(PDO::FETCH_ASSOC);
            return  $empData;

}
}



// Create User instance 
$user = new UserData($pdo);

// Check if data is received
$action = $_GET['action'];
if (isset($action)) {
    if($action=='addEmp')
    {
    if(method_exists($user,'addEmp'))
    {
    $user_id = $_POST['user_id'];
    $comp_name =$_POST['comp_name'];
    $ind_type = $_POST['ind_type'];
    $location = $_POST['location'];
    $about = $_POST['about'];
    $phone = $_POST['phone'];
    $img = $_POST['imgUrl'];

    //add employee dtails
    $result = $user->addEmp($user_id, $comp_name,$ind_type,$location,$about,$phone,$img);

   echo json_encode($result);
}
else{
    echo json_encode(['success' => false, 'message' => 'Invalid request.']);
}
    }

    if($action=='test')
    {
    if(method_exists($user,'test'))
    {
  
     $user->test(60);
    }}

    if($action=='postJob')
    {
    if(method_exists($user,'postJob'))
    {
  

    $user_id = $_POST['userId'];
    $job_title = $_POST['job_title'];
    $job_description = $_POST['job_description'];
    $salary  = $_POST['salary'];
    $job_type = $_POST['job_type'];
    $department = $_POST['department'];
    $requirements =   $_POST['requirements'];
    $end_date = $_POST['end_date'];
    $status = 'Active';

    //add employee dtails
    $result = $user->postJob($user_id, $job_title,$job_description,$salary,$job_type,$department,$requirements,$end_date,$status);

   echo json_encode($result);
}
else{
    echo json_encode(['success' => false, 'message' => 'Invalid request.']);
}
    }

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

    if($action == 'empDetails') {
        $user_id = $_POST['userId'];
        $empData = $user->empDetails($user_id);
   
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
