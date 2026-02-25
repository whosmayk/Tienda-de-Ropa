<?php 
include 'db.php'; 

// 1. Lógica para INSERTAR (El ID se asigna solo por ser AUTO_INCREMENT)
if(isset($_POST['add'])){
    $stmt = $conn->prepare("INSERT INTO color (nombre) VALUES (?)");
    $stmt->execute([$_POST['nombre']]);
    header("Location: colores.php?msg=creado");
}

// 2. Lógica para ACTUALIZAR
if(isset($_POST['update'])){
    $stmt = $conn->prepare("UPDATE color SET nombre = ? WHERE id_color = ?");
    $stmt->execute([$_POST['nombre'], $_POST['id_color']]);
    header("Location: colores.php?msg=actualizado");
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Colores - Tienda Ropa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <?php include 'header.php'; ?>
    <div class="container">
        <div class="row">
            <!-- Formulario Lateral -->
            <div class="col-md-4">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-dark text-white">Nuevo Color</div>
                    <form class="card-body" method="POST">
                        <div class="mb-3">
                            <label class="form-label small">Nombre del Color</label>
                            <input type="text" name="nombre" class="form-control" placeholder="Ej. Azul Turquesa" required>
                            <div class="form-text text-muted">El ID se asignará automáticamente.</div>
                        </div>
                        <button name="add" class="btn btn-primary w-100">Guardar Color</button>
                    </form>
                </div>
            </div>

            <!-- Tabla de Colores -->
            <div class="col-md-8">
                <div class="card shadow-sm border-0">
                    <table class="table table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Nombre del Color</th>
                                <th class="text-center">Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $res = $conn->query("SELECT * FROM color ORDER BY id_color ASC");
                            while($row = $res->fetch()){
                                echo "<tr>
                                        <td>{$row['id_color']}</td>
                                        <td><strong>{$row['nombre']}</strong></td>
                                        <td class='text-center'>
                                            <button class='btn btn-sm btn-warning' 
                                                onclick='abrirEditar({$row['id_color']}, \"{$row['nombre']}\")'>
                                                Editar
                                            </button>
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
    <div class="modal fade" id="modalEditarColor" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Modificar Color</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="id_color" id="edit_id">
                        <div class="mb-3">
                            <label class="form-label">Nombre del Color</label>
                            <input type="text" name="nombre" id="edit_nombre" class="form-control" required>
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
    function abrirEditar(id, nombre) {
        document.getElementById('edit_id').value = id;
        document.getElementById('edit_nombre').value = nombre;
        
        var myModal = new bootstrap.Modal(document.getElementById('modalEditarColor'));
        myModal.show();
    }
    </script>
</body>
</html>