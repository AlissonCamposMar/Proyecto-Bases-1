<?php
include('conexion.php');
$con = connection();


// Verificar la conexión
if ($con->connect_error) {
    die("La conexión falló: " . $con->connect_error);
}

// Verificar si el formulario ha sido enviado
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Recibir los datos del formulario
    $nombre = $_POST['nombre'];
    $descripcion = $_POST['descripcion'];
    $precio = $_POST['precio'];
    $id_producto_tipo = $_POST['id_producto_tipo'];

    // Preparar la consulta para insertar el producto
    $stmt = $con->prepare("INSERT INTO Producto (nombre, descripcion, precio, id_producto_tipo) VALUES (?, ?, ?, ?)");
    $stmt->bind_param("ssdi", $nombre, $descripcion, $precio, $id_producto_tipo);

    // Ejecutar la consulta
    if ($stmt->execute()) {
        echo "Producto agregado correctamente.";
    } else {
        echo "Error al agregar el producto: " . $stmt->error;
    }

    // Cerrar la declaración
    $stmt->close();
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
        <!-- Campo de Código del Producto -->
        <div class="form-group col-md-6">
            <label for="id_Producto">Código</label>
            <input type="text" name="id_Producto" class="form-control" placeholder="Código" required>
        </div>
        
        <!-- Campo de Nombre del Producto -->
        <div class="form-group col-md-6">
            <label for="nombre">Nombre</label>
            <input type="text" name="nombre" class="form-control" placeholder="Nombre" required>
        </div>
    </div>

    <div class="form-row">
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
    </div>

    <div class="form-row">
        <!-- Selección de Tipo de Producto -->
        <div class="form-group col-md-6">
            <label for="producto">Tipo de Producto:</label>
            <select name="producto" class="form-control" required>
                <option value="" disabled selected>Seleccionar tipo de producto</option>
                <?php 
                // Consulta SQL para obtener los tipos de productos
                $query_tipo_productos = mysqli_query($con, "SELECT id_Producto_Tipo, tipo FROM producto_tipo");
                // Iteramos sobre los resultados
                while ($producto_tipo = mysqli_fetch_assoc($query_tipo_productos)): ?>
                <option value="<?= $producto_tipo['id_Producto_Tipo'] ?>">
                    <?= $producto_tipo['id_Producto_Tipo'] . ' - ' . $producto_tipo['tipo'] ?>
                </option>
                <?php endwhile; ?>
            </select>
        </div>
    </div>

    <!-- Botón de Agregar Producto -->
    <div class="form-row">
        <div class="form-group col-md-12">
            <button type="submit" class="btn btn-primary btn-block">Agregar producto</button>
        </div>
    </div>
</form>
<!-- Tabla de productos registrados -->
<div>
    <h2 class="mb-3">Productos registrados</h2>
    <table class="table">
        <thead>
            <tr>
                <th>Código</th>
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
                                                   JOIN producto_tipo  ON producto.id_Producto_Tipo = producto_tipo.id_Producto_Tipo");
            // Iteramos sobre los resultados de los productos
            while ($row = mysqli_fetch_array($query_productos)): ?>
                <tr>
                    <td><?= $row['id_Producto'] ?></td>
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


        <!-- Bootstrap JS y otros scripts -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </body>