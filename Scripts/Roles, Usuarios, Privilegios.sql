-- 1. ASEGURAR EL USO DE LA BASE DE DATOS CORRECTA
USE tienda_ropa;

-- 2. LIMPIEZA DE ENTORNO (Opcional, para evitar errores al re-ejecutar)
DROP ROLE IF EXISTS 'rol_admin';
DROP ROLE IF EXISTS 'rol_empleado';
DROP ROLE IF EXISTS 'rol_consulta';

-- 3. CREACIÓN DE USUARIOS
-- Nota: Asegúrate de que no existan previamente o bórralos con DROP USER si es necesario
CREATE USER IF NOT EXISTS 'admin_tienda'@'localhost' IDENTIFIED BY 'Admin123!';
CREATE USER IF NOT EXISTS 'empleado_tienda'@'localhost' IDENTIFIED BY 'Empleado123!';
CREATE USER IF NOT EXISTS 'consulta_tienda'@'localhost' IDENTIFIED BY 'Consulta123!';

-- 4. CREACIÓN DE ROLES
CREATE ROLE 'rol_admin';
CREATE ROLE 'rol_empleado';
CREATE ROLE 'rol_consulta';

-- 5. ASIGNACIÓN DE PRIVILEGIOS A ROLES

-- Privilegios para el Administrador
GRANT ALL PRIVILEGES ON tienda_ropa.* TO 'rol_admin';

-- Privilegios para el Empleado (Operativo)
GRANT SELECT, INSERT, UPDATE ON tienda_ropa.prenda TO 'rol_empleado';
GRANT SELECT, INSERT, UPDATE ON tienda_ropa.movimiento_stock TO 'rol_empleado';
GRANT SELECT, INSERT ON tienda_ropa.registro TO 'rol_empleado';
GRANT SELECT ON tienda_ropa.proveedor TO 'rol_empleado';
GRANT SELECT ON tienda_ropa.categoria TO 'rol_empleado';
GRANT SELECT ON tienda_ropa.color TO 'rol_empleado';
GRANT SELECT ON tienda_ropa.talla TO 'rol_empleado';

-- Privilegios para Consulta (Solo lectura)
GRANT SELECT ON tienda_ropa.* TO 'rol_consulta';

-- 6. ASIGNAR ROLES A USUARIOS
GRANT 'rol_admin' TO 'admin_tienda'@'localhost';
GRANT 'rol_empleado' TO 'empleado_tienda'@'localhost';
GRANT 'rol_consulta' TO 'consulta_tienda'@'localhost';

-- 7. CORRECCIÓN IMPORTANTE: ACTIVACIÓN DE ROLES
-- Esto permite que los privilegios del rol funcionen al iniciar sesión
SET DEFAULT ROLE ALL TO 
    'admin_tienda'@'localhost', 
    'empleado_tienda'@'localhost', 
    'consulta_tienda'@'localhost';

-- 8. CREACIÓN DE VISTAS (REPORTES)
CREATE OR REPLACE VIEW vw_prendas_detalle AS 
SELECT P.id_prenda, P.nombre, P.precio, P.stock_actual, C.nombre AS categoria, T.talla, CO.nombre AS color
FROM prenda P 
JOIN categoria C ON P.id_categoria = C.id_categoria
JOIN talla T ON P.id_talla = T.id_talla 
JOIN color CO ON P.id_color = CO.id_color;

CREATE OR REPLACE VIEW vw_movimientos_stock AS 
SELECT M.id_movimiento, M.fecha, M.tipo_movimiento, M.cantidad, P.nombre AS prenda, E.nombre AS empleado
FROM movimiento_stock M 
JOIN prenda P ON M.id_prenda = P.id_prenda
JOIN empleado E ON M.id_empleado = E.id_empleado;

CREATE OR REPLACE VIEW vw_historial_precios AS 
SELECT A.id_actualizacion, A.fecha, P.nombre AS prenda, A.precio_anterior, A.precio_nuevo, E.nombre AS empleado
FROM actualizacion A 
JOIN prenda P ON A.id_prenda = P.id_prenda
JOIN empleado E ON A.id_empleado = E.id_empleado;

CREATE OR REPLACE VIEW vw_registro_proveedores AS 
SELECT R.id_registro, R.fecha_registro, P.nombre AS prenda, E.nombre AS empleado, PR.nombre AS proveedor
FROM registro R 
JOIN prenda P ON R.id_prenda = P.id_prenda
JOIN empleado E ON R.id_empleado = E.id_empleado
JOIN proveedor PR ON R.id_proveedor = PR.id_proveedor;

-- 9. VERIFICACIÓN FINAL
FLUSH PRIVILEGES;

-- Pruebas de lectura
SELECT * FROM vw_prendas_detalle;
SELECT * FROM vw_movimientos_stock;
SELECT * FROM vw_historial_precios;
SELECT * FROM vw_registro_proveedores;

-- Comprobar usuarios creados
SELECT user, host FROM mysql.user WHERE user IN ('admin_tienda', 'empleado_tienda', 'consulta_tienda');