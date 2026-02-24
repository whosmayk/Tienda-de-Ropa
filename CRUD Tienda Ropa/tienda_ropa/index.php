<?php 
include 'db.php'; 

// 1. Configuración de Ordenamiento
$columnas_permitidas = [
    'id' => 'p.id_prenda',
    'nombre' => 'p.nombre',
    'precio' => 'p.precio',
    'stock' => 'p.stock_actual',
    'categoria' => 'c.nombre',
    'talla' => 't.talla',
    'color' => 'col.nombre'
];

$sort = isset($_GET['sort']) && array_key_exists($_GET['sort'], $columnas_permitidas) ? $_GET['sort'] : 'id';
$order = isset($_GET['order']) && strtolower($_GET['order']) === 'desc' ? 'DESC' : 'ASC';

// 2. Configuración de Búsqueda
$search = isset($_GET['search']) ? $_GET['search'] : '';

// 3. Función para generar links que mantengan tanto el orden como la búsqueda
function getHeaderLink($col_key, $label, $current_sort, $current_order, $current_search) {
    $next_order = ($current_sort === $col_key && $current_order === 'ASC') ? 'desc' : 'asc';
    $icon = ($current_sort === $col_key) ? ($current_order === 'ASC' ? ' ▲' : ' ▼') : '';
    
    // Construimos la URL manteniendo el parámetro de búsqueda si existe
    $url = "?sort={$col_key}&order={$next_order}";
    if (!empty($current_search)) {
        $url .= "&search=" . urlencode($current_search);
    }
    
    return "<a href='{$url}' class='text-white text-decoration-none d-block'>{$label}{$icon}</a>";
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Inventario - Tienda de Ropa</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">
    <?php include 'header.php'; ?>
    <div class="container mt-5">
        <div class="row mb-4">
            <div class="col-md-4">
                <h2>Inventario</h2>
            </div>
            <!-- Formulario de Búsqueda -->
            <div class="col-md-5">
                <form method="GET" class="d-flex">
                    <!-- Mantenemos el orden actual oculto para no perderlo al buscar -->
                    <input type="hidden" name="sort" value="<?= $sort ?>">
                    <input type="hidden" name="order" value="<?= $order ?>">
                    
                    <input type="text" name="search" class="form-control me-2" 
                           placeholder="Buscar por nombre, color, talla..." 
                           value="<?= htmlspecialchars($search) ?>">
                    <button type="submit" class="btn btn-outline-primary">Buscar</button>
                    <?php if(!empty($search)): ?>
                        <a href="index.php" class="btn btn-outline-secondary ms-1">Limpiar</a>
                    <?php endif; ?>
                </form>
            </div>
            <div class="col-md-3 text-end">
                <a href="crear.php" class="btn btn-primary">Nueva Prenda</a>
            </div>
        </div>

        <div class="table-responsive shadow border-0">
            <table class="table table-hover bg-white mb-0">
                <thead class="table-dark">
                    <tr>
                        <th><?= getHeaderLink('id', 'ID', $sort, $order, $search) ?></th>
                        <th><?= getHeaderLink('nombre', 'Nombre', $sort, $order, $search) ?></th>
                        <th><?= getHeaderLink('precio', 'Precio', $sort, $order, $search) ?></th>
                        <th><?= getHeaderLink('stock', 'Stock', $sort, $order, $search) ?></th>
                        <th><?= getHeaderLink('categoria', 'Categoría', $sort, $order, $search) ?></th>
                        <th><?= getHeaderLink('talla', 'Talla', $sort, $order, $search) ?></th>
                        <th><?= getHeaderLink('color', 'Color', $sort, $order, $search) ?></th>
                        <th class="text-center">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    // Construcción de la consulta con filtros
                    $columna_sql = $columnas_permitidas[$sort];
                    
                    $sql = "SELECT p.*, c.nombre as cat_nom, t.talla as talla_nom, col.nombre as color_nom 
                            FROM prenda p
                            JOIN categoria c ON p.id_categoria = c.id_categoria
                            JOIN talla t ON p.id_talla = t.id_talla
                            JOIN color col ON p.id_color = col.id_color";

                    // Si hay búsqueda, añadimos las condiciones
                    if (!empty($search)) {
                        $sql .= " WHERE p.nombre LIKE :busqueda 
                                  OR c.nombre LIKE :busqueda 
                                  OR col.nombre LIKE :busqueda 
                                  OR t.talla LIKE :busqueda 
                                  OR p.precio LIKE :busqueda 
                                  OR p.id_prenda = :busqueda_exacta";
                    }

                    $sql .= " ORDER BY {$columna_sql} {$order}";

                    $stmt = $conn->prepare($sql);
                    
                    if (!empty($search)) {
                        $term = "%$search%";
                        $stmt->bindParam(':busqueda', $term);
                        $stmt->bindParam(':busqueda_exacta', $search);
                    }
                    
                    $stmt->execute();

                    if ($stmt->rowCount() > 0) {
                        while ($row = $stmt->fetch(PDO::FETCH_ASSOC)) {
                            echo "<tr>
                                    <td>{$row['id_prenda']}</td>
                                    <td><strong>{$row['nombre']}</strong></td>
                                    <td>\${$row['precio']}</td>
                                    <td>{$row['stock_actual']}</td>
                                    <td>{$row['cat_nom']}</td>
                                    <td class='text-uppercase'>{$row['talla_nom']}</td>
                                    <td>{$row['color_nom']}</td>
                                    <td class='text-center'>
                                        <a href='editar.php?id={$row['id_prenda']}' class='btn btn-sm btn-outline-warning'>Editar</a>
                                        <a href='eliminar.php?id={$row['id_prenda']}' class='btn btn-sm btn-outline-danger' onclick='return confirm(\"¿Eliminar?\")'>Borrar</a>
                                    </td>
                                  </tr>";
                        }
                    } else {
                        echo "<tr><td colspan='8' class='text-center py-4 text-muted'>No se encontraron prendas que coincidan con la búsqueda.</td></tr>";
                    }
                    ?>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>