<?php 
include 'db.php'; 

// 1. Lógica para INSERTAR (El ID se asigna solo por ser AUTO_INCREMENT)
if(isset($_POST['add'])){
    $stmt = $conn->prepare("INSERT INTO talla (talla) VALUES (?)");
    $stmt->execute([$_POST['talla']]);
    header("Location: tallas.php?msg=creado");
}

// 2. Lógica para ACTUALIZAR
if(isset($_POST['update'])){
    $stmt = $conn->prepare("UPDATE talla SET talla = ? WHERE id_talla = ?");
    $stmt->execute([$_POST['talla'], $_POST['id_talla']]);
    header("Location: tallas.php?msg=actualizado");
}

// 3. Lógica para ELIMINAR
if(isset($_GET['delete'])){
    try {
        $stmt = $conn->prepare("DELETE FROM talla WHERE id_talla = ?");
        $stmt->execute([$_GET['delete']]);
        header("Location: tallas.php?msg=eliminado");
    } catch (Exception $e) {
        // Error común: La talla tiene registros asociados en la tabla 'registro'
        $error = "No se puede eliminar esta talla porque tiene registros de mercancía asociados.";
    }
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Tallas - Tienda Ropa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <?php include 'header.php'; ?>
    <div class="container">
        <div class="row">
            <!-- Formulario Lateral -->
            <div class="col-md-4">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-dark text-white">Nueva Talla</div>
                    <form class="card-body" method="POST">
                        <div class="mb-3">
                            <label class="form-label small">Nombre de la Talla</label>
                            <input type="text" name="talla" class="form-control" placeholder="Ej. ech, eg" required>
                            <div class="form-text text-muted">El ID se asignará automáticamente.</div>
                        </div>
                        <button name="add" class="btn btn-primary w-100">Guardar Talla</button>
                    </form>
                </div>
            </div>

            <!-- Tabla de Tallas -->
            <div class="col-md-8">
                <div class="card shadow-sm border-0">
                    <table class="table table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Nombre de la Talla</th>
                                <th class="text-center">Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $res = $conn->query("SELECT * FROM talla ORDER BY id_talla ASC");
                            while($row = $res->fetch()){
                                echo "<tr>
                                        <td>{$row['id_talla']}</td>
                                        <td><strong>{$row['talla']}</strong></td>
                                        <td class='text-center'>
                                            <div class='btn-group'>
                                                <button class='btn btn-sm btn-warning' 
                                                    onclick='abrirEditar({$row['id_talla']}, \"{$row['talla']}\")'>
                                                    Editar
                                                </button>
                                                <a href='tallas.php?delete={$row['id_talla']}' 
                                                   class='btn btn-sm btn-danger' 
                                                   onclick='return confirm(\"¿Estás seguro de eliminar esta talla?\")'>
                                                    Eliminar
                                                </a>
                                            </div>
                                        </td>
                                      </tr>";
                            }
                            ?>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>

    <!-- MODAL PARA EDITAR -->
    <div class="modal fade" id="modalEditarTalla" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Modificar Talla</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="id_talla" id="edit_id">
                        <div class="mb-3">
                            <label class="form-label">Nombre de la Talla</label>
                            <input type="text" name="talla" id="edit_talla" class="form-control" required>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cerrar</button>
                        <button type="submit" name="update" class="btn btn-primary">Actualizar Cambios</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
    function abrirEditar(id, talla) {
        document.getElementById('edit_id').value = id;
        document.getElementById('edit_talla').value = talla;
        
        var myModal = new bootstrap.Modal(document.getElementById('modalEditarTalla'));
        myModal.show();
    }
    </script>
</body>
</html>