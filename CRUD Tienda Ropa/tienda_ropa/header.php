<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-4 shadow">
    <div class="container">
        <a class="navbar-brand font-weight-bold" href="index.php">👕 TiendaRopa</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link" href="index.php">Prendas</a></li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Catálogos de gestión</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="categorias.php">Categorías</a></li>
                        <li><a class="dropdown-item" href="colores.php">Colores</a></li>
                        <li><a class="dropdown-item" href="tallas.php">Tallas</a></li>
                        <li><a class="dropdown-item" href="empleados.php">Empleados</a></li>
                        <li><a class="dropdown-item" href="proveedores.php">Proveedores</a></li>
                    </ul>
                </li>
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">Historial y Stock</a>
                    <ul class="dropdown-menu">
                        <li><a class="dropdown-item" href="movimientos.php">Movimientos de Stock</a></li>
                        <li><a class="dropdown-item" href="actualizaciones.php">Cambios de Precios</a></li>
                        <li><a class="dropdown-item" href="registros.php">Registros de Entrada</a></li>
                    </ul>
                </li>
            </ul>
        </div>
    </div>
</nav>
<!-- Importante: Agregar Scripts de Bootstrap para los dropdowns -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>