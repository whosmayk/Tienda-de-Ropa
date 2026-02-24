<?php include 'db.php'; ?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"><title>Historial de Precios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <?php include 'header.php'; ?>
    <div class="container">
        <h3>Historial de Actualización de Precios</h3>
        <table class="table table-bordered bg-white shadow-sm mt-3">
            <thead class="table-warning">
                <tr><th>Fecha</th><th>Prenda</th><th>Precio Anterior</th><th>Precio Nuevo</th><th>Empleado</th></tr>
            </thead>
            <tbody>
                <?php
                $sql = "SELECT a.*, p.nombre as p_nom, e.nombre as e_nom FROM actualizacion a 
                        JOIN prenda p ON a.id_prenda = p.id_prenda 
                        JOIN empleado e ON a.id_empleado = e.id_empleado ORDER BY fecha DESC";
                $res = $conn->query($sql);
                while($row = $res->fetch()){
                    echo "<tr>
                            <td>{$row['fecha']}</td>
                            <td>{$row['p_nom']}</td>
                            <td><s>\${$row['precio_anterior']}</s></td>
                            <td class='text-success fw-bold'>\${$row['precio_nuevo']}</td>
                            <td>{$row['e_nom']}</td>
                          </tr>";
                }
                ?>
            </tbody>
        </table>
    </div>
</body>
</html>