package main

import (
	"fmt"

	_ "github.com/godror/godror"
	"github.com/jmoiron/sqlx"
)

func main() {

	fmt.Println("TESTE")

	dbx, err := sqlx.Connect("godror", `user="scott" password="tiger" connectString="dbhost:1521/orclpdb1"`)
	if err != nil {
		panic(err)
	}
	_ = dbx



}
