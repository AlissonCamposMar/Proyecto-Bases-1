<?php
include('conexion.php');
$con = connection();

// Manejar la inserción de datos cuando se envía el formulario
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['editar'])) {

        // Lógica de actualización
        $id_Cita_editar = $_POST['id_Cita_editar'];
        $fecha_editar = $_POST['fecha_editar'];
        $duracion_editar = $_POST['duracion_editar'];
        $empleado_editar = $_POST['empleado_editar'];
        $cliente_editar = $_POST['cliente_editar'];
        $produco_editar = $_POST['producto_editar'];
        // Actualizar datos en la tabla cita
        $sql_actualizar_cita = "UPDATE cita
                                   SET fecha = '$fecha_editar',
                                        duracion = '$duracion_editar',
                                       id_Empleado = '$empleado_editar',
                                       id_Cliente = '$cliente_editar',
                                       id_Producto = '$produco_editar'  
                                   WHERE id_Cita = '$id_Cita_editar'";
        $result_actualizar_cita = mysqli_query($con, $sql_actualizar_cita);

        // Verificar si todas las consultas fueron exitosas
        if ($result_actualizar_cita) {
            // Redirigir a la página de clientes después de la actualización
            header("Location: CRUDcita.php");
            exit();
        } else {
            echo "Error al actualizar datos: " . mysqli_error($con);
        }

    } elseif (isset($_POST['eliminar'])) {
        // Lógica de eliminación
        $id_Cita_eliminar = $_POST['id_Cita_eliminar'];

        // Eliminar datos en la tabla cita
        $sql_eliminar_cita = "DELETE FROM cita WHERE id_Cita = '$id_Cita_eliminar'";
        $result_eliminar_cita = mysqli_query($con, $sql_eliminar_cita);

        // Verificar si la eliminación fue exitosa
        if ($result_eliminar_cita) {
            // Redirigir a la página de clientes después de la eliminación
            header("Location: CRUDcita.php");
            exit();
        } else {
            echo "Error al eliminar datos: " . mysqli_error($con);
        }
    } else {
        // Verificar que todos los campos obligatorios están llenos
        $required_fields = ['fecha', 'duracion', 'empleado', 'cliente', 'producto'];

        foreach ($required_fields as $field) {
            if (empty($_POST[$field])) {
                // Mostrar ventana de advertencia
                echo "<script>alert('Por favor, llene todos los campos obligatorios.');</script>";
                echo "<script>window.location.href='CRUDcita.php';</script>";
                exit; // Detener la ejecución si faltan datos
            }
        }

        $fecha = $_POST['fecha'];
        $duracion = $_POST['duracion'];
        $id_Empleado = $_POST['empleado']; // Modificado para obtener el ID del empleado
        $id_Cliente = $_POST['cliente']; // Modificado para obtener el ID del cliente
        $id_Producto = $_POST['producto'];

        // Insertar en la tabla cita
        $sql_cita = "INSERT INTO cita (fecha, duracion, id_Empleado, id_Cliente, id_Producto) 
                        VALUES ('$fecha', '$duracion', '$id_Empleado', '$id_Cliente',$id_Producto )";
        $result_cita = mysqli_query($con, $sql_cita);

        // Obtener el id_Cita recién insertado
        $id_Cita_insertado_insertado = mysqli_insert_id($con);

        if (!$result_cita) {
            die("Error al insertar datos: " . mysqli_error($con));
        }
    }
}

// Consulta para obtener los datos
$sql = "SELECT cita.*, empleado.id_Empleado, CONCAT(empleado.nombre01, ' ', empleado.apellido01) as nombre_empleado, cliente.id_Cliente, CONCAT(cliente.nombre01, ' ', cliente.apellido01) as nombre_cliente
FROM cita
LEFT JOIN empleado ON cita.id_Empleado = empleado.id_Empleado
LEFT JOIN cliente ON cita.id_Cliente = cliente.id_Cliente";
$query = mysqli_query($con, $sql);

if (!$query) {
    die("Error en la consulta: " . mysqli_error($con));
}

// Consulta para obtener los empleados
$sql_empleados = "SELECT * FROM empleado";
$query_empleados = mysqli_query($con, $sql_empleados);
if (!$query_empleados) {
    die("Error en la consulta de empleados: " . mysqli_error($con));
}

// Consulta para obtener los clientes
$sql_clientes = "SELECT * FROM cliente";
$query_clientes = mysqli_query($con, $sql_clientes);
if (!$query_clientes) {
    die("Error en la consulta de clientes: " . mysqli_error($con));
}
//Consulta para obtener los productos
$sql_productos = "
    SELECT id_Producto, nombre 
    FROM producto
    WHERE id_producto_tipo = 2";
$query_productos = mysqli_query($con, $sql_productos);
if (!$query_productos) {
    die("Error en la consulta: " . mysqli_error($con));
}
?>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRUD cita</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

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
        });
    </script>
</head>
<body>
    <div class="container">

        <!--Formulario de creación de cita-->
        <h1 class="mt-4 mb-2">Crear cita</h1>
        <form method="post" action="" class="mb-4">
            <!-- Selección de empleado -->
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="empleado">Empleado:</label>
                    <select name="empleado" class="form-control">
                        <option value="" disabled selected>Seleccionar empleado</option>
                        <?php while ($empleado = mysqli_fetch_assoc($query_empleados)): ?>
                            <option value="<?= $empleado['id_Empleado'] ?>">
                                    <?= $empleado['id_Empleado'] . ' - ' . $empleado['nombre01'] . ' ' . $empleado['apellido01'] ?>
                            </option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <!-- Selección de cliente -->
                <div class="form-group col-md-6">
                    <label for="cliente">Cliente:</label>
                    <select name="cliente" class="form-control">
                        <option value="" disabled selected>Seleccionar cliente</option>
                        <?php while ($cliente = mysqli_fetch_assoc($query_clientes)): ?>
                            <option value="<?= $cliente['id_Cliente'] ?>">
                            <?= $cliente['id_Cliente'] . ' - ' . $cliente['nombre01'] . ' ' . $cliente['nombre02'] . ' ' . $cliente['apellido01'] . ' ' . $cliente['apellido02'] ?>
                            </option>
                        <?php endwhile; ?>
                    </select>
                </div>

                <!-- Selección de producto -->
                <div class="form-group col-md-6">
                    <label for="producto">Producto:</label>
                    <select name="producto" class="form-control">
                        <option value="" disabled selected>Seleccionar producto</option>
                        <?php while ($producto = mysqli_fetch_assoc($query_productos)): ?>
                            <option value="<?= $producto['id_Producto'] ?>">
                            <?= $producto['id_Producto'] . ' - ' . $producto['nombre'] ?>
                            </option>
                        <?php endwhile; ?>
                    </select>
                </div>
                <!-- Campo de fecha -->
                <div class="form-group col-md-6">
                    <label for="fecha">Fecha:</label>
                    <input type="date" name="fecha" class="form-control" placeholder="AAAA/MM/DD" required>
                </div>
                <!-- Campo de hora -->
                <div class="form-group col-md-6">
                    <label for="duracion">Duración:</label>
                    <input type="text" name="duracion" class="form-control" required>
                </div>
                

            </div>
            <button type="submit" class="btn btn-primary">Agregar cita</button>
        </form>

            <!-- Visualización de citas registradas-->
            <div>
                <h2 class="mb-3">Citas registradas</h2>
                <table class="table">
                    <!-- Encabezado de la tabla -->
                    <thead>
                        <tr>
                            <th>Id Cita</th>
                            <th>Fecha</th>
                            <th>Duración</th>
                            <th>Empleado</th>
                            <th>Cliente</th>
                            <th>Servicio</th>
                            <th colspan="2">Acciones</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <!-- Filas de datos de la tabla -->
                        <?php while ($row = mysqli_fetch_array($query)): ?>
                            <tr>
                                <td><?= $row['id_Cita'] ?></td>
                                <td><?= $row['fecha'] ?></td>
                                <td><?= $row['duracion'] ?></td>
                                <?php
                                // Obtener los nombres de empleado, cliente y prooducto utilizando sus IDs
                                $id_Empleado = $row['id_Empleado'];
                                $id_Cliente = $row['id_Cliente'];
                                $id_Producto= $row['id_Producto'];
                                
                                // Consulta para obtener el nombre del empleado
                                $query_nombre_empleado = mysqli_query($con, "SELECT CONCAT(nombre01, ' ', apellido01) as nombre_empleado FROM empleado WHERE id_Empleado = '$id_Empleado'");
                                $nombre_empleado = mysqli_fetch_assoc($query_nombre_empleado)['nombre_empleado'];

                                // Consulta para obtener el nombre del cliente
                                $query_nombre_cliente = mysqli_query($con, "SELECT CONCAT(nombre01, ' ', apellido01) as nombre_cliente FROM cliente WHERE id_Cliente = '$id_Cliente'");
                                $nombre_cliente = mysqli_fetch_assoc($query_nombre_cliente)['nombre_cliente'];

                                // Consulta para obtener el nombre del cliente
                                $query_nombre_producto = mysqli_query($con, "SELECT nombre as nombre_producto FROM producto WHERE id_Producto = '$id_Producto'");
                                $nombre_producto = mysqli_fetch_assoc($query_nombre_producto)['nombre_producto'];
                                ?>
                                <td><?= $nombre_empleado ?></td>
                                <td><?= $nombre_cliente ?></td>
                                <td><?= $nombre_producto ?></td>
                                <td>
                                    <a href="?editar=<?= $row['id_Cita'] ?>" class="btn btn-sm btn-warning">Editar</a>
                                </td>
                                <td>
                                    <form method="post" action="">
                                        <input type="hidden" name="id_Cita_eliminar" value="<?= $row['id_Cita'] ?>">
                                        <input type="submit" name="eliminar" value="Eliminar" class="btn btn-sm btn-danger">
                                    </form>
                                </td>
                            </tr>
                        <?php endwhile; ?>
                    </tbody>
                </table>
            </div>
        
        <!-- Formulario de edición -->
        <?php if (isset($_GET['editar'])): ?>
            <?php
            // Obtener datos del cliente, teléfono y residencia para prellenar el formulario
            $id_Cita_editar = $_GET['editar'];
            $sql_editar = "SELECT cita.*, empleado.id_Empleado, CONCAT(empleado.nombre01, ' ', empleado.apellido01) as nombre_empleado, cliente.id_Cliente, CONCAT(cliente.nombre01, ' ', cliente.apellido01) as nombre_cliente
                            FROM cita
                            LEFT JOIN empleado ON cita.id_Empleado = empleado.id_Empleado
                            LEFT JOIN cliente ON cita.id_Cliente = cliente.id_Cliente
                            WHERE cita.id_Cita = '$id_Cita_editar'";
            $result_editar = mysqli_query($con, $sql_editar);
            $cita_editar = mysqli_fetch_assoc($result_editar);
            ?>
            <div>
                <h2 class="mt-4 mb-2">Editar cita - ID <?= $cita_editar['id_Cita'] ?></h2>
                <form method="post" action="" class="mb-4">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="empleado_editar">Empleado:</label>
                            <!-- Combo box con ID de empleado -->
                            <select name="empleado_editar" class="form-control">
                                <?php
                                // Obtener todos los empleados
                                $query_empleados = mysqli_query($con, "SELECT * FROM empleado");
                                
                                // Iterar sobre los empleados para crear opciones
                                while ($empleado = mysqli_fetch_assoc($query_empleados)) {
                                    // Comprobar si el empleado es el actual del cita
                                    $selected = ($empleado['id_Empleado'] == $cita_editar['id_Empleado']) ? 'selected' : '';
                                // Concatenar el ID y el nombre completo del empleado
                                    $nombre_completo = "{$empleado['nombre01']} {$empleado['nombre02']} {$empleado['apellido01']} {$empleado['apellido02']}";    
                                    // Imprimir la opción
                                    echo "<option value='{$empleado['id_Empleado']}' $selected>{$empleado['id_Empleado']} - {$nombre_completo}</option>";
                                }
                                ?>
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="cliente_editar">Cliente:</label>
                            <!-- Combo box con ID de cliente -->
                            <select name="cliente_editar"  class="form-control">
                                <?php
                                // Obtener todos los clientes
                                $query_clientes = mysqli_query($con, "SELECT * FROM cliente");
                                
                                // Iterar sobre los clientes para crear opciones
                                while ($cliente = mysqli_fetch_assoc($query_clientes)) {
                                    // Comprobar si el cliente es el actual del cita
                                    $selected = ($cliente['id_Cliente'] == $cita_editar['id_Cliente']) ? 'selected' : '';
                                    // Concatenar el nombre completo del cliente
                                    $nombre_completo = "{$cliente['nombre01']} {$cliente['nombre02']} {$cliente['apellido01']} {$cliente['apellido02']}";
                                    // Imprimir la opción
                                    echo "<option value='{$cliente['id_Cliente']}' $selected>{$cliente['id_Cliente']} - {$nombre_completo}</option>";
                                }
                                ?>
                            </select>
                        </div>
                        <div class="form-group col-md-6">
        <label for="producto_editar">Servicio:</label>
        <!-- Combo box con ID de producto -->
        <select name="producto_editar" class="form-control">
            <?php
            // Obtener todos los productos
            $query_productos = mysqli_query($con, "SELECT * FROM producto WHERE producto.id_producto_tipo=2");
            
            // Iterar sobre los productos para crear opciones
            while ($producto = mysqli_fetch_assoc($query_productos)) {
                // Comprobar si el producto es el actual del cita
                $selected = ($producto['id_Producto'] == $cita_editar['id_Producto']) ? 'selected' : '';
                
                // Concatenar el nombre del producto (o puedes agregar más detalles si lo deseas)
                $nombre_producto = $producto['nombre'];  // Aquí puedes agregar más detalles si es necesario
                
                // Imprimir la opción
                echo "<option value='{$producto['id_Producto']}' $selected>{$producto['id_Producto']} - {$nombre_producto}</option>";
            }
            ?>
        </select>
    </div>

                        <input type="hidden" name="id_Cita_editar" value="<?= $cita_editar['id_Cita'] ?>">
                        <!-- Resto de los campos -->
                        <div class="form-group col-md-6">
                            <label for="fecha_editar">Fecha:</label>
                            <input type="date" name="fecha_editar" class="form-control" value="<?= $cita_editar['fecha'] ?>">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="duracion_editar">Duración:</label>
                            <input type="text" name="duracion_editar" class="form-control" value="<?= $cita_editar['duracion'] ?>">
                        </div>
                    </div>
                    
                    <button type="submit" name="editar" class="btn btn-primary">Guardar cambios</button>
                </form>
            </div>
        <?php endif; ?>
    </div>
    <!-- Bootstrap JS y otros scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
