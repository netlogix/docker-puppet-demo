<html>
	<head>
		<meta charset="utf8"/>
		<title>App 1</title>
		<style>
			body {
				font-family: sans-serif;
			}
			h1 {
				text-align: center;
				margin-top: 1em;
				font-size: 72pt;
			}
			p {
				text-align: center;
				font-size: 18pt;
				margin-top: 2em;
			}
		</style>
	</head>
	<body>
		<h1>App 1</h1>
		<?php
			try {
				$pdo = new \PDO('mysql:host=db;dbname=app1', 'app1', 'app1');

				echo '<p>Successfully connected to the database!</p>';
			} catch (\Throwable $e) {
				echo "<p style='color: red'>Failed to connect to the database:<br /> {$e->getMessage()}</p>";
			}
		?>

	</body>
</html>
