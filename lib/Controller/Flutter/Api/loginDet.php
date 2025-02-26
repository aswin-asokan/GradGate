<?php
include 'dbCon.php';
class User {
    private $pdo;
    public function  __construct($pdo)
    {
        $this->pdo=$pdo;
    }
    
    public function login($email, $password) {
        // Prepare the SQL statement
        try{
        $stmt = $this->pdo->prepare("SELECT id,password, user_type FROM users WHERE mail = :mail");
        $stmt->bindParam(':mail', $email);
        $stmt->execute();

        // Fetch the user record
        $user = $stmt->fetch(PDO::FETCH_ASSOC);

        if ($user && password_verify($password, $user['password'])) {
            // Successful login
            return [
                'success' => true,
                'user_id' => $user['id'],
                'user_type' => $user['user_type'],
                
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
    //signup 
    public function signUp($email, $password,$type) {
        try{
        // Prepare the SQL statement
       
        $stmt = $this->pdo->prepare("INSERT INTO users (mail,password,user_type) VALUES (:mail,:password, :user_type)");
        $hashPassword = password_hash($password,PASSWORD_DEFAULT);
    // Bind parameters to the SQL query
    $stmt->bindParam(':mail', $email);
    $stmt->bindParam(':password', $hashPassword);
    $stmt->bindParam(':user_type', $type);
    $done= $stmt->execute();
    if ( $done) {
       
        $st =$this->login($email, $password);

        // Successful signup
        return [
            'success' => true,
            'user_id' => $st['user_id'],
            'user_type' => $st['user_type'],
            
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
//count
    public function countAll() {
        // Prepare the SQL statement
        try{
        $stmt = $this->pdo->prepare("SELECT ROUND(AVG(salary)) AS average_salary, COUNT(*) AS active_jobs_count
FROM job_postings
WHERE status = 'active'");
        $stmt->execute();

        // Fetch the user record
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
$avg_sal =  $user['average_salary'];
$count_job=  $user['active_jobs_count'];
$stmt = $this->pdo->prepare("SELECT 
    COUNT(CASE WHEN status = 'applied' THEN 1 END) AS applied_count,
    COUNT(CASE WHEN response = 'accepted' THEN 1 END) AS accepted_count
FROM applications");
        $stmt->execute();

        // Fetch the user record
        $user = $stmt->fetch(PDO::FETCH_ASSOC);
        $applied_count =  $user['applied_count'];
        $accepted_count=  $user['accepted_count'];
            // Successful login
            return [
                'success' => true,
                'c_appl' => $applied_count,
                'r_appl' => $accepted_count,
                'avg_sal' => $avg_sal,
                'active' => $count_job,
                
            ];

    }
    catch (PDOException $e) {
        return [
            'success' => false,
            'message' => 'Invalid Username or Password',
        ];
    }
   
    }
}



// Create User instance
$user = new User($pdo);

// Check if data is received
$action = $_GET['action'];
if (isset($action)) {
    if($action=='login')
    {
    if(method_exists($user,'login'))
    {
    $mail = $_POST['mail'];
    $password =$_POST['password'];
    // Call the verifyUser method
    $result = $user->login($mail, $password);
    echo json_encode($result);
}
else{
    echo json_encode(['success' => false, 'message' => 'Invalid request.']);
}
    }
else if($action=='signup'){
 if(method_exists($user,'signUp'))
{
$mail = $_POST['mail'];
$password = $_POST['password'];
$type =$_POST['type'];
// Call the verifyUser method
 $result = $user->signUp($mail, $password,$type);
 echo json_encode($result);
}
else{
    echo json_encode(['success' => false, 'message' => 'Invalid request.']);
}
}
else if($action=='count')
    {
    if(method_exists($user,'countAll'))
    {
    // Call the verifyUser method
    $result = $user->countAll();
    echo json_encode($result);
}
else{
    echo json_encode(['success' => false, 'message' => 'Invalid request.']);
}
    }

} else {
    echo json_encode(['success' => false, 'message' => 'Invalid request.']);
}


?>
