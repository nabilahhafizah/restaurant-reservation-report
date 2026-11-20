<?php
$conn = new mysqli("localhost", "root", "", "restaurant_db");
if ($conn->connect_error) { die("Connection failed: " . $conn->connect_error); }

$result = null;
$date = "";

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $date = $_POST["reservation_date"];

    $sql = "SELECT c.customer_id, c.first_name, c.last_name, c.contact_no, c.other_details,
                   b.number_of_party, t.table_no, t.table_details,
                   s.staff_id, s.staff_first_name, s.staff_last_name,
                   m.menu_id, m.menu_quantity
            FROM customer c
            INNER JOIN booking b        ON c.booking_id = b.booking_id
            INNER JOIN table_reserved t ON b.table_no   = t.table_no
            INNER JOIN order_reserved o ON t.order_id   = o.order_id
            INNER JOIN staff s          ON o.staff_id   = s.staff_id
            INNER JOIN menu m           ON o.menu_id    = m.menu_id
            WHERE b.booking_date = ?";

    $stmt = $conn->prepare($sql);
    $stmt->bind_param("s", $date);
    $stmt->execute();
    $result = $stmt->get_result();
}
?>
<!DOCTYPE html>
<html>
<head>
  <title>Restaurant Reservation Report</title>
  <style>
    body { font-family: Arial, sans-serif; margin: 30px; }
    table { border-collapse: collapse; margin-top: 20px; }
    th, td { border: 1px solid #333; padding: 6px 10px; }
    th { background: #eee; }
  </style>
</head>
<body>
  <h2>Restaurant Reservation Report</h2>

  <form method="post">
    <label>Reservation Date</label>
    <input type="date" name="reservation_date" value="<?= htmlspecialchars($date) ?>" required>
    <button type="submit">Submit</button>
  </form>

  <?php if ($result !== null): ?>
    <table>
      <tr>
        <th>Customer ID</th><th>Customer First Name</th><th>Customer Last Name</th>
        <th>Contact No.</th><th>Other Details</th><th>Number of Party</th>
        <th>Table No.</th><th>Table Details</th><th>Staff ID</th>
        <th>Staff First name</th><th>Staff Last name</th><th>Menu ID</th><th>Menu Quantity</th>
      </tr>
      <?php if ($result->num_rows > 0): ?>
        <?php while ($row = $result->fetch_assoc()): ?>
          <tr>
            <?php foreach ($row as $value): ?>
              <td><?= htmlspecialchars($value) ?></td>
            <?php endforeach; ?>
          </tr>
        <?php endwhile; ?>
      <?php else: ?>
        <tr><td colspan="13">No reservations found for this date.</td></tr>
      <?php endif; ?>
    </table>
  <?php endif; ?>
</body>
</html>