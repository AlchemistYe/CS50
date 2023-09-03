from cs50 import SQL
import csv

db = SQL("sqlite:///favorites.db")

title = input("Title: ").strip()
rows = db.execute("SELECT COUNT(*) AS counter FROM favorites WHERE title LIKE ?", title)
print(rows[0])