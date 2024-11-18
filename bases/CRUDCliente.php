<?php
include('conexion.php');
$con = connection();

// Manejar la inserción de datos cuando se envía el formulario
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    if (isset($_POST['editar'])) {

        // Lógica de actualización
        $id_Cliente_editar = $_POST['id_Cliente_editar'];
        $nombre01_editar = $_POST['nombre01_editar'];
        $nombre02_editar = $_POST['nombre02_editar'];
        $apellido01_editar = $_POST['apellido01_editar'];
        $apellido2_editar = $_POST['apellido2_editar'];
        $fecha_nacimiento_editar = $_POST['fecha_nacimiento_editar'];
        $residencia_editar = $_POST['residencia_editar'];
        $numero_editar = $_POST['numero_editar'];
        $enfermedad_editar = $_POST['enfermedad_editar'];
        $alergia_editar = $_POST['alergia_editar'];
        
        

        // Actualizar datos en la tabla cliente
        $sql_actualizar_cliente = "UPDATE cliente
                                   SET nombre01 = '$nombre01_editar',nombre02 = '$nombre02_editar',
                                       apellido01 = '$apellido01_editar',apellido2 = '$apellido2_editar',
                                       fecha_nacimiento = '$fecha_nacimiento_editar',
                                       residencia = '$residencia_editar'
                                   WHERE id_Cliente = '$id_Cliente_editar'";
        $result_actualizar_cliente = mysqli_query($con, $sql_actualizar_cliente);

        // Actualizar datos en la tabla telefono
        $sql_actualizar_telefono = "UPDATE telefono
                                     SET nombre = '$numero_editar'
                                     WHERE id_Cliente = '$id_Cliente_editar'";
        $result_actualizar_telefono = mysqli_query($con, $sql_actualizar_telefono);

        //Actualizar datos en la tabla enfermedad
        $sql_actualizar_enfermedad = "UPDATE enfermedad
                                    SET nombre = '$enfermedad_editar'
                                    WHERE id_Enfermedad = (SELECT id_Enfermedad FROM clienteEnfermedad WHERE id_Cliente = '$id_Cliente_editar' LIMIT 1)";
        $result_actualizar_enfermedad = mysqli_query($con, $sql_actualizar_enfermedad);

        //Actualizar datos en la tabla alergia
        $sql_actualizar_alergia = "UPDATE alergia
                                SET nombre = '$alergia_editar'
                                    WHERE id_Alergia = (SELECT id_Alergia FROM clienteAlergia WHERE id_Cliente = '$id_Cliente_editar' LIMIT 1)";
        $result_actualizar_alergia = mysqli_query($con, $sql_actualizar_alergia);

        // Verificar si el usuario tiene un número de teléfono relacionado
        $sql_verificar_telefono = "SELECT * FROM telefono WHERE id_Cliente = '$id_Cliente_editar'";
        $result_verificar_telefono = mysqli_query($con, $sql_verificar_telefono);

        if ($result_verificar_telefono !== false) {
            // Verificar si ya tiene un número de teléfono relacionado
            if (mysqli_num_rows($result_verificar_telefono) > 0) {
                // Si ya tiene un número de teléfono, actualizarlo
                $sql_actualizar_telefono = "UPDATE telefono
                                             SET numero = '$numero_editar'
                                             WHERE id_Cliente = '$id_Cliente_editar'";
                $result_actualizar_telefono = mysqli_query($con, $sql_actualizar_telefono);

                // Verificar si la actualización fue exitosa
                if (!$result_actualizar_telefono) {
                    echo "Error al actualizar el número de teléfono: " . mysqli_error($con);
                }
            } else {
                // Si no tiene un número de teléfono, entonces insertarlo
                $sql_insertar_telefono = "INSERT INTO telefono (id_Cliente, numero) VALUES ('$id_Cliente_editar', '$numero_editar')";
                $result_insertar_telefono = mysqli_query($con, $sql_insertar_telefono);

                // Verificar si la inserción fue exitosa
                if (!$result_insertar_telefono) {
                    echo "Error al insertar el número de teléfono: " . mysqli_error($con);
                }
            }
        } else {
            echo "Error en la consulta de verificación de teléfono: " . mysqli_error($con);
        }

        // Verifica si cada consulta fue exitosa
if ($result_actualizar_cliente) {
    echo "Cliente actualizado correctamente.<br>";
} else {
    echo "Error al actualizar cliente: " . mysqli_error($con) . "<br>";
}

if ($result_actualizar_telefono) {
    echo "Teléfono actualizado correctamente.<br>";
} else {
    echo "Error al actualizar teléfono: " . mysqli_error($con) . "<br>";
}

if ($result_actualizar_enfermedad) {
    echo "Enfermedad actualizada correctamente.<br>";
} else {
    echo "Error al actualizar enfermedad: " . mysqli_error($con) . "<br>";
}

if ($result_actualizar_alergia) {
    echo "Alergia actualizada correctamente.<br>";
} else {
    echo "Error al actualizar alergia: " . mysqli_error($con) . "<br>";
}


        // Verificar si todas las consultas fueron exitosas
        if ($result_actualizar_cliente && $result_actualizar_telefono && $result_actualizar_enfermedad && $result_actualizar_alergia) {
            // Redirigir a la página de clientes después de la actualización
            header("Location: CRUDCliente.php");
            exit();
        } else {
            echo "Error al actualizar datos: " . mysqli_error($con);
        }
    } elseif (isset($_POST['eliminar'])) {
        // Lógica de eliminación
        $id_Cliente_eliminar = $_POST['id_Cliente_eliminar'];

        // Eliminar datos de la tabla cliente
        $sql_eliminar_cliente = "DELETE FROM cliente WHERE id_Cliente = '$id_Cliente_eliminar'";
        $result_eliminar_cliente = mysqli_query($con, $sql_eliminar_cliente);

        // Eliminar datos de la tabla telefono
        $sql_eliminar_telefono = "DELETE FROM telefono WHERE id_Cliente = '$id_Cliente_eliminar'";
        $result_eliminar_telefono = mysqli_query($con, $sql_eliminar_telefono);

        // Eliminar datos de la tabla enfermedad
        $sql_eliminar_cliente_enfermedad = "DELETE FROM clienteEnfermedad WHERE id_Cliente = '$id_Cliente_eliminar'";
        $result_eliminar_cliente_enfermedad = mysqli_query($con, $sql_eliminar_cliente_enfermedad);

        // Verificar si la eliminación fue exitosa
        if ($result_eliminar_cliente && $result_eliminar_telefono) {
            // Redirigir a la página de clientes después de la eliminación
            header("Location: CRUDCliente.php");
            exit();
        } else {
            echo "Error al eliminar datos: " . mysqli_error($con);
        }
    } else {
          // Verificar que todos los campos obligatorios están llenos
    $required_fields = ['id_Cliente', 'nombre01','nombre02', 'apellido01','apellido2', 'fecha_nacimiento','residencia','telefono'];

    foreach ($required_fields as $field) {
        if (empty($_POST[$field])) {
            // Mostrar ventana de advertencia
            echo "<script>alert('Por favor, llene todos los campos obligatorios.');</script>";
            echo "<script>window.location.href='CRUDCliente.php';</script>";
            exit; // Detener la ejecución si faltan datos
        }
    }
        // Lógica de inserción (la parte que maneja el formulario de agregar cliente)
        $id_Cliente = $_POST['id_Cliente'];
        $nombre01 = $_POST['nombre01'];
        $nombre02 = $_POST['nombre02'];
        $apellido01 = $_POST['apellido01'];
        $apellido2 = $_POST['apellido2'];
        $fecha_nacimiento = $_POST['fecha_nacimiento'];
        $residencia = $_POST['residencia'];
        $numero = $_POST['telefono'];
        $enfermedad = $_POST['enfermedad'];
        $alergia = $_POST['alergia'];

        // Insertar en la tabla cliente
        $sql_cliente = "INSERT INTO cliente (id_Cliente, nombre01, nombre02, apellido01, apellido2, fecha_nacimiento, residencia) 
                        VALUES ('$id_Cliente', '$nombre01', '$nombre02', '$apellido01', '$apellido2', '$fecha_nacimiento', '$residencia')";
        $result_cliente = mysqli_query($con, $sql_cliente);

        //Insertar en la tabla telefono
        $sql_telefono = "INSERT INTO telefono (numero, id_Cliente) 
                        VALUES ('$numero','$id_Cliente')";
        $result_telefono = mysqli_query($con, $sql_telefono);

        //Insertar en la tabla cliente enfermedad
        $sql_cliente_enfermedad = "INSERT INTO clienteEnfermedad (id_Cliente,id_Enfermedad) 
        VALUES ('$id_Cliente','$id_Cliente')";
        $result_cliente_enfermedad = mysqli_query($con, $sql_cliente_enfermedad);

        //Insertar en la tabla enfermedad
        $sql_enfermedad = "INSERT INTO enfermedad (nombre) 
        VALUES ('$enfermedad')";
        $result_enfermedad = mysqli_query($con, $sql_enfermedad);

        //Insertar en la tabla cliente alergia
        $sql_cliente_alergia = "INSERT INTO alergia (id_Cliente, id_Alergia) 
        VALUES ('$id_Cliente','$id_Cliente')";
        $result_cliente_alergia = mysqli_query($con, $sql_cliente_alergia);

        //Insertar en la tabla alergia
        $sql_alergia = "INSERT INTO alergia (nombre) 
                        VALUES ('$alergia')";
        $result_alergia = mysqli_query($con, $sql_alergia);

        // Obtener el id_Cliente recién insertado
        $id_Cliente_insertado = mysqli_insert_id($con);

        if (!$result_cliente) {
            die("Error al insertar datos: " . mysqli_error($con));
        }
    }
}

// Consulta para obtener los datos
$sql = "SELECT cliente.*, telefono.numero, 
                GROUP_CONCAT(DISTINCT enfermedad.nombre) AS enfermedades,
                GROUP_CONCAT(DISTINCT alergia.nombre) AS alergias
        FROM cliente
        LEFT JOIN telefono ON cliente.id_Cliente = telefono.id_Cliente
        LEFT JOIN clienteEnfermedad ON cliente.id_Cliente = clienteEnfermedad.id_Cliente
        LEFT JOIN enfermedad ON clienteEnfermedad.id_Enfermedad = enfermedad.id_Enfermedad
        LEFT JOIN clienteAlergia ON cliente.id_Cliente = clienteAlergia.id_Cliente
        LEFT JOIN alergia ON clienteAlergia.id_Alergia = alergia.id_Alergia
        GROUP BY cliente.id_Cliente";
$query = mysqli_query($con, $sql);

if (!$query) {
    die("Error en la consulta: " . mysqli_error($con));
}
?>

<!DOCTYPE html>
<html lang="es">

<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRUD CLIENTE</title>
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

        <!-- Formulario de creación de cliente -->
        <h1 class="mt-4 mb-2">Crear cliente</h1>
        <form method="post" action="" class="mb-4">
            <div class="form-row">
                <div class="form-group col-md-6">
                    <label for="id_Cliente">Identificación</label>
                    <input type="text" name="id_Cliente" class="form-control" placeholder="CC" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="nombre01">Primer Nombre</label>
                    <input type="text" name="nombre01" class="form-control" placeholder="Primer Nombre" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="nombre02">Segundo Nombre</label>
                    <input type="text" name="nombre02" class="form-control" placeholder="Segundo Nombre" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="apellido01">Primer Apellido</label>
                    <input type="text" name="apellido01" class="form-control" placeholder="Primer Apellido" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="apellido2">Segundo Apellido</label>
                    <input type="text" name="apellido2" class="form-control" placeholder="Segundo Apellido" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="fecha_nacimiento">Fecha de nacimiento:</label>
                    <input type="date" name="fecha_nacimiento" class="form-control" placeholder="AAAA/MM/DD" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="residencia">Residencia</label>
                    <input type="text" name="residencia" class="form-control" placeholder="Residencia" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="telefono">Telefono</label>
                    <input type="text" name="telefono" class="form-control" placeholder="Telefono" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="enfermedad">Enfermedad</label>
                    <input type="text" name="enfermedad" class="form-control" placeholder="Enfermedad" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="alergia">Alergia</label>
                    <input type="text" name="alergia" class="form-control" placeholder="Alergia" required>
                </div> <!-- TERMINAR DE REVISAR -->
            </div>
            <button type="submit" class="btn btn-primary">Agregar cliente</button>
        </form>

        <!-- Tabla de clientes registrados -->
        <div>
            <h2 class="mb-3">Clientes registrados</h2>
            <table class="table">
                <thead>
                    <tr>
                        <th>Identificación</th>
                        <th>Primer Nombre</th>
                        <th>Segundo Nombre</th>
                        <th>Primer Apellido</th>
                        <th>Segundo Apellido</th>
                        <th>Fecha de nacimiento</th>
                        <th>Residencia</th>
                        <th>Telefono</th>
                        <th>Enfermedad</th>
                        <th>Alergia</th>
                        
                        <th colspan="2">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php while ($row = mysqli_fetch_array($query)): ?>
                        <tr>
                            <td><?= $row['id_Cliente'] ?></td>
                            <td><?= $row['nombre01'] ?></td>
                            <td><?= $row['nombre02'] ?></td>
                            <td><?= $row['apellido01'] ?></td>
                            <td><?= $row['apellido2'] ?></td>
                            <td><?= $row['fecha_nacimiento'] ?></td>
                            <td><?= $row['residencia'] ?></td>
                            <td><?= $row['numero'] ?></td>
                            <td><?= $row['enfermedades'] ?></td>
                            <td><?= $row['alergias'] ?></td>
                            
                            <td>
                                <a href="?editar=<?= $row['id_Cliente'] ?>" class="btn btn-sm btn-warning">Editar</a>
                            </td>
                            <td>
                                <form method="post" action="">
                                    <input type="hidden" name="id_Cliente_eliminar" value="<?= $row['id_Cliente'] ?>">
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
        $id_Cliente_editar = $_GET['editar'];
        $sql_editar = "SELECT cliente.*, telefono.numero, 
                GROUP_CONCAT(DISTINCT enfermedad.nombre) AS enfermedades,
                GROUP_CONCAT(DISTINCT alergia.nombre) AS alergias
        FROM cliente
        LEFT JOIN telefono ON cliente.id_Cliente = telefono.id_Cliente
        LEFT JOIN clienteEnfermedad ON cliente.id_Cliente = clienteEnfermedad.id_Cliente
        LEFT JOIN enfermedad ON clienteEnfermedad.id_Enfermedad = enfermedad.id_Enfermedad
        LEFT JOIN clienteAlergia ON cliente.id_Cliente = clienteAlergia.id_Cliente
        LEFT JOIN alergia ON clienteAlergia.id_Alergia = alergia.id_Alergia
        WHERE cliente.id_Cliente = '$id_Cliente_editar'
        GROUP BY cliente.id_Cliente";
        $result_editar = mysqli_query($con, $sql_editar);
        $cliente_editar = mysqli_fetch_assoc($result_editar);
        ?>
            <div>
                <h2 class="mt-4 mb-2">Editar Usuario - ID <?= $cliente_editar['id_Cliente'] ?></h2>
                <form method="post" action="" class="mb-4">
                    <div class="form-row">
                        <div class="form-group col-md-6">
                            <label for="id_Cliente_editar">Identificacion</label>
                            <input type="text" name="id_Cliente_editar" class="form-control" value="<?= $cliente_editar['id_Cliente'] ?>" required>
                            </div>
                        <div class="form-group col-md-6">
                            <label for="nombre01_editar">Primer Nombre</label>
                            <input type="text" name="nombre01_editar" class="form-control" value="<?= $cliente_editar['nombre01'] ?>" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="nombre02_editar">Segundo Nombre</label>
                            <input type="text" name="nombre02_editar" class="form-control" value="<?= $cliente_editar['nombre02'] ?>" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="apellido01_editar">Primer Apellido:</label>
                            <input type="text" name="apellido01_editar" class="form-control" value="<?= $cliente_editar['apellido01'] ?>" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="apellido2_editar">Segundo Apellido:</label>
                            <input type="text" name="apellido2_editar" class="form-control" value="<?= $cliente_editar['apellido2'] ?>" required>
                        </div>    
                        <div class="form-group col-md-6">
                            <label for="fecha_nacimiento_editar">Fecha de nacimiento:</label>
                            <input type="date" name="fecha_nacimiento_editar" class="form-control" value="<?= $cliente_editar['fecha_nacimiento'] ?>">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="enfermedad_editar">Enfermedad:</label>
                            <input type="text" name="enfermedad_editar" class="form-control" value="<?= $cliente_editar['enfermedades'] ?>">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="alergia_editar">Alergia:</label>
                            <input type="text" name="alergia_editar" class="form-control" value="<?= $cliente_editar['alergias'] ?>">
                        </div>
                        <div class="form-group col-md-6">    
                            <label for="numero_editar">Número de teléfono:</label>
                            <input type="text" name="numero_editar" class="form-control" value="<?= $cliente_editar['numero'] ?? '' ?>">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="residencia_editar">Residencia:</label>
                            <input type="text" name="residencia_editar" class="form-control" value="<?= $cliente_editar['residencia'] ?? '' ?>">
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
