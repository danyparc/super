#!/usr/bin/env python
# -*- coding: utf-8 -*-
from flask import Flask, render_template, request, redirect, url_for
import MySQLdb

DB_HOST = 'localhost'
DB_USER = 'root'
DB_PASS = 'perritosalvaje'
DB_NAME = 'pydata'

def run_query(query=''):
    datos = [DB_HOST, DB_USER, DB_PASS, DB_NAME]

    conn = MySQLdb.connect(*datos) # Conectar a la base de datos
    cursor = conn.cursor()         # Crear un cursor
    cursor.execute(query)          # Ejecutar una consulta

    if query.upper().startswith('SELECT'):
        data = cursor.fetchall()   # Traer los resultados de un select
    else:
        conn.commit()              # Hacer efectiva la escritura de datos
        data = None

    cursor.close()                 # Cerrar el cursor
    conn.close()                   # Cerrar la conexión

    return data

app=Flask(__name__)
app.debug=True

@app.route('/')
def consulta():
	query="SELECT * FROM producto ORDER BY id ASC"
	#select COLUMN_NAME from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='producto'
	result=run_query(query)
	#result queda como una lista de tuplas
	return render_template('productos.html', result=result )

@app.route('/posti', methods=["GET","POST"])
def postear():
	if request.method == "GET":
		return render_template('postear.html')
	elif request.method == "POST":
		aidi = request.form['id']
		nombre = request.form['nombre']
		precio = float(request.form['precio'])
		marca = request.form['marca']
		dato = "'%s', '%s', %f, '%s' " % (aidi, nombre, precio, marca)
		query = "INSERT INTO producto VALUES (%s)" %dato
		run_query(query)
		#return render_template('newproduct.html',dato=dato)
		return consulta()

if __name__ == '__main__':
	app.run(host='0.0.0.0')
