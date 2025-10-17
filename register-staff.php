<?php
$host = 'localhost';
$port = 3307;
$dbname = 'library_management';
$user = 'root';
$pass = '';

// Define DSN for PDO
$dsn = "mysql:host=$host;port=$port;dbname=$dbname;charset=utf8mb4";

$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    // Create PDO connection only (remove MySQLi usage)
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}

// Rest of your code follows...
$name = trim($_POST['name'] ?? '');
$email = trim($_POST['email'] ?? '');
$role = trim($_POST['role'] ?? '');
$username = trim($_POST['username'] ?? '');
$password = $_POST['password'] ?? '';

$errors = [];

// Validations
if ($name === '') {
    $errors[] = "Name is required.";
}
if ($email === '' || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $errors[] = "Valid email is required.";
}
if ($role === '') {
    $errors[] = "Role is required.";
}
if ($username === '') {
    $errors[] = "Username is required.";
}
if ($password === '') {
    $errors[] = "Password is required.";
}

if (!empty($errors)) {
    foreach ($errors as $error) {
        echo "<p style='color:red;'>$error</p>";
    }
    echo "<p><a href='register-staff.html'>Go back</a></p>";
    exit;
}

// Check uniqueness
try {
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM staff WHERE email = ? OR username = ?");
    $stmt->execute([$email, $username]);
    $count = $stmt->fetchColumn();
    if ($count > 0) {
        echo "<p style='color:red;'>Email or username already exists. Please choose another.</p>";
        echo "<p><a href='register-staff.html'>Go back</a></p>";
        exit;
    }
} catch (PDOException $e) {
    echo "<p style='color:red;'>Error checking existing staff: " . htmlspecialchars($e->getMessage()) . "</p>";
    exit;
}

// Hash password securely
$hashed_password = password_hash($password, PASSWORD_DEFAULT);

// Insert new staff member
try {
    $insertStmt = $pdo->prepare("INSERT INTO staff (name, email, role, username, password) VALUES (?, ?, ?, ?, ?)");
    $insertStmt->execute([$name, $email, $role, $username, $hashed_password]);
    echo "<p style='color:green;'>Staff member '$name' registered successfully.</p>";
    echo "<p><a href='register-staff.html'>Register another staff</a> | <a href='index.html'>Home</a></p>";
} catch (PDOException $e) {
    echo "<p style='color:red;'>Failed to register staff: " . htmlspecialchars($e->getMessage()) . "</p>";
    echo "<p><a href='register-staff.html'>Go back</a></p>";
}
?>

