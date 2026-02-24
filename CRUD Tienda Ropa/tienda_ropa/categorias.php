<?php 
include 'db.php'; 

// 1. Lógica para INSERTAR
if(isset($_POST['add'])){
    $stmt = $conn->prepare("INSERT INTO categoria (nombre, descripcion) VALUES (?, ?)");
    $stmt->execute([$_POST['nombre'], $_POST['descripcion']]);
    header("Location: categorias.php?msg=creada");
}

// 2. Lógica para ACTUALIZAR
if(isset($_POST['update'])){
    $stmt = $conn->prepare("UPDATE categoria SET nombre = ?, descripcion = ? WHERE id_categoria = ?");
    $stmt->execute([$_POST['nombre'], $_POST['descripcion'], $_POST['id_categoria']]);
    header("Location: categorias.php?msg=actualizada");
}
?>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Categorías - Tienda Ropa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <?php include 'header.php'; ?>
    <div class="container">
        <div class="row">
            <!-- Formulario Lateral -->
            <div class="col-md-4">
                <div class="card shadow-sm border-0">
                    <div class="card-header bg-dark text-white">Nueva Categoría</div>
                    <form class="card-body" method="POST">
                        <div class="mb-3">
                            <label class="form-label small">Nombre de la Categoría</label>
                            <input type="text" name="nombre" class="form-control" placeholder="Ej. Accesorios" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label small">Descripción</label>
                            <textarea name="descripcion" class="form-control" rows="3" placeholder="Breve descripción..."></textarea>
                        </div>
                        <button name="add" class="btn btn-primary w-100">Guardar Categoría</button>
                    </form>
                </div>
            </div>

            <!-- Tabla de Categorías -->
            <div class="col-md-8">
                <div class="card shadow-sm border-0">
                    <table class="table table-hover mb-0">
                        <thead class="table-dark">
                            <tr>
                                <th>ID</th>
                                <th>Nombre</th>
                                <th>Descripción</th>
                                <th class="text-center">Acción</th>
                            </tr>
                        </thead>
                        <tbody>
                            <?php
                            $res = $conn->query("SELECT * FROM categoria");
                            while($row = $res->fetch()){
                                $desc_js = addslashes($row['descripcion']);
                                // Corregido: class='text-center' con comillas simples
                                echo "<tr>
                                        <td>{$row['id_categoria']}</td>
                                        <td><strong>{$row['nombre']}</strong></td>
                                        <td><small>{$row['descripcion']}</small></td>
                                        <td class='text-center'>
                                            <button class='btn btn-sm btn-warning' 
                                                onclick='abrirEditar({$row['id_categoria']}, \"{$row['nombre']}\", \"{$desc_js}\")'>
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
    <div class="modal fade" id="modalEditarCat" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Modificar Categoría</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form method="POST">
                    <div class="modal-body">
                        <input type="hidden" name="id_categoria" id="edit_id">
                        <div class="mb-3">
                            <label class="form-label">Nombre</label>
                            <input type="text" name="nombre" id="edit_nombre" class="form-control" required>
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Descripción</label>
                            <textarea name="descripcion" id="edit_descripcion" class="form-control" rows="4"></textarea>
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
    function abrirEditar(id, nombre, descripcion) {
        document.getElementById('edit_id').value = id;
        document.getElementById('edit_nombre').value = nombre;
        document.getElementById('edit_descripcion').value = descripcion;
        
        var myModal = new bootstrap.Modal(document.getElementById('modalEditarCat'));
        myModal.show();
    }
    </script>
</body>
</html>