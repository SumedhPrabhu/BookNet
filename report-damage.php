<?php
$host = 'localhost';
$port = 3307;
$dbname = 'library_management';
$user = 'root';
$pass = '';

// Define DSN for PDO connection
$dsn = "mysql:host=$host;port=$port;dbname=$dbname;charset=utf8mb4";

$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    // Create PDO instance using defined DSN and credentials
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}

$book_id = $_POST['book_id'] ?? null;
$user_id = $_POST['user_id'] ?? null;
$description = trim($_POST['description'] ?? '');
$penalty = $_POST['penalty'] ?? null;

$errors = [];

// Validate required fields
if (!$book_id || !filter_var($book_id, FILTER_VALIDATE_INT, ["options" => ["min_range" => 1]])) {
    $errors[] = "Valid Book ID is required.";
}
if (!$user_id || !filter_var($user_id, FILTER_VALIDATE_INT, ["options" => ["min_range" => 1]])) {
    $errors[] = "Valid User ID is required.";
}
if ($description === '') {
    $errors[] = "Damage description is required.";
}
// penalty is optional but if provided should be numeric and >=0
if ($penalty !== null && $penalty !== '' && (!is_numeric($penalty) || $penalty < 0)) {
    $errors[] = "Penalty amount must be a positive number or left empty.";
}

if (!empty($errors)) {
    foreach ($errors as $error) {
        echo "<p style='color:red;'>$error</p>";
    }
    echo "<p><a href='report-damage.html'>Go back</a></p>";
    exit;
}

// Check if book_id exists
$stmt = $pdo->prepare("SELECT COUNT(*) FROM books WHERE book_id = ?");
$stmt->execute([$book_id]);
if ($stmt->fetchColumn() == 0) {
    echo "<p style='color:red;'>Book ID does not exist.</p>";
    echo "<p><a href='report-damage.html'>Go back</a></p>";
    exit;
}

// Check if user_id exists
$stmt = $pdo->prepare("SELECT COUNT(*) FROM registered_users WHERE user_id = ?");
$stmt->execute([$user_id]);
if ($stmt->fetchColumn() == 0) {
    echo "<p style='color:red;'>User ID does not exist.</p>";
    echo "<p><a href='report-damage.html'>Go back</a></p>";
    exit;
}

// Insert damage report
try {
    $insertStmt = $pdo->prepare("INSERT INTO damaged_books (book_id, user_id, damage_description, penalty_amount) VALUES (?, ?, ?, ?)");
    $penalty_val = ($penalty === '' || $penalty === null) ? null : $penalty;
    $insertStmt->execute([$book_id, $user_id, $description, $penalty_val]);

    echo "<p style='color:green;'>Damage reported successfully.</p>";
    echo "<p><a href='report-damage.html'>Report another damage</a> | <a href='index.html'>Home</a></p>";
} catch (PDOException $e) {
    echo "<p style='color:red;'>Failed to report damage: " . htmlspecialchars($e->getMessage()) . "</p>";
    echo "<p><a href='report-damage.html'>Go back</a></p>";
}
?>

