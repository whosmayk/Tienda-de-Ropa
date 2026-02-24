<?php 
include 'db.php'; 
if(isset($_POST['save'])){
    $stmt = $conn->prepare("INSERT INTO color (id_color, nombre) VALUES (?, ?)");
    $stmt->execute([$_POST['id_color'], $_POST['nombre']]);
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"><title>Colores</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <?php include 'header.php'; ?>
    <div class="container">
        <div class="row">
            <div class="col-md-4">
                <form class="card card-body shadow-sm" method="POST">
                    <h5>Nuevo Color</h5>
                    <input type="text" name="id_color" class="form-control mb-2" placeholder="ID Color" required>
                    <input type="text" name="nombre" class="form-control mb-2" placeholder="Nombre" required>
                    <button name="save" class="btn btn-dark w-100">Guardar</button>
                </form>
            </div>
            <div class="col-md-8">
                <table class="table bg-white shadow-sm">
                    <thead class="table-dark"><tr><th>ID</th><th>Nombre</th></tr></thead>
                    <tbody>
                        <?php
                        $res = $conn->query("SELECT * FROM color");
                        while($row = $res->fetch()) echo "<tr><td>{$row['id_color']}</td><td>{$row['nombre']}</td></tr>";
                        ?>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>