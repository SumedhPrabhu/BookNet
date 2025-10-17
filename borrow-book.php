<?php
$host = 'localhost';
$port = 3307;
$dbname = 'library_management';
$user = 'root';    // renamed $dbuser to $user for PDO consistency
$pass = '';        // renamed $dbpass to $pass

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

$book_id = (int)($_POST['book_id'] ?? 0);
$user_id = (int)($_POST['user_id'] ?? 0);
$due_date = $_POST['due_date'] ?? '';

$errors = [];

// Validate input
if ($book_id <= 0) {
    $errors[] = "Invalid Book ID.";
}
if ($user_id <= 0) {
    $errors[] = "Invalid User ID.";
}
if (!$due_date || !preg_match('/^\d{4}-\d{2}-\d{2}$/', $due_date)) {
    $errors[] = "Please provide a valid due date.";
}

// Check book and user existence and availability
if (empty($errors)) {
    // Check book exists and has available copies
    $stmt = $pdo->prepare("SELECT available_copies, title FROM books WHERE book_id = ?");
    $stmt->execute([$book_id]);
    $book = $stmt->fetch();

    if (!$book) {
        $errors[] = "Book not found.";
    } elseif ($book['available_copies'] < 1) {
        $errors[] = "No available copies for this book.";
    }

    // Check user exists
    $stmt = $pdo->prepare("SELECT name FROM registered_users WHERE user_id = ?");
    $stmt->execute([$user_id]);
    $user = $stmt->fetch();

    if (!$user) {
        $errors[] = "User not found.";
    }
}

if (!empty($errors)) {
    foreach ($errors as $error) {
        echo "<p style='color:red;'>$error</p>";
    }
    echo "<p><a href='borrow-book.html'>Go back</a></p>";
    exit;
}

// Insert borrow record and update book availability inside a transaction
try {
    $pdo->beginTransaction();

    // Insert into borrowed_books
    $insertStmt = $pdo->prepare("INSERT INTO borrowed_books (book_id, user_id, due_date, returned) VALUES (?, ?, ?, FALSE)");
    $insertStmt->execute([$book_id, $user_id, $due_date]);

    // Update available_copies
    $updateStmt = $pdo->prepare("UPDATE books SET available_copies = available_copies - 1 WHERE book_id = ?");
    $updateStmt->execute([$book_id]);

    $pdo->commit();

    echo "<p style='color:green;'>Book '{$book['title']}' successfully borrowed by {$user['name']}. Due date: {$due_date}.</p>";
    echo "<p><a href='borrow-book.html'>Borrow another book</a> | <a href='index.html'>Home</a></p>";
} catch (PDOException $e) {
    $pdo->rollBack();
    echo "<p style='color:red;'>Failed to borrow book: " . htmlspecialchars($e->getMessage()) . "</p>";
    echo "<p><a href='borrow-book.html'>Go back</a></p>";
}
?>


