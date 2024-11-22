<?php
require_once('fpdf/fpdf.php');

if ($_SERVER["REQUEST_METHOD"] == "POST") {
    $consulta = $_POST["consulta"];

    // Obtén los datos según la consulta
    switch ($consulta) {
        case "1":
            $data = $_POST['data1']; // Usa los datos de la Consulta 1
            $header = "Consulta 1: Clientes con diabetes nacidos antes del año 2000";
            break;
        case "2":
            $data = $_POST['data2']; // Usa los datos de la Consulta 2
            $header = "Consulta 2: Empleados con salario mayor a 50000, que cualquiera\nde sus nombres inicia con 'm' y ordenalos desde menor a mayor salario";
            break;
        case "3":
            $data = $_POST['data3']; // Usa los datos de la Consulta 3
            $header = "Consulta 3: Citas con duración superior a 1 hora";
            break;
        case "5":
            $data = $_POST['data5']; // Usa los datos de la Consulta 3
            $header = "Consulta 5: Contar la cantidad de citas que ha realizado cada empleado,\nimprimiendo ID empleado, nombre empleado y detalles de la cita";
            break;
        case "6":
            $data = $_POST['data6']; // Usa los datos de la Consulta 3
            $header = "Consulta 6: Obtener la cantidad total de productos que ha proporcionado cada proveedor";
            break;
        case "7":
            $data = $_POST['data7']; // Usa los datos de la Consulta 1
            $header = "Consulta 7: Listar los empleados y la cantidad de productos\nque han manejado, ordenados por la cantidad de productos de forma descendente";
            break;
        case "8":
            $data = $_POST['data8']; // Usa los datos de la Consulta 2
            $header = "Consulta 8: Listar las citas junto con los detalles del cliente,\nel empleado y el servicio para las citas programadas para un día específico";
            break;
        case "9":
            $data = $_POST['data9']; // Usa los datos de la Consulta 3
            $header = "Consulta 9: Mostrar los clientes que tienen más citas que el promedio";
            break;
        case "10":
            $data = $_POST['data10']; // Usa los datos de la Consulta 3
            $header = "Consulta 10: Encontrar los empleados que han atendido todos los tipos de productos/servicios";
            break;
        case "11":
            $data = $_POST['data11']; // Usa los datos de la Consulta 3
            $header = "Consulta 11: Mostrar los clientes que han gastado más que el promedio en facturas";
            break;
            break;
        // Agrega más casos para otras consultas
    }

    // Genera y muestra el PDF
    generatePDF($data, $_POST["filename"], $header);
}

function generatePDF($data, $filename, $header) {
    // Crear una nueva instancia de FPDF
    $pdf = new FPDF();
    $pdf->AddPage();

    // Agregar imagen como fondo
    $pdf->Image('./imagenes/fondo.png', 0, 0, $pdf->GetPageWidth(), $pdf->GetPageHeight());

    // Configurar la fuente y tamaño
    $pdf->SetFont('Arial', 'B', 12);

    // Posiciona el texto en una ubicación específica en la página
    $pdf->SetXY(10, 10);
    $pdf->Cell(0, 10, $header, 0, 1, 'C');

    // Contenido del informe
    foreach ($data as $row) {
        foreach ($row as $column) {
            $pdf->Cell(40, 10, $column, 1);
        }
        $pdf->Ln();
    }

    // Salida del PDF al navegador
    $pdf->Output($filename, 'I');
}
?>
