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
                $st =$this->userDet($user_id);
                echo $st['mail'];
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
    $about = 'nodata';//$_POST['about'];
    $phone = $_POST['phone'];
    $img = 'nodata';//$_POST['img'];

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
  
     $user->test(1);
    }}

} 

else {
    echo json_encode(['success' => false, 'message' => 'Invalid request.']);
}




?>
