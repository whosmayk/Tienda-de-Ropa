<?php
include 'db.php';

if (isset($_GET['id'])) {
    $id = $_GET['id'];
    try {
        $stmt = $conn->prepare("DELETE FROM prenda WHERE id_prenda = ?");
        $stmt->execute([$id]);
    } catch (Exception $e) {
        // Esto previene errores si la prenda está siendo usada en las tablas 'registro' o 'actualizacion'
        echo "<script>alert('No se puede eliminar: Esta prenda tiene registros asociados en otras tablas.'); window.location='index.php';</script>";
        exit;
    }
}

header("Location: index.php");
?>