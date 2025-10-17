<?php
$host = 'localhost';
$port = 3307;
$dbname = 'library_management';
$user = 'root';    // changed from $dbuser
$pass = '';        // changed from $dbpass

// Define DSN for PDO
$dsn = "mysql:host=$host;port=$port;dbname=$dbname;charset=utf8mb4";

$options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
];

try {
    $pdo = new PDO($dsn, $user, $pass, $options);
} catch (\PDOException $e) {
    die("Database connection failed: " . $e->getMessage());
}

// Validate and sanitize input
$title = trim($_POST['title'] ?? '');
$author = trim($_POST['author'] ?? '');
$genre = trim($_POST['genre'] ?? null);
$publisher = trim($_POST['publisher'] ?? null);
$year = $_POST['year'] ?? null;
$copies = $_POST['copies'] ?? 1;

$errors = [];

// Basic validation
if ($title === '') {
    $errors[] = "Title is required.";
}
if ($author === '') {
    $errors[] = "Author is required.";
}
if ($year !== null && $year !== '' && (!is_numeric($year) || $year < 1000 || $year > 2025)) {
    $errors[] = "Year published must be a valid year between 1000 and 2025.";
}
if ($copies !== null) {
    $copies = (int)$copies;
    if ($copies < 1) {
        $errors[] = "Total copies must be at least 1.";
    }
} else {
    $copies = 1;
}

if (!empty($errors)) {
    foreach ($errors as $error) {
        echo "<p style='color:red;'>$error</p>";
    }
    echo "<p><a href='add-book.html'>Go back</a></p>";
    exit;
}

// Insert into DB
$sql = "INSERT INTO books (title, author, genre, publisher, year_published, total_copies, available_copies) 
        VALUES (:title, :author, :genre, :publisher, :year_published, :total_copies, :available_copies)";

$stmt = $pdo->prepare($sql);

try {
    $stmt->execute([
        ':title' => $title,
        ':author' => $author,
        ':genre' => $genre,
        ':publisher' => $publisher,
        ':year_published' => $year !== '' ? $year : null,
        ':total_copies' => $copies,
        ':available_copies' => $copies
    ]);
    echo "<p style='color:green;'>Book '$title' added successfully.</p>";
    echo "<p><a href='add-book.html'>Add another book</a> | <a href='index.html'>Home</a></p>";
} catch (PDOException $e) {
    echo "<p style='color:red;'>Failed to add book: " . htmlspecialchars($e->getMessage()) . "</p>";
    echo "<p><a href='add-book.html'>Go back</a></p>";
}
?>

