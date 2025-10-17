<?php
$host = 'localhost';
$port = 3307;
$dbname = 'library_management';
$user = 'root';     // changed from $dbuser to $user for consistency
$pass = '';         // changed from $dbpass to $pass for consistency

// Remove MySQLi connection since we use PDO below

// Define DSN for PDO
$dsn = "mysql:host=$host;port=$port;dbname=$dbname;charset=utf8mb4";

$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}

$name = trim($_POST['name'] ?? '');
$email = trim($_POST['email'] ?? '');
$phone = trim($_POST['phone'] ?? '');

$errors = [];

// Validate inputs
if ($name === '') {
    $errors[] = "Name is required.";
}
if ($email === '' || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
    $errors[] = "Valid email is required.";
}

if (!empty($errors)) {
    foreach ($errors as $error) {
        echo "<p style='color:red;'>$error</p>";
    }
    echo "<p><a href='register-user.html'>Go back</a></p>";
    exit;
}

// Check if email already exists
try {
    $stmt = $pdo->prepare("SELECT COUNT(*) FROM registered_users WHERE email = ?");
    $stmt->execute([$email]);
    if ($stmt->fetchColumn() > 0) {
        echo "<p style='color:red;'>Email already registered. Please use another email.</p>";
        echo "<p><a href='register-user.html'>Go back</a></p>";
        exit;
    }
} catch (PDOException $e) {
    echo "<p style='color:red;'>Error checking email: " . htmlspecialchars($e->getMessage()) . "</p>";
    exit;
}

// Insert new user
try {
    $insertStmt = $pdo->prepare("INSERT INTO registered_users (name, email, phone) VALUES (?, ?, ?)");
    $insertStmt->execute([$name, $email, $phone]);
    echo "<p style='color:green;'>User '$name' registered successfully.</p>";
    echo "<p><a href='register-user.html'>Register another user</a> | <a href='index.html'>Home</a></p>";
} catch (PDOException $e) {
    echo "<p style='color:red;'>Failed to register user: " . htmlspecialchars($e->getMessage()) . "</p>";
    echo "<p><a href='register-user.html'>Go back</a></p>";
}
?>

