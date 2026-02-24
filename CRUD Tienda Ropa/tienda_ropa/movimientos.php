<?php 
include 'db.php'; 
if(isset($_POST['registrar_mov'])){
    $stmt = $conn->prepare("INSERT INTO movimiento_stock (tipo_movimiento, cantidad, id_prenda, id_empleado) VALUES (?, ?, ?, ?)");
    $stmt->execute([$_POST['tipo'], $_POST['cant'], $_POST['prenda'], $_POST['emp']]);
    
    // Opcional: Actualizar el stock_actual en la tabla 'prenda' automáticamente
    $operador = ($_POST['tipo'] == 'entrada') ? "+" : "-";
    if($_POST['tipo'] == 'ajuste') $operador = "+"; // El ajuste ya trae el signo en el dump
    
    $conn->query("UPDATE prenda SET stock_actual = stock_actual $operador {$_POST['cant']} WHERE id_prenda = {$_POST['prenda']}");
    header("Location: movimientos.php");
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8"><title>Movimientos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <?php include 'header.php'; ?>
    <div class="container">
        <h3>Movimientos de Inventario</h3>
        <div class="card mb-4 shadow-sm border-0">
            <form class="card-body row" method="POST">
                <div class="col-md-3">
                    <label>Prenda</label>
                    <select name="prenda" class="form-select">
                        <?php $ps = $conn->query("SELECT id_prenda, nombre FROM prenda"); 
                              while($p = $ps->fetch()) echo "<option value='{$p['id_prenda']}'>{$p['nombre']}</option>"; ?>
                    </select>
                </div>
                <div class="col-md-2">
                    <label>Tipo</label>
                    <select name="tipo" class="form-select">
                        <option value="entrada">Entrada</option>
                        <option value="salida">Salida</option>
                        <option value="ajuste">Ajuste</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label>Cantidad</label>
                    <input type="number" name="cant" class="form-control" required>
                </div>
                <div class="col-md-3">
                    <label>Empleado que autoriza</label>
                    <select name="emp" class="form-select">
                        <?php $es = $conn->query("SELECT id_empleado, nombre FROM empleado"); 
                              while($e = $es->fetch()) echo "<option value='{$e['id_empleado']}'>{$e['nombre']}</option>"; ?>
                    </select>
                </div>
                <div class="col-md-2 d-flex align-items-end">
                    <button name="registrar_mov" class="btn btn-success w-100">Registrar</button>
                </div>
            </form>
        </div>

        <table class="table table-striped bg-white shadow-sm">
            <thead class="table-dark">
                <tr><th>Fecha</th><th>Prenda</th><th>Tipo</th><th>Cant.</th><th>Empleado</th></tr>
            </thead>
            <tbody>
                <?php
                $sql = "SELECT m.*, p.nombre as p_nom, e.nombre as e_nom FROM movimiento_stock m 
                        JOIN prenda p ON m.id_prenda = p.id_prenda 
                        JOIN empleado e ON m.id_empleado = e.id_empleado ORDER BY fecha DESC";
                $res = $conn->query($sql);
                while($row = $res->fetch()){
                    $clase = ($row['tipo_movimiento'] == 'entrada') ? 'text-success' : 'text-danger';
                    echo "<tr>
                            <td>{$row['fecha']}</td>
                            <td>{$row['p_nom']}</td>
                            <td class='fw-bold $clase'>".strtoupper($row['tipo_movimiento'])."</td>
                            <td>{$row['cantidad']}</td>
                            <td>{$row['e_nom']}</td>
                          </tr>";
                }
                ?>
            </tbody>
        </table>
    </div>
</body>
</html>