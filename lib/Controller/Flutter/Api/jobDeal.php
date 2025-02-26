<?php
include 'dbCon.php';

class UserData {
    private $pdo;
    public function  __construct($pdo)
    {
        $this->pdo=$pdo;
    }

    // retrive applied student list
   
public function studList($job_id)
{
    $st1 = $this->pdo->prepare("SELECT students.name AS name,students.student_id AS student_id,applications.status as status,
    students.phone as phone,students.department as dpartment,students.about as about,colleges.college_name as college_name,
    applications.application_id as application_id,applications.response as response ,students.imgUrl AS img_url,users.mail as mail_id
     FROM students 
    JOIN 
    colleges ON colleges.clg_id = students.coll_id
    JOIN 
    users ON students.user_id = users.id
     JOIN applications ON students.student_id = applications.student_id WHERE applications.job_id = :job_id");
    $st1->bindParam(':job_id', $job_id);
    $st1->execute();

    // Fetch all job records as an array
    $stuData = $st1->fetchAll(PDO::FETCH_ASSOC); 
    return  $stuData;
}
            public function studUpdate($app_id,$status)
            {
                $st = $this->pdo->prepare("UPDATE applications SET status=:sta  WHERE  application_id = :id");
                $st->bindParam(':id', $app_id);
                $st->bindParam(':sta', $status);
                $st->execute();
        
                // Fetch the user record
               //$userDet = $st->fetch(PDO::FETCH_ASSOC);
            // Prepare the SQL statement
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
            public function collegeLists()
{
    $st1 = $this->pdo->prepare("SELECT clg_id,college_name from colleges");
        $st1->execute();
        $clgList = $st1->fetchAll(PDO::FETCH_ASSOC);  // Fetch all job records as an array
       return  $clgList;
}
     
/* */



}



// Create User instance 
$user = new UserData($pdo);


$action = $_GET['action'];
if (isset($action)) {
// stud list
    if($action == 'studDet') {
        $job_id = $_POST['jobId'];
        $studData = $user->studList($job_id);
   
        if ($studData) {
                
    
            // Return the job data in JSON format
           echo json_encode(['stuDet' => $studData]);
        } else {
            // If no employer found, return an empty array
           echo json_encode(['stuDet' => []]);
        }
    }
    //end
    // stud list
    if($action == 'stuUp') {
        $app_id = $_POST['appId'];
        $status = $_POST['status'];

         $user->studUpdate($app_id,$status);

       
    }
    //end
     // clg list
     if($action == 'clgLIst') {
        $clgData =$user-> collegeLists();

         if ($clgData) {
                
    
            // Return the job data in JSON format
           echo json_encode(['clgDet' => $clgData]);
        } else {
            // If no employer found, return an empty array
           echo json_encode(['clgDet' => []]);
        }
       
    }
    //end

} 

else {
    echo json_encode(['success' => false, 'message' => 'Invalid request.']);
}




?>
