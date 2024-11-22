<?php
include('conexion.php');
require_once('fpdf/fpdf.php');
$con = connection();

//Mostrar los clientes que tienen más citas que el promedio
$query9 =  "SELECT c.nombre01, c.apellido01, COUNT(*) as total_citas
                FROM cliente c
            JOIN cita ct ON c.id_Cliente = ct.id_Cliente
            GROUP BY c.id_Cliente, c.nombre01, c.apellido01
            HAVING COUNT(*) > (
                SELECT AVG(citas_por_cliente)
                FROM (
                    SELECT COUNT(*) as citas_por_cliente
                    FROM cita
                    GROUP BY id_Cliente
                ) as promedio
            );";
        
$result9 = $con->query($query9);

if ($result9) {
    // Obtiene los resultados de la consulta
    $data9 = $result9->fetch_all(MYSQLI_ASSOC);

    // Verifica si hay resultados
    if (empty($data9)) {
        echo "No se encontraron clientes o citas.";
    } 
} else {
    // Si la consulta falla, muestra un mensaje de error
    echo "Error en la consulta: " . $con->error;
}

//Encontrar los empleados que han atendido todos los tipos de productos/servicios
$query10 =  "SELECT e.nombre01, e.apellido01
                FROM empleado e
                WHERE NOT EXISTS (
                    SELECT id_Producto
                    FROM producto
                    WHERE id_Producto NOT IN (
                        SELECT id_Producto
                        FROM cita
                        WHERE id_Empleado = e.id_Empleado
                    )
                );";

$result10 = $con->query($query10);

if ($result10) {
    // Obtiene los resultados de la consulta
    $data10 = $result10->fetch_all(MYSQLI_ASSOC);

    // Verifica si hay resultados
    if (empty($data10)) {
        echo "No se encontraron empleados o servicios.";
    } 
} else {
    // Si la consulta falla, muestra un mensaje de error
    echo "Error en la consulta: " . $con->error;
}

//Mostrar los clientes que han gastado más que el promedio en facturas
$query11 = "SELECT c.nombre01, c.apellido01, 
                SUM(fv.total) as total_gastado
            FROM cliente c
            JOIN facturaventa fv ON c.id_Cliente = fv.id_Cliente
            GROUP BY c.id_Cliente, c.nombre01, c.apellido01
            HAVING SUM(fv.total) > (
                SELECT AVG(total)
                FROM facturaventa
            );";

$result11 = $con->query($query11);

if ($result11) {
    // Obtiene los resultados de la consulta
    $data11 = $result11->fetch_all(MYSQLI_ASSOC);

    // Verifica si hay resultados
    if (empty($data11)) {
        echo "No se encontraron clientes o facturas.";
    } 
} else {
    // Si la consulta falla, muestra un mensaje de error
    echo "Error en la consulta: " . $con->error;
}

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
    <h1>Consultas Avanzadas</h1>

    <h2>Consulta 1: </h2>
<h3>Mostrar los clientes que tienen más citas que el promedio</h3>
<table border="1">
    <tr>
        <th>Nombre del cliente</th>
        <th>Apellido del cliente</th>
        <th>Cantidad de Citas</th>
    </tr>
    <?php foreach ($data9 as $row): ?>
        <tr>
            <td><?php echo $row['nombre01']; ?></td>
            <td><?php echo $row['apellido01']; ?></td>
            <td><?php echo $row['total_citas']; ?></td>
        </tr>
    <?php endforeach; ?>
</table>
<form method="post" action="generate_pdf.php">
    <input type="hidden" name="consulta" value="9">
    <input type="hidden" name="filename" value="consulta9.pdf">
    <?php foreach ($data9 as $row): ?>
        <?php foreach ($row as $key => $value): ?>
            <input type="hidden" name="data9[<?php echo $row['nombre01']; ?>][<?php echo $key; ?>]" value="<?php echo $value; ?>">
        <?php endforeach; ?>
    <?php endforeach; ?>
    <button type="submit" class="generate-pdf-button">Generar PDF</button>
</form>

    <h2>Consulta 2: </h2>
<h3>Encontrar los empleados que han atendido todos los tipos de productos/servicios</h3>
<table border="1">
    <tr>
        <th>Nombre empleado</th>
        <th>Apellido empleado</th>
    </tr>
    <?php foreach ($data10 as $row): ?>
        <tr>
            <td><?php echo $row['nombre01']; ?></td>
            <td><?php echo $row['apellido01']; ?></td>
        </tr>
    <?php endforeach; ?>
</table>
<form method="post" action="generate_pdf.php">
    <input type="hidden" name="consulta" value="10">
    <input type="hidden" name="filename" value="consulta10.pdf">
    <?php foreach ($data10 as $row): ?>
        <?php foreach ($row as $key => $value): ?>
            <input type="hidden" name="data10[<?php echo $row['nombre01']; ?>][<?php echo $key; ?>]" value="<?php echo $value; ?>">
        <?php endforeach; ?>
    <?php endforeach; ?>
    <button type="submit" class="generate-pdf-button">Generar PDF</button>
</form>

<h2>Consulta 3: </h2>
<h3>Mostrar los clientes que han gastado más que el promedio en facturas</h3>
<table border="1" style="border-collapse: collapse; width: 100%; margin: 20px 0;">
    <thead>
        <tr style="background-color: #f2f2f2;">
            <th style="padding: 10px; text-align: left;">Nombre del cliente</th>
            <th style="padding: 10px; text-align: left;">Apellido del cliente</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($data11 as $row): ?>
            <tr style="border-bottom: 1px solid #ddd;">
                <td style="padding: 10px;"><?php echo $row['nombre01']; ?></td>
                <td style="padding: 10px;"><?php echo $row['apellido01']; ?></td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>
<form method="post" action="generate_pdf.php">
    <input type="hidden" name="consulta" value="11">
    <input type="hidden" name="filename" value="consulta11.pdf">
    <?php foreach ($data11 as $row): ?>
        <?php foreach ($row as $key => $value): ?>
            <input type="hidden" name="data11[<?php echo $row['nombre01']; ?>][<?php echo $key; ?>]" value="<?php echo $value; ?>">
        <?php endforeach; ?>
    <?php endforeach; ?>
    <button type="submit" class="generate-pdf-button">Generar PDF</button>
</form>
</body>
</html>