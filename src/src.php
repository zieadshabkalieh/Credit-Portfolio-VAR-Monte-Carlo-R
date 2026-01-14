<?php
require 'vendor/autoload.php'; // Load PHPSpreadsheet

use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

// Cholesky Decomposition Function
function choleskyDecomposition($matrix) {
    $n = count($matrix);
    $L = array_fill(0, $n, array_fill(0, $n, 0)); // Initialize L matrix with zeroes

    for ($i = 0; $i < $n; $i++) {
        for ($j = 0; $j <= $i; $j++) {
            $sum = 0;

            if ($j == $i) { // Diagonal elements
                for ($k = 0; $k < $j; $k++) {
                    $sum += pow($L[$j][$k], 2);
                }
                $L[$j][$j] = sqrt($matrix[$j][$j] - $sum);
            } else {
                for ($k = 0; $k < $j; $k++) {
                    $sum += $L[$i][$k] * $L[$j][$k];
                }
                $L[$i][$j] = ($matrix[$i][$j] - $sum) / $L[$j][$j];
            }
        }
    }

    return $L;
}

// Get matrix from form submission
$matrix = $_POST['matrix'];

// Convert all elements to float (ensure numeric data)
foreach ($matrix as $i => $row) {
    foreach ($row as $j => $value) {
        $matrix[$i][$j] = (float) $value;
    }
}

// Perform Cholesky decomposition on the matrix
$choleskyMatrix = choleskyDecomposition($matrix);

// Create a new Spreadsheet
$spreadsheet = new Spreadsheet();
$sheet = $spreadsheet->getActiveSheet();

// Populate the spreadsheet with the Cholesky decomposition result
foreach ($choleskyMatrix as $i => $row) {
    foreach ($row as $j => $value) {
        // Convert row and column indices to Excel notation (A1, B1, etc.)
        $cell = chr(65 + $j) . ($i + 1);
        $sheet->setCellValue($cell, $value);
    }
}

// Save the file to a temporary location
$filename = 'CholeskyDecomposition.xlsx';
$temp_file = tempnam(sys_get_temp_dir(), $filename);
$writer = new Xlsx($spreadsheet);
$writer->save($temp_file);

// Display result and provide download button
echo "<h2>Cholesky Decomposition Result</h2>";
echo "<pre>";
foreach ($choleskyMatrix as $row) {
    foreach ($row as $value) {
        printf("%.4f ", $value);
    }
    echo "\n";
}
echo "</pre>";
echo "<a href='download.php?file=" . urlencode($temp_file) . "' class='download-btn'>Download Result as Excel</a>";
?>

<style>
    .download-btn {
        display: inline-block;
        padding: 10px 20px;
        background-color: #6a1b9a;
        color: #fff;
        text-decoration: none;
        border-radius: 4px;
        font-size: 16px;
        margin-top: 20px;
    }

    .download-btn:hover {
        background-color: #551a8b;
    }
</style>
هذا كود البحث الثاني
