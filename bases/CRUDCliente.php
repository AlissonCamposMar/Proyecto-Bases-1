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
        $apellido02_editar = $_POST['apellido02_editar'];
        $fecha_nacimiento_editar = $_POST['fecha_nacimiento_editar'];
        $residencia_editar = $_POST['residencia_editar'];
        $numero_editar = $_POST['numero_editar'];
        $enfermedades_editar = isset($_POST['enfermedades']) ? $_POST['enfermedades'] : [];
        $alergias_editar = isset($_POST['alergias']) ? $_POST['alergias'] : [];
        
        

        // Actualizar datos en la tabla cliente
        $sql_actualizar_cliente = "UPDATE cliente
                                   SET nombre01 = '$nombre01_editar',nombre02 = '$nombre02_editar',
                                       apellido01 = '$apellido01_editar',apellido02 = '$apellido02_editar',
                                       fecha_nacimiento = '$fecha_nacimiento_editar',
                                       residencia = '$residencia_editar'
                                   WHERE id_Cliente = '$id_Cliente_editar'";
        $result_actualizar_cliente = mysqli_query($con, $sql_actualizar_cliente);

        // Actualizar datos en la tabla telefono
        $sql_actualizar_telefono = "UPDATE telefono
                                     SET nombre = '$numero_editar'
                                     WHERE id_Cliente = '$id_Cliente_editar'";
        $result_actualizar_telefono = mysqli_query($con, $sql_actualizar_telefono);

        // Actualizar enfermedades: Eliminar las enfermedades anteriores y agregar las nuevas
if (!empty($enfermedades_editar)) {
    // Eliminar las enfermedades actuales del cliente
    $sql_eliminar_enfermedades = "DELETE FROM clienteEnfermedad WHERE id_Cliente = '$id_Cliente_editar'";
    $result_eliminar_enfermedades = mysqli_query($con, $sql_eliminar_enfermedades);
    if (!$result_eliminar_enfermedades) {
        die("Error al eliminar enfermedades: " . mysqli_error($con));
    }

    // Insertar las nuevas enfermedades asociadas al cliente
    foreach ($enfermedades_editar as $id_enfermedad) {
        $id_enfermedad = mysqli_real_escape_string($con, $id_enfermedad);
        $sql_insertar_enfermedad = "INSERT INTO clienteEnfermedad (id_Cliente, id_Enfermedad) VALUES ('$id_Cliente_editar', '$id_enfermedad')";
        $result_insertar_enfermedad = mysqli_query($con, $sql_insertar_enfermedad);
        if (!$result_insertar_enfermedad) {
            die("Error al insertar enfermedad: " . mysqli_error($con));
        }
    }
}

        // Actualizar alergias: Eliminar las alergias anteriores y agregar las nuevas
if (!empty($alergias_editar)) {
    // Eliminar las alergias actuales del cliente
    $sql_eliminar_alergias = "DELETE FROM clienteAlergia WHERE id_Cliente = '$id_Cliente_editar'";
    $result_eliminar_alergias = mysqli_query($con, $sql_eliminar_alergias);
    if (!$result_eliminar_alergias) {
        die("Error al eliminar alergias: " . mysqli_error($con));
    }

    // Insertar las nuevas alergias asociadas al cliente
    foreach ($alergias_editar as $id_alergia) {
        $id_alergia = mysqli_real_escape_string($con, $id_alergia);
        $sql_insertar_alergia = "INSERT INTO clienteAlergia (id_Cliente, id_Alergia) VALUES ('$id_Cliente_editar', '$id_alergia')";
        $result_insertar_alergia = mysqli_query($con, $sql_insertar_alergia);
        if (!$result_insertar_alergia) {
            die("Error al insertar alergia: " . mysqli_error($con));
        }
    }
}

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



        // Verificar si todas las consultas fueron exitosas
        if ($result_actualizar_cliente && $result_actualizar_telefono) {
            // Redirigir a la página de clientes después de la actualización
            header("Location: CRUDCliente.php");
            exit();
        } else {
            echo "Error al actualizar datos: " . mysqli_error($con);
        }
    } elseif (isset($_POST['eliminar'])) {
        // Lógica de eliminación
        $id_Cliente_eliminar = $_POST['id_Cliente_eliminar'];

        // Eliminar datos de la tabla telefono
        $sql_eliminar_telefono = "DELETE FROM telefono WHERE id_Cliente = '$id_Cliente_eliminar'";
        $result_eliminar_telefono = mysqli_query($con, $sql_eliminar_telefono);

       // Eliminar las enfermedades asociadas al cliente
$sql_eliminar_cliente_enfermedad = "DELETE FROM clienteEnfermedad WHERE id_Cliente = '$id_Cliente_eliminar'";
$result_eliminar_cliente_enfermedad = mysqli_query($con, $sql_eliminar_cliente_enfermedad);
if (!$result_eliminar_cliente_enfermedad) {
    die("Error al eliminar enfermedades asociadas al cliente: " . mysqli_error($con));
}

// Eliminar las alergias asociadas al cliente
$sql_eliminar_cliente_alergia = "DELETE FROM clienteAlergia WHERE id_Cliente = '$id_Cliente_eliminar'";
$result_eliminar_cliente_alergia = mysqli_query($con, $sql_eliminar_cliente_alergia);
if (!$result_eliminar_cliente_alergia) {
    die("Error al eliminar alergias asociadas al cliente: " . mysqli_error($con));
}

// Ahora eliminar al cliente de la tabla principal (si es necesario)
$sql_eliminar_cliente = "DELETE FROM cliente WHERE id_Cliente = '$id_Cliente_eliminar'";
$result_eliminar_cliente = mysqli_query($con, $sql_eliminar_cliente);
if (!$result_eliminar_cliente) {
    die("Error al eliminar cliente: " . mysqli_error($con));
}

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
    $required_fields = ['id_Cliente', 'nombre01','nombre02', 'apellido01','apellido02', 'fecha_nacimiento','residencia','telefono'];

    foreach ($required_fields as $field) {
        if (empty($_POST[$field])) {
            // Mostrar ventana de advertencia
            echo "<script>alert('Por favor, llene todos los campos obligatorios.');</script>";
            echo "<script>window.location.href='CRUDCliente.php';</script>";
            exit; // Detener la ejecución si faltan datos
        }
    }
    $id_Cliente = $_POST['id_Cliente'];
    $nombre01 = $_POST['nombre01'];
    $nombre02 = $_POST['nombre02'];
    $apellido01 = $_POST['apellido01'];
    $apellido02 = $_POST['apellido02'];
    $fecha_nacimiento = $_POST['fecha_nacimiento'];
    $residencia = $_POST['residencia'];
    $numero = $_POST['telefono'];
    $enfermedades = isset($_POST['enfermedades']) ? $_POST['enfermedades'] : []; // Asegurarse de que es un arreglo
    $alergias = isset($_POST['alergias']) ? $_POST['alergias'] : []; // Asegurarse de que es un arreglo
    
    // Insertar en la tabla cliente
    $sql_cliente = "INSERT INTO cliente (id_Cliente, nombre01, nombre02, apellido01, apellido02, fecha_nacimiento, residencia) 
                    VALUES ('$id_Cliente', '$nombre01', '$nombre02', '$apellido01', '$apellido02', '$fecha_nacimiento', '$residencia')";
    $result_cliente = mysqli_query($con, $sql_cliente);
    
    // Verificar si la inserción en cliente fue exitosa
    if (!$result_cliente) {
        die("Error al insertar cliente: " . mysqli_error($con));
    }
    
    // Insertar en la tabla telefono
    $sql_telefono = "INSERT INTO telefono (numero, id_Cliente) 
                     VALUES ('$numero','$id_Cliente')";
    $result_telefono = mysqli_query($con, $sql_telefono);
    
    // Verificar si la inserción en telefono fue exitosa
    if (!$result_telefono) {
        die("Error al insertar teléfono: " . mysqli_error($con));
    }
    
    // Insertar las enfermedades en la tabla clienteEnfermedad
    if (!empty($enfermedades)) {
        foreach ($enfermedades as $id_Enfermedad) {
            $sql_cliente_enfermedad = "INSERT INTO clienteEnfermedad (id_Cliente, id_Enfermedad) 
                                       VALUES ('$id_Cliente', '$id_Enfermedad')";
            $result_cliente_enfermedad = mysqli_query($con, $sql_cliente_enfermedad);
    
            if (!$result_cliente_enfermedad) {
                die("Error al insertar enfermedad: " . mysqli_error($con));
            }
        }
    }
    
    // Insertar las alergias en la tabla clienteAlergia
    if (!empty($alergias)) {
        foreach ($alergias as $id_Alergia) {
            $sql_cliente_alergia = "INSERT INTO clienteAlergia (id_Cliente, id_Alergia) 
                                    VALUES ('$id_Cliente', '$id_Alergia')";
            $result_cliente_alergia = mysqli_query($con, $sql_cliente_alergia);
    
            if (!$result_cliente_alergia) {
                die("Error al insertar alergia: " . mysqli_error($con));
            }
        }
    }
    
    // Si todo fue exitoso
    echo "Datos insertados correctamente.";
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
                    <label for="apellido02">Segundo Apellido</label>
                    <input type="text" name="apellido02" class="form-control" placeholder="Segundo Apellido" required>
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
    <label for="enfermedades">Enfermedad(es)</label>
    <select name="enfermedades[]" id="enfermedades" class="form-control" multiple required>
        <option value="" disabled>Seleccionar enfermedad(es)</option>
        <?php
        // Obtener las enfermedades de la base de datos
        $query_enfermedades = "SELECT * FROM enfermedad";
        $result_enfermedades = mysqli_query($con, $query_enfermedades);

        // Mostrar todas las enfermedades como opciones
        while ($enfermedad = mysqli_fetch_assoc($result_enfermedades)) {
            echo "<option value='" . $enfermedad['id_Enfermedad'] . "'>" . htmlspecialchars($enfermedad['nombre']) . "</option>";
        }
        ?>
    </select>
</div>

<div class="form-group col-md-6">
    <label for="alergias">Alergia(s)</label>
    <select name="alergias[]" id="alergias" class="form-control" multiple required>
        <option value="" disabled>Seleccionar alergia(s)</option>
        <?php
        // Obtener las alergias de la base de datos
        $query_alergias = "SELECT * FROM alergia";
        $result_alergias = mysqli_query($con, $query_alergias);

        // Mostrar todas las alergias como opciones
        while ($alergia = mysqli_fetch_assoc($result_alergias)) {
            echo "<option value='" . $alergia['id_Alergia'] . "'>" . htmlspecialchars($alergia['nombre']) . "</option>";
        }
        ?>
    </select>
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
                            <td><?= $row['apellido02'] ?></td>
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
                            <label for="apellido02_editar">Segundo Apellido:</label>
                            <input type="text" name="apellido02_editar" class="form-control" value="<?= $cliente_editar['apellido02'] ?>" required>
                        </div>    
                        <div class="form-group col-md-6">
                            <label for="fecha_nacimiento_editar">Fecha de nacimiento:</label>
                            <input type="date" name="fecha_nacimiento_editar" class="form-control" value="<?= $cliente_editar['fecha_nacimiento'] ?>">
                        </div>
                        <div class="form-group col-md-6">
    <label for="enfermedades">Enfermedad(es)</label>
    <select name="enfermedades[]" id="enfermedades" class="form-control" multiple required>
        <option value="" disabled>Seleccionar enfermedad(es)</option>
        <?php
        // Obtener las enfermedades de la base de datos
        $query_enfermedades = "SELECT * FROM enfermedad";
        $result_enfermedades = mysqli_query($con, $query_enfermedades);

        // Obtener las enfermedades del cliente (esto asume que $cliente_editar['enfermedades'] es un array de IDs de enfermedades)
        $enfermedades_cliente = explode(',', $cliente_editar['enfermedades']); // Suponiendo que las enfermedades están separadas por coma

        // Mostrar todas las enfermedades como opciones y marcar las seleccionadas
        while ($enfermedad = mysqli_fetch_assoc($result_enfermedades)) {
            $selected = in_array($enfermedad['id_Enfermedad'], $enfermedades_cliente) ? 'selected' : '';
            echo "<option value='" . $enfermedad['id_Enfermedad'] . "' $selected>" . htmlspecialchars($enfermedad['nombre']) . "</option>";
        }
        ?>
    </select>
</div>
<div class="form-group col-md-6">
    <label for="alergias">Alergia(s)</label>
    <select name="alergias[]" id="alergias" class="form-control" multiple required>
        <option value="" disabled>Seleccionar alergia(s)</option>
        <?php
        // Obtener las alergias de la base de datos
        $query_alergias = "SELECT * FROM alergia";
        $result_alergias = mysqli_query($con, $query_alergias);

        // Obtener las alergias del cliente (esto asume que $cliente_editar['alergias'] es un array de IDs de alergias)
        $alergias_cliente = explode(',', $cliente_editar['alergias']); // Suponiendo que las alergias están separadas por coma

        // Mostrar todas las alergias como opciones y marcar las seleccionadas
        while ($alergia = mysqli_fetch_assoc($result_alergias)) {
            $selected = in_array($alergia['id_Alergia'], $alergias_cliente) ? 'selected' : '';
            echo "<option value='" . $alergia['id_Alergia'] . "' $selected>" . htmlspecialchars($alergia['nombre']) . "</option>";
        }
        ?>
    </select>
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
