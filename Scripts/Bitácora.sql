use tienda_ropa;

CREATE TABLE bitacora_sistema (
    id_bitacora INT AUTO_INCREMENT PRIMARY KEY,
    usuario VARCHAR(50),
    accion VARCHAR(100),
    tabla_afectada VARCHAR(50),
    fecha_hora DATETIME DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO bitacora_sistema (usuario, accion, tabla_afectada) VALUES 
('root', 'Inserción de nueva prenda: Camisa Oxford', 'prenda'),
('admin', 'Actualización de precio id_prenda: 3', 'actualizacion'),
('root', 'Eliminación de proveedor id: 6', 'proveedor'),
('user_ventas', 'Registro de movimiento de stock: entrada', 'movimiento_stock'),
('admin', 'Modificación de categoría: Caballero', 'categoria');

SELECT * FROM bitacora_sistema;