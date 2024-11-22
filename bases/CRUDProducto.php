<?php
include('conexion.php');
$con = connection();

// Verificar la conexión
if ($con->connect_error) {
    die("La conexión falló: " . $con->connect_error);
}

// Verificar si el formulario ha sido enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {

    if (isset($_POST['editar'])) { //Edicion

        // Recibir los datos del formulario
        $nombre = $_POST['nombre'];
        $descripcion = $_POST['descripcion'];
        $precio = $_POST['precio'];
        $id_producto_tipo = $_POST['producto'];
        $id_producto = $_POST['id_Producto'];

        // Preparar la consulta para insertar el producto
        $stmt = $con->prepare("UPDATE
                                    producto
                                SET
                                    nombre = ?,
                                    descripcion = ?,
                                    precio = ?,
                                    id_Producto_Tipo = ?
                                WHERE id_Producto = ?");
        $stmt->bind_param("ssdii", $nombre, $descripcion, $precio, $id_producto_tipo, $id_producto);

        // Ejecutar la consulta
        if ($stmt->execute()) {
            echo "<script>alert('Producto editado correctamente.'); window.location.href='CRUDProducto.php';</script>";
            exit();
        } else {
            echo "Error al editar el producto: " . $stmt->error;
        }

        // Cerrar la declaración
        $stmt->close();
        
    } elseif (isset($_POST['eliminar'])) { //Eliminacion

        $id_producto = $_POST['id_Producto_eliminar'];

        // Preparar la consulta para insertar el producto
        $stmt = $con->prepare("DELETE FROM producto WHERE id_Producto = ? ");
        $stmt->bind_param("i", $id_producto);

        // Ejecutar la consulta
        if ($stmt->execute()) {
            echo "<script>alert('Producto eliminado correctamente.'); window.location.href='CRUDProducto.php';</script>";
            exit();
        } else {
            echo "Error al eliminar el producto: " . $stmt->error;
        }

        // Cerrar la declaración
        $stmt->close();

    } else { //Insercion

        // Recibir los datos del formulario
        $nombre = $_POST['nombre'];
        $descripcion = $_POST['descripcion'];
        $precio = $_POST['precio'];
        $id_producto_tipo = $_POST['producto'];

        // Preparar la consulta para insertar el producto
        $stmt = $con->prepare("INSERT INTO producto (nombre, descripcion, precio, id_Producto_Tipo) VALUES (?, ?, ?, ?)");
        $stmt->bind_param("ssdi", $nombre, $descripcion, $precio, $id_producto_tipo);

        // Ejecutar la consulta
        if ($stmt->execute()) {
            echo "<script>alert('Producto agregado correctamente.'); window.location.href='CRUDProducto.php';</script>";
            exit();
        } else {
            echo "Error al agregar el producto: " . $stmt->error;
        }

        // Cerrar la declaración
        $stmt->close();
    }
}
?>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CRUD PRODUCTO</title>
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
        <h1 class="mt-4 mb-2">Crear Producto</h1>
        <form method="post" action="" class="mb-4">
            <div class="form-row">
                
                <!-- Campo de Nombre del Producto -->
                <div class="form-group col-md-6">
                    <label for="nombre">Nombre</label>
                    <input type="text" name="nombre" class="form-control" placeholder="Nombre" required>
                </div>

                <!-- Campo de Descripción del Producto -->
                <div class="form-group col-md-6">
                    <label for="descripcion">Descripción</label>
                    <input type="text" name="descripcion" class="form-control" placeholder="Descripción" required>
                </div>

                <!-- Campo de Precio del Producto -->
                <div class="form-group col-md-6">
                    <label for="precio">Precio</label>
                    <input type="number" name="precio" class="form-control" placeholder="Precio" required>
                </div>

                <!-- Selección de Tipo de Producto -->
                <div class="form-group col-md-6">
                    <label for="producto">Tipo de Producto:</label>
                    <select name="producto" class="form-control" required>
                        <option value="" disabled selected>Seleccionar tipo de producto</option>
                        <?php 
                        // Consulta SQL para obtener los tipos de productos
                        $query_tipo_productos = mysqli_query($con, "SELECT id_Producto_Tipo, tipo FROM producto_Tipo");
                        // Iteramos sobre los resultados

                        if (!$query_tipo_productos) {
                            die("Error en la consulta de clientes: " . mysqli_error($con));
                        }

                        while ($producto_tipo = mysqli_fetch_assoc($query_tipo_productos)): ?>
                        <option value="<?= $producto_tipo['id_Producto_Tipo'] ?>">
                            <?= $producto_tipo['id_Producto_Tipo'] . ' - ' . $producto_tipo['tipo'] ?>
                        </option>
                        <?php endwhile; ?>
                    </select>
                </div>

                <!-- Botón de Agregar Producto -->
                <div class="form-group col-md-12">
                    <button type="submit" class="btn btn-primary btn-block">Agregar producto</button>
                </div>
            </div>
        </form>

        <div id="searchContainer"></div>
        <!-- Tabla de productos registrados -->
        <div>
            <h2 class="mb-3">Productos registrados</h2>
            <table class="table">
                <thead>
                    <tr>
                        <th>Nombre</th>
                        <th>Descripción</th>
                        <th>Precio</th>
                        <th>Tipo de Producto</th>
                        <th colspan="2">Acciones</th>
                    </tr>
                </thead>
                <tbody>
                    <?php
                    // Realiza la consulta para obtener los productos
                    $query_productos = mysqli_query($con, "SELECT id_Producto, nombre, descripcion, precio, tipo 
                                                        FROM producto  
                                                        JOIN producto_Tipo  ON producto.id_Producto_Tipo = producto_Tipo.id_Producto_Tipo");
                    // Iteramos sobre los resultados de los productos
                    while ($row = mysqli_fetch_array($query_productos)): ?>
                        <tr>
                            <td><?= $row['nombre'] ?></td>
                            <td><?= $row['descripcion'] ?></td>
                            <td><?= $row['precio'] ?></td>
                            <td><?= $row['tipo'] ?></td>
                            
                            <!-- Acción de editar producto -->
                            <td>
                                <a href="?editar=<?= $row['id_Producto'] ?>" class="btn btn-sm btn-warning">Editar</a>
                            </td>
                            <!-- Acción de eliminar producto -->
                            <td>
                                <form method="post" action="">
                                    <input type="hidden" name="id_Producto_eliminar" value="<?= $row['id_Producto'] ?>">
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
                $id_producto_editar = $_GET['editar'];

                $stmt = $con->prepare("SELECT * FROM producto WHERE id_Producto = ?");
                $stmt->bind_param("i", $id_producto_editar);

                // Ejecutar la consulta
                if (!$stmt->execute()) {
                    echo "Error al encontrar productos: " . $stmt->error;
                }

                $producto_editar = $stmt->get_result();
                $stmt->close();

                while ($row = $producto_editar->fetch_assoc()) {
                    // Access the data from the row
                    $id_producto = $row['id_Producto'];
                    $nombre_producto = $row['nombre'];
                    $precio = $row['precio'];
                    $descripcion = $row['descripcion'];
                    $producto_tipo = $row['id_Producto_Tipo'];
                }
            ?>
            <div>
                <h2 class="mt-4 mb-2">Editar Producto - <?= $nombre_producto ?></h2>
                <form method="post" action="" class="mb-4">
                    <div class="form-row">

                        <input type="hidden" name="id_Producto" value="<?= $id_producto ?>">
                        
                        <!-- Campo de Nombre del Producto -->
                        <div class="form-group col-md-6">
                            <label for="nombre">Nombre</label>
                            <input type="text" name="nombre" class="form-control" placeholder="Nombre" value="<?= $nombre_producto ?>" required>
                        </div>

                        <!-- Campo de Descripción del Producto -->
                        <div class="form-group col-md-6">
                            <label for="descripcion">Descripción</label>
                            <input type="text" name="descripcion" class="form-control" placeholder="Descripción" value="<?= $descripcion ?>" required>
                        </div>

                        <!-- Campo de Precio del Producto -->
                        <div class="form-group col-md-6">
                            <label for="precio">Precio</label>
                            <input type="number" name="precio" class="form-control" placeholder="Precio" value="<?= $precio ?>" required>
                        </div>

                        <!-- Selección de Tipo de Producto -->
                        <div class="form-group col-md-6">
                            <label for="producto">Tipo de Producto:</label>
                            <select name="producto" class="form-control" required>
                                <?php
                                    // Obtener todos los productos
                                    $query_tipo_productos = mysqli_query($con, "SELECT id_Producto_Tipo, tipo FROM producto_Tipo");
                                    if (!$query_tipo_productos) {
                                        die("Error en la consulta de tipos de producto: " . mysqli_error($con));
                                    }
                                    
                                    // Iterar sobre los productos para crear opciones
                                    while ($tipo_producto = mysqli_fetch_assoc($query_tipo_productos)) {
                                        // Comprobar si el producto es el actual del cita
                                        $selected = ($tipo_producto['id_Producto_Tipo'] == $producto_tipo) ? 'selected' : '';
                                        
                                        // Imprimir la opción
                                        echo "<option value='{$tipo_producto['id_Producto_Tipo']}' $selected>{$tipo_producto['id_Producto_Tipo']} - {$tipo_producto['tipo']}</option>";
                                    }
                                ?>
                            </select>
                        </div>

                        <!-- Botón de Agregar Producto -->
                        <div class="form-group col-md-12">
                            <button type="submit" name="editar" class="btn btn-primary btn-block">Guardar producto</button>
                        </div>
                    </div>
                </form>
            </div>
        <?php endif; ?>

    </div>

        <!-- Bootstrap JS y otros scripts -->
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

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>