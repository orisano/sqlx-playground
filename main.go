package main

import (
	"fmt"
	"log"

	"github.com/jmoiron/sqlx"
	"github.com/xo/dburl"
	"golang.org/x/xerrors"

	_ "github.com/go-sql-driver/mysql"
)

type Item struct {
	ID         int    `db:"id"`
	A          string `db:"a"`
	B          string `db:"b"`
	CategoryID int    `db:"category_id"`
}

type Category struct {
	ID int    `db:"id"`
	A  string `db:"a"`
	C  string `db:"c"`
}

func main() {
	log.SetPrefix("sqlx-playground: ")
	log.SetFlags(0)
	if err := run(); err != nil {
		log.Fatal(err)
	}
}

func run() error {
	db, err := dburl.Open("mysql://sqlx:playground@localhost/dbname")
	if err != nil {
		return xerrors.Errorf("open db: %w", err)
	}
	dbx := sqlx.NewDb(db, "mysql")

	// Setup data
	_, _ = dbx.Exec(`INSERT INTO category(id, a, c) VALUES (1, 'foo1', 'bar1'), (2, 'foo2', 'bar2'), (3, 'foo3', 'bar3')`)
	_, _ = dbx.Exec(`INSERT INTO item(id, a, b, category_id) VALUES (1, 'baz1', 'foobar1', 1), (2, 'baz2', 'foobar2', 2), (3, 'baz3', 'foobar3', 3)`)

	var joinedItems []struct {
		Item
		Category Category `db:"c"`
	}
	err = dbx.Select(&joinedItems, "SELECT i.*, c.id `c.id`, c.a `c.a`, c.c `c.c` FROM item i JOIN category c ON i.category_id = c.id ORDER BY i.id")
	if err != nil {
		return xerrors.Errorf("select joined items: %w", err)
	}

	for _, item := range joinedItems {
		fmt.Printf("%+v\n", item)
	}

	return nil
}
