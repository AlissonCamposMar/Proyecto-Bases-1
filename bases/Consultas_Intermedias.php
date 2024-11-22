<?php
include('conexion.php');
require_once('fpdf/fpdf.php');
$con = connection();

// Consulta 1: Contar la cantidad de citas que ha realizado cada empleado, imprimiendo ID empleado, nombre empleado y detalles de la cita
$query5 = "SELECT E.id_Empleado, E.nombre01, E.apellido01, COUNT(C.id_Cita) AS cantidad_citas
           FROM Empleado E
           LEFT JOIN Cita C ON E.id_Empleado = C.id_Empleado
           GROUP BY E.id_Empleado";

$result5 = $con->query($query5);

if ($result5) {
    // Obtiene los resultados de la consulta
    $data1 = $result5->fetch_all(MYSQLI_ASSOC);

    // Verifica si hay resultados
    if (empty($data1)) {
        echo "No se encontraron empleados o citas.";
    } 
} else {
    // Si la consulta falla, muestra un mensaje de error
    echo "Error en la consulta: " . $con->error;
}

// Consulta 2: Obtener la cantidad total de productos que ha proporcionado cada proveedor.
$query6 = "SELECT 
        P.id_Proveedor, 
        P.nombre AS nombre_proveedor, 
        COUNT(DISTINCT PD.id_Producto) AS cantidad_productos
    FROM 
        Proveedor P
    LEFT JOIN 
        Pedido Pe ON P.id_Proveedor = Pe.id_Proveedor
    LEFT JOIN 
        Pedido_Detalle PD ON Pe.id_Pedido = PD.id_Pedido
    LEFT JOIN 
        Producto Pr ON PD.id_Producto = Pr.id_Producto
    GROUP BY 
        P.id_Proveedor";

$result6 = $con->query($query6);
$data2 = $result6->fetch_all(MYSQLI_ASSOC);





// Consulta 4: Listar las citas junto con los detalles del cliente, el empleado y el servicio para las citas programadas para un día específico.
$query8 = "SELECT 
    C.id_Cita, 
    C.fecha, 
    C.duracion, 
    CL.nombre01 AS nombre_cliente, 
    E.nombre01 AS nombre_empleado, 
    P.nombre AS nombre_producto, 
    PT.tipo AS tipo_producto
FROM 
    Cita C
INNER JOIN 
    Cliente CL ON C.id_Cliente = CL.id_Cliente
INNER JOIN 
    Empleado E ON C.id_Empleado = E.id_Empleado
INNER JOIN 
    Producto P ON C.id_Producto = P.id_Producto
INNER JOIN 
    Producto_Tipo PT ON P.id_Producto_Tipo = PT.id_Producto_Tipo
WHERE 
    C.fecha = '2024-11-22'";
$result8 = $con->query($query8);
// Verifica si la consulta fue exitosa
if ($result8 === false) {
    // Muestra un mensaje de error si la consulta falla
    die('Error en la consulta SQL: ' . $con->error);
}
$data4 = $result8->fetch_all(MYSQLI_ASSOC);

?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Consultas Intermedias</title>
    <link rel="stylesheet" href="./CSS/style.css">
    <style>
        .generate-pdf-button {
            background-color: #4caf50;
            color: white;
            font-size: 15px;
            padding: 5px 10px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        #menuButton {
            background-color: #4caf50;
            color: white;
            font-size: 15px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            position: absolute;
            top: 10px;
            left: 10px;
        }

    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Obtiene el botón de menú por su ID
            var menuButton = document.createElement('button');
            menuButton.textContent = 'Consultas';
            menuButton.id = 'menuButton';

            // Agrega un event listener para el clic en el botón de menú
            menuButton.addEventListener('click', function () {
                // Redirige a menu.php
                window.location.href = 'consultas.php';
            });

            // Agrega el botón al cuerpo del documento
            document.body.appendChild(menuButton);
        });
    </script>
</head>
<body>
    <h1>Consultas Intermedias</h1>

    <h2>Consulta 1: </h2>
<h3>Cantidad de citas realizadas por cada empleado</h3>
<table border="1">
    <tr>
        <th>ID Empleado</th>
        <th>Nombre</th>
        <th>Apellido</th>
        <th>Cantidad de Citas</th>
    </tr>
    <?php foreach ($data1 as $row): ?>
        <tr>
            <td><?php echo $row['id_Empleado']; ?></td>
            <td><?php echo $row['nombre01']; ?></td>
            <td><?php echo $row['apellido01']; ?></td>
            <td><?php echo $row['cantidad_citas']; ?></td>
        </tr>
    <?php endforeach; ?>
</table>

    <h2>Consulta 2: </h2>
<h3>Cantidad total de productos proporcionados por cada proveedor</h3>
<table border="1">
    <tr>
        <th>ID Proveedor</th>
        <th>Nombre del Proveedor</th>
        <th>Cantidad Total de Productos</th>
    </tr>
    <?php foreach ($data2 as $row): ?>
        <tr>
            <td><?php echo $row['id_Proveedor']; ?></td>
            <td><?php echo $row['nombre_proveedor']; ?></td>
            <td><?php echo $row['cantidad_productos']; ?></td>
        </tr>
    <?php endforeach; ?>
</table>

<h2>Consulta 3: </h2>
<h3>Cantidad de productos manejados por cada empleado</h3>
<table border="1" style="border-collapse: collapse; width: 100%; margin: 20px 0;">
    <thead>
        <tr style="background-color: #f2f2f2;">
            <th style="padding: 10px; text-align: left;">ID Empleado</th>
            <th style="padding: 10px; text-align: left;">Nombre del Empleado</th>
            <th style="padding: 10px; text-align: left;">Cantidad de Productos</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($data3 as $row): ?>
            <tr style="border-bottom: 1px solid #ddd;">
                <td style="padding: 10px;"><?php echo $row['id_Empleado']; ?></td>
                <td style="padding: 10px;"><?php echo $row['nombre01'] . ' ' . $row['apellido01']; ?></td>
                <td style="padding: 10px;"><?php echo $row['cantidad_productos']; ?></td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<h2>Consulta 4: </h2>
<h3>Citas programadas para un día específico</h3>
<table border="1">
    <tr>
        <th>ID Cita</th>
        <th>Fecha</th>
        <th>Duración</th>
        <th>Nombre del Cliente</th>
        <th>Nombre del Empleado</th>
        <th>Nombre del Producto</th>
        <th>Tipo de Producto</th>
    </tr>
    <?php foreach ($data4 as $row): ?>
        <tr>
            <td><?php echo $row['id_Cita']; ?></td>
            <td><?php echo $row['fecha']; ?></td>
            <td><?php echo $row['duracion']; ?></td>
            <td><?php echo $row['nombre_cliente']; ?></td>
            <td><?php echo $row['nombre_empleado']; ?></td>
            <td><?php echo $row['nombre_producto']; ?></td>
            <td><?php echo $row['tipo_producto']; ?></td>
        </tr>
    <?php endforeach; ?>
</table>
</body>
</html>
