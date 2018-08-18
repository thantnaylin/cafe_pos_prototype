<?php

class Database {

  public $con;

  private $host = "localhost";
  private $db_name = "librasun_cafe";
  private $username = "root";
  private $password = "";

  public function getConnection() {

    $this->con = null;

    try {

      $this->con = new PDO("mysql:host=" . $this->host . ";dbname=" . $this->db_name, $this->username, $this->password);

      $this->con->exec("set names utf8");
      $this->con->setAttribute(PDO::ATTR_DEFAULT_FETCH_MODE, PDO::FETCH_ASSOC);
    } catch (PDOException $e) {

      echo "Connection Error.";
    }

    return $this->con;
  }

}

 ?>
