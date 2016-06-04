#!/usr/bin/env python
# -*- coding: utf-8 -*-
from flask import Flask, render_template, request, redirect, url_for
import MySQLdb

DB_HOST = 'localhost'
DB_USER = 'root'
DB_PASS = 'perritosalvaje'
DB_NAME = 'mydb'

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
	query="SELECT * FROM articulo ORDER BY idArticulo ASC"
	#select COLUMN_NAME from NIFORMATION_SCHEMA.COLUMNS where TABLE_NAME='producto'
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
		depto = request.form['depto']
		dato = "'%s', '%s', %f, '%s' " % (aidi, nombre, precio, depto)
		query = "INSERT INTO articulo VALUES (%s)" %dato
		run_query(query)
		return consulta()

@app.route('/caja', methods=["GET","POST"])
def identificar(r=[],ids=[],cant=[], total=0.0):
	#busca un articulo por su id
	if request.method == "GET":
		return render_template('caja.html')
	elif request.method == "POST":
		codigo = request.form['id']
		ids.append(codigo)
		cantidad = request.form['cantidad']
		cant.append(cantidad)
		query = "SELECT * FROM articulo WHERE idArticulo = '%s'" % codigo 
		result = run_query(query)
		result = list(result[0])
		precio = result[2] * float(cantidad)
		total = total + precio
		result.append(cantidad)
		result.append(total)
		r.append(result)
		total=0
		for x in r:
			total = total + x[5]
		
		return render_template('caja.html', result=r, cantidad=cant, total = total)

def cambio(total,pago):
	cambio=
		


if __name__ == '__main__':
	app.run(host='0.0.0.0')
