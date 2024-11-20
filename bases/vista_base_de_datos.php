<?php
include('conexion.php');
$con = connection();

// Consulta para obtener los datos de la tabla Administrador
$sqlAdministrador = 'SELECT * FROM Administrador';
$resultAdministrador = mysqli_query($con, $sqlAdministrador);
// Consulta para obtener los datos de la tabla Empleado
$sqlEmpleado = "SELECT * FROM Empleado";
$resultEmpleado = mysqli_query($con, $sqlEmpleado);

// Consulta para obtener los datos de la tabla Cargo
$sqlCargo = "SELECT * FROM Cargo";
$resultCargo = mysqli_query($con, $sqlCargo);

// Consulta para obtener los datos de la tabla Cliente
$sqlCliente = "SELECT * FROM Cliente";
$resultCliente = mysqli_query($con, $sqlCliente);

$sqlClienteAlergia = "SELECT * FROM ClienteAlergia";
$resultClienteAlergia = mysqli_query($con, $sqlClienteAlergia);

$sqlClienteEnfermedad = "SELECT *FROM ClienteEnfermedad";
$resultClienteEnfermedad = mysqli_query($con, $sqlClienteEnfermedad);

$sqlAlergia = "SELECT * FROM Alergia";
$resultAlergia = mysqli_query($con, $sqlAlergia);

$sqlEnfermedad = "SELECT * FROM Enfermedad";
$resultEnfermedad = mysqli_query($con, $sqlEnfermedad);

// Consulta para obtener los datos de la tabla Producto
$sqlProducto = "SELECT * FROM Producto";
$resultProducto = mysqli_query($con, $sqlProducto);

// Consulta para obtener los datos de la tabla ProductoTipo
$sqlProductoTipo = "SELECT * FROM Producto_Tipo";
$resultProductoTipo = mysqli_query($con, $sqlProductoTipo);

// Consulta para obtener los datos de la tabla Proveedor
$sqlProveedor = "SELECT * FROM Proveedor";
$resultProveedor = mysqli_query($con, $sqlProveedor);

// Consulta para obtener los datos de la tabla Telefono
$sqlTelefono = "SELECT * FROM Telefono";
$resultTelefono = mysqli_query($con, $sqlTelefono);

// Consulta para obtener los datos de la tabla Cita
$sqlCita = "SELECT * FROM Cita";
$resultCita = mysqli_query($con, $sqlCita);

// Consulta para obtener los datos de la tabla Pago
$sqlPago = "SELECT * FROM Pago";
$resultPago = mysqli_query($con, $sqlPago);

// Consulta para obtener los datos de la tabla CalificacionServicio
$sqlCalificacion = "SELECT * FROM Calificacion";
$resultCalificacion = mysqli_query($con, $sqlCalificacion);

// Consulta para obtener los datos de la tabla Inventario
$sqlInventario = "SELECT * FROM Inventario";
$resultInventario = mysqli_query($con, $sqlInventario);



if (!$resultAdministrador || !$resultEmpleado || !$resultCargo || !$resultCliente|| !$resultClienteAlergia || !$resultClienteEnfermedad ||
   !$resultAlergia || !$resultEnfermedad || !$resultProducto || !$resultProductoTipo || !$resultProveedor || !$resultTelefono ||
   !$resultCita || !$resultPago || !$resultCalificacion || !$resultInventario
) {
    die("Error en la consulta: " . mysqli_error($con));
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Vista Base de Datos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        #menuButton {
            background-color: blue;
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

        #searchInput {
            font-size: 15px;
            padding: 10px;
            border-radius: 5px;
            margin-left: 10px;
            position: absolute;
            top: 10px;
            left: 150px; /* Ajusta la posición según tu preferencia */
        }
    </style>
    <script>
        document.addEventListener('DOMContentLoaded', function () {
            // Obtiene el botón de menú por su ID
            var menuButton = document.createElement('button');
            menuButton.textContent = 'Menú';
            menuButton.id = 'menuButton';

            // Agrega un event listener para el clic en el botón de menú
            menuButton.addEventListener('click', function () {
                // Redirige a menu.php
                window.location.href = 'menu.php';
            });

            // Agrega el botón al cuerpo del documento
            document.body.appendChild(menuButton);

            // Agrega el campo de búsqueda
            var searchInput = document.createElement('input');
            searchInput.type = 'text';
            searchInput.id = 'searchInput';
            searchInput.placeholder = 'Buscar...';

            // Agrega un event listener para el evento input en el campo de búsqueda
            searchInput.addEventListener('input', function () {
                var searchValue = searchInput.value.toLowerCase();
                // Filtra las filas de las tablas según el valor de búsqueda
                filterTableRows(searchValue);
            });

            // Agrega el campo de búsqueda al cuerpo del documento
            document.body.appendChild(searchInput);

            // Función para filtrar las filas de las tablas
            function filterTableRows(searchValue) {
                var tables = document.querySelectorAll('table tbody');
                tables.forEach(function (table) {
                    var rows = table.querySelectorAll('tr');
                    rows.forEach(function (row) {
                        var text = row.textContent.toLowerCase();
                        row.style.display = text.includes(searchValue) ? '' : 'none';
                    });
                });
            }
        });
    </script>
</head>
<body>

    <div class="container">
        <!-- Encabezado -->
        <h1 class="mt-5">Información de la tabla Administrador</h1>

        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Administrador</th>
                        <th>Nombre Administrador</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultAdministrador)): ?>
                        <tr>
                            <td><?= $row['id_Administrador'] ?></td>
                            <td><?= $row['nombreAdministrador'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        <h1 class="mt-5">Información de la tabla Empleado</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Empleado</th>
                        <th>ID Cargo</th>
                        <th>Salario</th>
                        <th>Nombre 1</th>
                        <th>Nombre 2</th>
                        <th>Apellido 1</th>
                        <th>Apellido 2</th>
                        <th>Correo Electrónico</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultEmpleado)): ?>
                        <tr>
                            <td><?= $row['id_Empleado'] ?></td>
                            <td><?= $row['id_Cargo'] ?></td>
                            <td><?= $row['salario'] ?></td>
                            <td><?= $row['nombre01'] ?></td>
                            <td><?= $row['nombre02'] ?></td>
                            <td><?= $row['apellido01'] ?></td>
                            <td><?= $row['apellido02'] ?></td>
                            <td><?= $row['correo_electronico'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>
        <h1 class="mt-5">Información de la tabla Cargo</h1>

        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Cargo</th>
                        <th>Nombre Cargo</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultCargo)): ?>
                        <tr>
                            <td><?= $row['id_Cargo'] ?></td>
                            <td><?= $row['nombre'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>
        
        <h1 class="mt-5">Información de la tabla Cliente</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Cliente</th>
                        <th>Primer Nombre</th>
                        <th>Segundo Nombre</th>
                        <th>Primer Apellido</th>
                        <th>Segundo Apellido</th>
                        <th>Fecha Nacimiento</th>
                        <th>Residencia</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultCliente)): ?>
                        <tr>
                            <td><?= $row['id_Cliente'] ?></td>
                            <td><?= $row['nombre01'] ?></td>
                            <td><?= $row['nombre02'] ?></td>
                            <td><?= $row['apellido01'] ?></td>
                            <td><?= $row['apellido02'] ?></td>
                            <td><?= $row['fecha_nacimiento'] ?></td>
                            <td><?= $row['residencia'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        <h1 class="mt-5">Información de la tabla Cliente-Alergia</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID ClienteAlergia</th>
                        <th>ID Cliente</th>
                        <th>ID Alergia</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultClienteAlergia)): ?>
                        <tr>
                            <td><?= $row['id_ClienteAlergia'] ?></td>
                            <td><?= $row['id_Cliente'] ?></td>
                            <td><?= $row['id_Alergia'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>
        
        <h1 class="mt-5">Información de la tabla Cliente-Enfermedad</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID ClienteEnfermedad</th>
                        <th>ID Cliente</th>
                        <th>ID Enfermedad</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultClienteEnfermedad)): ?>
                        <tr>
                            <td><?= $row['id_ClienteEnfermedad'] ?></td>
                            <td><?= $row['id_Cliente'] ?></td>
                            <td><?= $row['id_Enfermedad'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        <h1 class="mt-5">Información de la tabla Alergia</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Alergia</th>
                        <th>Nombre</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultAlergia)): ?>
                        <tr>
                            <td><?= $row['id_Alergia'] ?></td>
                            <td><?= $row['nombre'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        <h1 class="mt-5">Información de la tabla Enfermedad</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Alergia</th>
                        <th>Nombre</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultEnfermedad)): ?>
                        <tr>
                            <td><?= $row['id_Enfermedad'] ?></td>
                            <td><?= $row['nombre'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        <h1 class="mt-5">Información de la tabla Producto</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Producto</th>
                        <th>Descripcion</th>
                        <th>Precio</th>
                        <th>Nombre</th>
                        <th>Tipo de producto</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultProducto)): ?>
                        <tr>
                            <td><?= $row['id_Producto'] ?></td>
                            <td><?= $row['descripcion']?></td>
                            <td><?= $row['precio']?></td>
                            <td><?= $row['nombre']?></td>
                            <td><?= $row['id_Producto_Tipo'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        <h1 class="mt-5">Información de la tabla ProductoTipo</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <td>ID Tipo Producto</td>
                        <td>Tipo (Producto o Servicio)</td>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultProductoTipo)): ?>
                        <tr>
                            <td><?= $row['id_Producto_Tipo']?></td>
                            <td><?= $row['tipo']?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>
        
        <h1 class="mt-5">Información de la tabla Proveedor</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Proveedor</th>
                        <th>Nombre Proveedor</th>
                        <th>Identificación</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultProveedor)): ?>
                        <tr>
                            <td><?= $row['id_Proveedor'] ?></td>
                            <td><?= $row['nombre'] ?></td>
                            <td><?= $row['identificacion']?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        <h1 class="mt-5">Información de la tabla Telefono</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Telefono</th>
                        <th>Número</th>
                        <th>ID Empleado</th>
                        <th>ID Cliente</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultTelefono)): ?>
                        <tr>
                            <td><?= $row['id_Telefono'] ?></td>
                            <td><?= $row['numero'] ?></td>
                            <td><?= $row['id_Empleado'] ?></td>
                            <td><?= $row['id_Cliente'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        <h1 class="mt-5">Información de la tabla Cita</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Cita</th>
                        <th>ID Empleado</th>
                        <th>ID Cliente</th>
                        <th>Fecha</th>
                        <th>Duración</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultCita)): ?>
                        <tr>
                            <td><?= $row['id_Cita'] ?></td>
                            <td><?= $row['id_Empleado'] ?></td>
                            <td><?= $row['id_Cliente'] ?></td>
                            <td><?= $row['fecha'] ?></td>
                            <td><?= $row['duracion'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        <h1 class="mt-5">Información de la tabla Pago</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Pago</th>
                        <th>monto</th>
                        <th>Fecha</th>
                        <th>ID FacturaVenta</th>
                        <th>ID Cliente</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultPago)): ?>
                        <tr>
                            <td><?= $row['id_Pago'] ?></td>
                            <td><?= $row['monto'] ?></td>
                            <td><?= $row['fecha'] ?></td>
                            <td><?= $row['id_FacturaVenta'] ?></td>
                            <td><?= $row['id_Cliente'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        
        <h1 class="mt-5">Información de la tabla Calificación</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Calificacion</th>
                        <th>Calificación</th>
                        <th>ID Cita</th>
                        <th>Descripcion</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultCalificacion)): ?>
                        <tr>
                            <td><?= $row['id_Calificacion'] ?></td>
                            <td><?= $row['calificacion'] ?></td>
                            <td><?= $row['id_Cita'] ?></td>
                            <td><?= $row['descripcion'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        <!-- Información de la Tabla Inventario -->
        <h1 class="mt-5">Información de la tabla Inventario</h1>
        <div class="table-responsive">
            <table class="table table-striped">
                <thead>
                    <tr>
                        <th>ID Inventario</th>
                        <th>ID Producto</th>
                        <th>Cantidad</th>
                        <th>Fecha Movimiento</th>
                        <th>ID Movimiento</th>
                        <th>ID Detalle de FacturaCompra</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_assoc($resultInventario)): ?>
                        <tr>
                            <td><?= $row['id_Inventario'] ?></td>
                            <td><?= $row['id_Producto'] ?></td>
                            <td><?= $row['cantidad'] ?></td>
                            <td><?= $row['fecha_movimiento'] ?></td>
                            <td><?= $row['id_Movimiento'] ?></td>
                            <td><?= $row['id_FacturaCompra_Detalle'] ?></td>
                        </tr>
                    <?php endwhile; ?>
                </tbody>
            </table>
        </div>

        
    </div>






    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>