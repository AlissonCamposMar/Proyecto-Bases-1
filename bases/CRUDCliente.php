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
        $numero_editar = $_POST['telefonos_editar'];
        $enfermedades_editar = $_POST['enfermedades'];
        $alergias_editar = $_POST['alergias'];
        
        

        // Actualizar datos en la tabla cliente
        $sql_actualizar_cliente = "UPDATE cliente
                                   SET nombre01 = '$nombre01_editar', 
                                       nombre02 = '$nombre02_editar',
                                       apellido01 = '$apellido01_editar',
                                       apellido02 = '$apellido02_editar',
                                       fecha_nacimiento = '$fecha_nacimiento_editar',
                                       residencia = '$residencia_editar'
                                   WHERE id_Cliente = '$id_Cliente_editar'";
        $result_actualizar_cliente = mysqli_query($con, $sql_actualizar_cliente);

        // Actualizar relaciones de enfermedades
        // Primero eliminamos las enfermedades existentes para el cliente
        $sql_eliminar_enfermedades = "DELETE FROM clienteEnfermedad WHERE id_Cliente = '$id_Cliente_editar'";
        mysqli_query($con, $sql_eliminar_enfermedades);

        // Ahora insertamos las nuevas relaciones de enfermedades
        if (!empty($enfermedades_editar)) {
            foreach ($enfermedades_editar as $id_Enfermedad) {
                $sql_insertar_enfermedad = "INSERT INTO clienteEnfermedad (id_Cliente, id_Enfermedad) 
                                            VALUES ('$id_Cliente_editar', '$id_Enfermedad')";
                $result_actualizar_enfermedades = mysqli_query($con, $sql_insertar_enfermedad);
            }
        }

        // Actualizar relaciones de enfermedades
        // Primero eliminamos las enfermedades existentes para el cliente
        $sql_eliminar_alergias = "DELETE FROM clienteAlergia WHERE id_Cliente = '$id_Cliente_editar'";
        mysqli_query($con, $sql_eliminar_alergias);

        // Ahora insertamos las nuevas relaciones de enfermedades
        if (!empty($alergias_editar)) {
            foreach ($alergias_editar as $id_Alergia) {
                $sql_insertar_alergia= "INSERT INTO clienteAlergia (id_Cliente, id_Alergia) 
                                        VALUES ('$id_Cliente_editar', '$id_Alergia')";
                $result_actualizar_alergias = mysqli_query($con, $sql_insertar_alergia);
            }
        }

        // Eliminar teléfonos existentes
        $sql_eliminar_telefonos = "DELETE FROM telefono WHERE id_Cliente = '$id_Cliente_editar'";
        mysqli_query($con, $sql_eliminar_telefonos);

        // Insertar teléfonos actualizados
        if (!empty($_POST['telefonos_editar'])) {
            foreach ($_POST['telefonos_editar'] as $telefono) {
                if (!empty($telefono)) {
                    $sql_insertar_telefono = "INSERT INTO telefono (numero, id_Cliente) VALUES ('$telefono', '$id_Cliente_editar')";
                    $result_actualizar_telefono = mysqli_query($con, $sql_insertar_telefono);
                }
            }
        }

        // Verifica si cada consulta fue exitosa
        ob_start();
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

        if ($result_actualizar_enfermedades) {
            echo "Enfermedad actualizada correctamente.<br>";
        } else {
            echo "Error al actualizar enfermedad: " . mysqli_error($con) . "<br>";
        }

        if ($result_actualizar_alergias) {
            echo "Alergia(s) actualizada correctamente.<br>";
        } else {
            echo "Error al actualizar alergia(s): " . mysqli_error($con) . "<br>";
        }


        // Verificar si todas las consultas fueron exitosas
        if ($result_actualizar_cliente && $result_actualizar_telefono && $result_actualizar_enfermedades && $result_actualizar_alergias) {
            // Redirigir a la página de clientes después de la actualización
            header("Location: CRUDCliente.php");
            exit();
        } else {
            echo "Error al actualizar datos: " . mysqli_error($con);
        }
        ob_end_flush();
    } elseif (isset($_POST['eliminar'])) {
        // Lógica de eliminación
        $id_Cliente_eliminar = $_POST['id_Cliente_eliminar'];

        // Eliminar datos de la tabla alergias
        $sql_eliminar_cliente_alergias = "DELETE FROM clienteAlergia WHERE id_Cliente = '$id_Cliente_eliminar'";
        $result_eliminar_cliente_alergias = mysqli_query($con, $sql_eliminar_cliente_alergias);

        // Eliminar datos de la tabla telefono
        $sql_eliminar_telefono = "DELETE FROM telefono WHERE id_Cliente = '$id_Cliente_eliminar'";
        $result_eliminar_telefono = mysqli_query($con, $sql_eliminar_telefono);

        // Eliminar datos de la tabla enfermedad
        $sql_eliminar_cliente_enfermedad = "DELETE FROM clienteEnfermedad WHERE id_Cliente = '$id_Cliente_eliminar'";
        $result_eliminar_cliente_enfermedad = mysqli_query($con, $sql_eliminar_cliente_enfermedad);

        // Eliminar datos de la tabla cliente
        $sql_eliminar_cliente = "DELETE FROM cliente WHERE id_Cliente = '$id_Cliente_eliminar'";
        $result_eliminar_cliente = mysqli_query($con, $sql_eliminar_cliente);


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
    $required_fields = ['id_Cliente', 'nombre01', 'apellido01', 'fecha_nacimiento','residencia', 'telefonos'];

    foreach ($required_fields as $field) {
        if (empty($_POST[$field])) {

            $field_label = isset($field_labels[$field]) ? $field_labels[$field] : $field;
            // Mostrar ventana de advertencia
            echo "<script>alert('Por favor, llene el campo obligatorio: $field_label.');</script>";
            echo "<script>window.location.href='CRUDCliente.php';</script>";
            exit; // Detener la ejecución si faltan datos
        }
    }
        // Lógica de inserción (la parte que maneja el formulario de agregar cliente)
        $id_Cliente = $_POST['id_Cliente'];
        $nombre01 = $_POST['nombre01'];
        $nombre02 = $_POST['nombre02'];
        $apellido01 = $_POST['apellido01'];
        $apellido02 = $_POST['apellido02'];
        $fecha_nacimiento = $_POST['fecha_nacimiento'];
        $residencia = $_POST['residencia'];
        $numero = $_POST['telefonos'];
        $enfermedad = $_POST['enfermedades'];
        $alergia = $_POST['alergias'];

        // Insertar en la tabla cliente
        $sql_cliente = "INSERT INTO cliente (id_Cliente, nombre01, nombre02, apellido01, apellido02, fecha_nacimiento, residencia) 
                        VALUES ('$id_Cliente', '$nombre01', '$nombre02', '$apellido01', '$apellido02', '$fecha_nacimiento', '$residencia')";
        $result_cliente = mysqli_query($con, $sql_cliente);

        //Insertar en la tabla telefono
        // Manejar la inserción de múltiples teléfonos
        if (!empty($_POST['telefonos'])) {
            foreach ($_POST['telefonos'] as $telefono) {
                if (!empty($telefono)) {
                    $sql_telefono = "INSERT INTO telefono (numero, id_Cliente) VALUES ('$telefono', '$id_Cliente')";
                    $result_telefono = mysqli_query($con, $sql_telefono);

                    if (!$result_telefono) {
                        die("Error al insertar teléfono: " . mysqli_error($con));
                    }
                }
            }
        }

// Insertar en la tabla cliente enfermedad
if (!empty($_POST['enfermedades'])) {
    foreach ($_POST['enfermedades'] as $id_enfermedad) {
        if (!empty($id_enfermedad)) {
            // Insertar la relación en la tabla clienteEnfermedad
            $sql_cliente_enfermedad = "INSERT INTO clienteEnfermedad (id_Cliente, id_Enfermedad) 
            VALUES ('$id_Cliente', '$id_enfermedad')";
            $result_cliente_enfermedad = mysqli_query($con, $sql_cliente_enfermedad);

            if (!$result_cliente_enfermedad) {
                die("Error al insertar relación cliente-enfermedad: " . mysqli_error($con));
            }
        }
    }
}

// Insertar en la tabla cliente alergia
if (!empty($_POST['alergias'])) {
    foreach ($_POST['alergias'] as $id_alergia) {
        if (!empty($id_alergia)) {
            // Insertar la relación en la tabla clienteAlergia
            $sql_cliente_alergias = "INSERT INTO clienteAlergia (id_Cliente, id_Alergia) 
            VALUES ('$id_Cliente', '$id_alergia')";
            $result_cliente_alergias = mysqli_query($con, $sql_cliente_alergias);

            if (!$result_cliente_alergias) {
                die("Error al insertar relación cliente-alergia: " . mysqli_error($con));
            }
        }
    }
}


        // Obtener el id_Cliente recién insertado
        $id_Cliente_insertado = mysqli_insert_id($con);

        if (!$result_cliente) {
            die("Error al insertar datos: " . mysqli_error($con));
        }
    }
}

// Consulta para obtener los datos
$sql = "SELECT
            cliente.*,
            GROUP_CONCAT(DISTINCT telefono.numero SEPARATOR ', ') AS telefonos,
            GROUP_CONCAT(DISTINCT enfermedad.nombre SEPARATOR ', ') AS enfermedades,
            GROUP_CONCAT(DISTINCT alergia.nombre SEPARATOR ', ') AS alergias
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

// Obtener todas las enfermedades para el campo <select>
$sql_enfermedades = "SELECT id_Enfermedad, nombre FROM enfermedad";
$result_enfermedades = mysqli_query($con, $sql_enfermedades);

if (!$result_enfermedades) {
    die("Error al obtener enfermedades: " . mysqli_error($con));
}

// Obtener todas las alergias para el campo <select>
$sql_alergias = "SELECT id_Alergia, nombre FROM alergia";
$result_alergias = mysqli_query($con, $sql_alergias);

if (!$result_alergias) {
    die("Error al obtener alergias: " . mysqli_error($con));
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
                    <input type="text" name="nombre02" class="form-control" placeholder="Segundo Nombre">
                </div>
                <div class="form-group col-md-6">
                    <label for="apellido01">Primer Apellido</label>
                    <input type="text" name="apellido01" class="form-control" placeholder="Primer Apellido" required>
                </div>
                <div class="form-group col-md-6">
                    <label for="apellido02">Segundo Apellido</label>
                    <input type="text" name="apellido02" class="form-control" placeholder="Segundo Apellido">
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
                    <label for="telefonos">Teléfonos</label>
                    <div id="telefono-container">
                        <div class="input-group mb-2">
                            <input type="text" name="telefonos[]" class="form-control" placeholder="Teléfono">
                            <div class="input-group-append">
                                <button type="button" class="btn btn-success" id="add-telefono">+</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="form-group col-md-6">
                    <label for="enfermedades">Enfermedad(es)</label>
                    <select name="enfermedades[]" id="enfermedades" class="form-control" multiple>
                        <?php
                        // Llenar el <select> con las enfermedades desde la base de datos
                        while ($row = mysqli_fetch_assoc($result_enfermedades)) {
                            echo "<option value='" . $row['id_Enfermedad'] . "'>" . htmlspecialchars($row['nombre']) . "</option>";
                        }
                        ?>
                    </select>
                </div>
                <div class="form-group col-md-6">
                    <label for="alergias">Alergia(s)</label>
                    <select name="alergias[]" id="alergias" class="form-control" multiple>
                        <?php
                        // Llenar el <select> con las alergias desde la base de datos
                        while ($row = mysqli_fetch_assoc($result_alergias)) {
                            echo "<option value='" . $row['id_Alergia'] . "'>" . htmlspecialchars($row['nombre']) . "</option>";
                        }
                        ?>
                    </select>
                </div> <!-- TERMINAR DE REVISAR -->
            </div>
            <button type="submit" class="btn btn-primary">Agregar cliente</button>
        </form>

        <div id="searchContainer"></div>

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
                        <th>Enfermedad(es)</th>
                        <th>Alergia(es)</th>
                        
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
                            <td><?= $row['telefonos'] ?></td>
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
        $sql_editar = "SELECT cliente.*, 
                GROUP_CONCAT(DISTINCT telefono.numero SEPARATOR ', ') AS telefonos,
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
        
        // Obtener las enfermedades asociadas al cliente
        $sql_enfermedades_cliente = "SELECT id_Enfermedad FROM clienteEnfermedad WHERE id_Cliente = '$id_Cliente_editar'";
        $result_enfermedades_cliente = mysqli_query($con, $sql_enfermedades_cliente);

        // Crear un array con los IDs de enfermedades seleccionadas
        $enfermedades_seleccionadas = [];
        while ($row = mysqli_fetch_assoc($result_enfermedades_cliente)) {
            $enfermedades_seleccionadas[] = $row['id_Enfermedad'];
        }

        // Obtener las alergias asociadas al cliente
        $sql_alergias_cliente = "SELECT id_Alergia FROM clienteAlergia WHERE id_Cliente = '$id_Cliente_editar'";
        $result_alergias_cliente = mysqli_query($con, $sql_alergias_cliente);

        // Crear un array con los IDs de alergias seleccionadas
        $alergias_seleccionadas = [];
        while ($row = mysqli_fetch_assoc($result_alergias_cliente)) {
            $alergias_seleccionadas[] = $row['id_Alergia'];
        }
        
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
                            <input type="text" name="nombre02_editar" class="form-control" value="<?= $cliente_editar['nombre02'] ?>">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="apellido01_editar">Primer Apellido:</label>
                            <input type="text" name="apellido01_editar" class="form-control" value="<?= $cliente_editar['apellido01'] ?>" required>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="apellido02_editar">Segundo Apellido:</label>
                            <input type="text" name="apellido02_editar" class="form-control" value="<?= $cliente_editar['apellido02'] ?>">
                        </div>    
                        <div class="form-group col-md-6">
                            <label for="fecha_nacimiento_editar">Fecha de nacimiento:</label>
                            <input type="date" name="fecha_nacimiento_editar" class="form-control" value="<?= $cliente_editar['fecha_nacimiento'] ?>">
                        </div>
                        <div class="form-group col-md-6">
                            <label for="enfermedades">Enfermedad(es)</label>
                            <select name="enfermedades[]" id="enfermedades" class="form-control" multiple required>
                                <?php
                                // Mostrar todas las enfermedades y marcar las seleccionadas
                                mysqli_data_seek($result_enfermedades, 0); // Reiniciar el puntero del resultado
                                while ($row = mysqli_fetch_assoc($result_enfermedades)) {
                                    $selected = in_array($row['id_Enfermedad'], $enfermedades_seleccionadas) ? 'selected' : '';
                                    echo "<option value='" . $row['id_Enfermedad'] . "' $selected>" . htmlspecialchars($row['nombre']) . "</option>";
                                }
                                ?>
                            </select>
                        </div>
                        <div class="form-group col-md-6">
                            <label for="alergias">Alergia:</label>
                            <select name="alergias[]" id="alergias" class="form-control" multiple required>
                                <?php
                                // Mostrar todas las enfermedades y marcar las seleccionadas
                                mysqli_data_seek($result_alergias, 0); // Reiniciar el puntero del resultado
                                while ($row = mysqli_fetch_assoc($result_alergias)) {
                                    $selected = in_array($row['id_Alergia'], $alergias_seleccionadas) ? 'selected' : '';
                                    echo "<option value='" . $row['id_Alergia'] . "' $selected>" . htmlspecialchars($row['nombre']) . "</option>";
                                }
                                ?>
                            </select>
                        </div>
                        <div class="form-group col-md-12">
                            <label for="telefonos_editar">Teléfonos</label>
                            <div id="telefono-container-editar">
                                <?php
                                    $telefonos = [];
                                    if (!empty($cliente_editar['telefonos'])) {
                                        $telefonos = explode(', ', $cliente_editar['telefonos']);
                                    }
                                    foreach ($telefonos as $telefono) {
                                        echo "
                                        <div class='input-group mb-2'>
                                            <input type='text' name='telefonos_editar[]' class='form-control' value='$telefono'>
                                            <div class='input-group-append'>
                                                <button type='button' class='btn btn-danger remove-telefono'>-</button>
                                            </div>
                                        </div>";
                                    }
                                ?>
                                <div class="input-group mb-2">
                                    <input type="text" name="telefonos_editar[]" class="form-control" placeholder="Teléfono">
                                    <div class="input-group-append">
                                        <button type="button" class="btn btn-success" id="add-telefono-editar">+</button>
                                    </div>
                                </div>
                            </div>
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

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const telefonoContainer = document.getElementById('telefono-container');
            const addTelefonoBtn = document.getElementById('add-telefono');

            addTelefonoBtn.addEventListener('click', function () {
                const newTelefonoInput = document.createElement('div');
                newTelefonoInput.classList.add('input-group', 'mb-2');
                newTelefonoInput.innerHTML = `
                    <input type="text" name="telefonos[]" class="form-control" placeholder="Teléfono">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-danger remove-telefono">-</button>
                    </div>
                `;
                telefonoContainer.appendChild(newTelefonoInput);

                // Añadir evento para eliminar campo
                newTelefonoInput.querySelector('.remove-telefono').addEventListener('click', function () {
                    telefonoContainer.removeChild(newTelefonoInput);
                });
            });
        });
    </script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
            const telefonoContainerEditar = document.getElementById('telefono-container-editar');
            const addTelefonoEditarBtn = document.getElementById('add-telefono-editar');

            addTelefonoEditarBtn.addEventListener('click', function () {
                const newTelefonoInput = document.createElement('div');
                newTelefonoInput.classList.add('input-group', 'mb-2');
                newTelefonoInput.innerHTML = `
                    <input type="text" name="telefonos_editar[]" class="form-control" placeholder="Teléfono">
                    <div class="input-group-append">
                        <button type="button" class="btn btn-danger remove-telefono">-</button>
                    </div>
                `;
                telefonoContainerEditar.appendChild(newTelefonoInput);

                // Añadir evento para eliminar campo
                newTelefonoInput.querySelector('.remove-telefono').addEventListener('click', function () {
                    telefonoContainerEditar.removeChild(newTelefonoInput);
                });
            });
        });
    </script>

    <script>
        document.addEventListener('DOMContentLoaded', function () {
        // Crear el campo de búsqueda
        var searchInput = document.createElement('input');
        searchInput.type = 'text';
        searchInput.id = 'searchInput';
        searchInput.placeholder = 'Buscar...';

        // Agregar un evento de búsqueda
        searchInput.addEventListener('input', function () {
            var searchValue = searchInput.value.toLowerCase();
            filterTableRows(searchValue);
        });

        // Agregar el campo de búsqueda al header
        document.getElementById('searchContainer').appendChild(searchInput);

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

</body>
</html>
