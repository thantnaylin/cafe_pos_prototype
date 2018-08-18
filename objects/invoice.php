<?php

class Invoice {

  private $shift_id;
  private $discount=0;
  private $invoice_detail = [];
  private $con;

  private $invoice_id;

  public function __construct($db, $shift_id, $discount) {

    $this->con = $db;
    $this->shift_id = $shift_id;
    $this->discount = $discount;
  }

  public function addItem($item_id, $modifier_id, $quantity) {
    $query = "SELECT i.name as 'Item Name', i.price as 'Item Price' FROM items as i WHERE i.item_id = :item_id";

    $query_mod = "SELECT i.name as 'Item Name', i.price as 'Item Price', m.modifier_description as Modifier, m.price as 'Mod Price' FROM items as i
              LEFT JOIN modifiers as m ON m.id = :modifier_id WHERE i.item_id = :item_id";
    if($modifier_id == null) {
      $stmt = $this->con->prepare($query);
      $stmt->bindParam(":item_id", $item_id);
    } else {
      $stmt = $this->con->prepare($query_mod);
      $stmt->bindParam(":item_id", $item_id);
      $stmt->bindParam(":modifier_id", $modifier_id);
    }

    $stmt->execute();
    $item = $stmt->fetch();
    $item['Item ID'] = $item_id;
    $item['Mod ID'] = $modifier_id;
    $item['Quantity'] = $quantity;

    $this->invoice_detail['Items'][] = $item;
  }

  public function addSet($set_id, $quantity) {

    $query = "SELECT s.description, s.price, i.name FROM sets as s
              LEFT JOIN set_items as si
              ON s.set_id = si.set_id
              LEFT JOIN items as i
              ON si.item_id = i.item_id
              WHERE s.set_id = :set_id";

    $stmt = $this->con->prepare($query);
    $stmt->bindParam(":set_id", $set_id);
    $stmt->execute();

    $result = $stmt->fetchAll();
    $set=['Set ID'=> $set_id, 'Quantity' => $quantity,'Description' => $result[0]['description'], 'Price' => $result[0]['price'], 'Set Items' => []];
    foreach($result as $r) {
      $set['Set Items'][] = $r['name'];
    }

    $this->invoice_detail['Sets'][] = $set;

  }

  public function initInvoice() {
    $query = "INSERT INTO invoices SET shift_id=:shift_id, discount=:discount";

    $stmt = $this->con->prepare($query);

    $stmt->bindParam(":shift_id", $this->shift_id);
    $stmt->bindParam(":discount", $this->discount);

    $stmt->execute();

    $this->invoice_id = $this->con->lastInsertId();
  }

  public function finalizeInvoice() {
    $insert_item = "INSERT INTO invoice_details (invoice_id, item_id, quantity) VALUES (:invoice_id, :item_id, :quantity)";
    $insert_item_mod = "INSERT INTO invoice_details (invoice_id, item_id, item_modifier_id, quantity) VALUES (:invoice_id, :item_id, :item_modifier_id, :quantity)";
    $insert_set = "INSERT INTO invoice_details (invoice_id, set_id, quantity) VALUES(:invoice_id, :set_id, :quantity)";

    foreach($this->invoice_detail['Items'] as $item) {
      if($item['Mod ID'] == null) {
        $stmt = $this->con->prepare($insert_item);
        $stmt->bindParam(":invoice_id", $this->invoice_id);
        $stmt->bindParam(":item_id", $item['Item ID']);
        $stmt->bindParam(":quantity", $item['Quantity']);
        $stmt->execute();
      } else {
        $stmt = $this->con->prepare($insert_item_mod);
        $stmt->bindParam(":invoice_id", $this->invoice_id);
        $stmt->bindParam(":item_id", $item['Item ID']);
        $stmt->bindParam(":item_modifier_id", $item['Mod ID']);
        $stmt->bindParam(":quantity", $item['Quantity']);
        $stmt->execute();
      }

    }

    foreach($this->invoice_detail['Sets'] as $set) {
      $stmt = $this->con->prepare($insert_set);

      $stmt->bindParam(":invoice_id", $this->invoice_id);
      $stmt->bindParam(":set_id", $set['Set ID']);
      $stmt->bindParam(":quantity", $set['Quantity']);

      $stmt->execute();
    }
  }

  public function clearOrder() {
    $this->invoice_detail = [];
  }

  public function previewInvoiceDetail() {
    $sub_total = 0;

    echo "----------------------------------------\n";
    echo "QTY ITEM                          AMOUNT\n";
    echo "----------------------------------------\n";
    $sets = $this->invoice_detail['Sets'];
    $items = $this->invoice_detail['Items'];
    foreach($sets as $set) {
      $sub_total += $set['Price'];
      printf("%3d %-30s%.2f", $set['Quantity'], $set['Description'], $set['Price']);
      foreach ($set['Set Items'] as $si) {
        printf("\n    %-30s0.00", $si);
      }
    }
    foreach($items as $item) {
      $sub_total += $item['Item Price'];
      printf("\n");
      printf("%3d %-30s%.2f", $item['Quantity'], $item['Item Name'], $item['Item Price']);
      if($item['Mod ID'] != null) {
        $sub_total += $item['Mod Price'];
        printf("\n    %-30s%.2f", $item['Modifier'], $item['Mod Price']);
      }
    }
    printf("\n----------------------------------------\n");
    printf("%-33s%.2f", 'Sub Total' , $sub_total);
    if($this->discount != 0) {
      printf("\n%-33s%5d", 'Discount %' , $this->discount);
      printf("\n%-33s%.2f", 'Grand Total', $sub_total * (100 - $this->discount) / 100);
    } else {
      printf("\n%-33s%.2f", 'Grand Total', $sub_total);
    }

    // print_r($this->invoice_detail);
  }

}

 ?>
