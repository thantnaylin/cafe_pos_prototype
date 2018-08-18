<?php

include("configs/database.php");
include("objects/invoice.php");

$database = new Database();
$db = $database->getConnection();

//Invoice constructer (database, shift_id, discount)
$invoice = new Invoice($db, 2, 10);

//addItem (item_id, item_modifier_id, quantity)
$invoice->addItem(1, 2, 1);
$invoice->addItem(3, null, 1);

//addSet (set_id, quantity)
$invoice->addSet(1, 1);

$invoice->previewInvoiceDetail();

//initInvoice get invoice_id for inserting orders into invoice_detail table
$invoice->initInvoice();

//insert all order into invoice_detail table
$invoice->finalizeInvoice();


?>
