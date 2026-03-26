use tienda_ropa;

START TRANSACTION;
-- Paso 1: Insertar el movimiento
INSERT INTO movimiento_stock (tipo_movimiento, cantidad, id_prenda, id_empleado) 
VALUES ('entrada', 10, 1, 1);
-- Paso 2: Actualizar el stock en la tabla prenda
UPDATE prenda SET stock_actual = stock_actual + 10 WHERE id_prenda = 1;
COMMIT;

START TRANSACTION;
-- Paso 1: Registramos la actualización de precio
INSERT INTO actualizacion (precio_anterior, precio_nuevo, id_prenda, id_empleado) 
VALUES (450.00, 500.00, 1, 999); -- Empleado 999 no existe
ROLLBACK;

