#!/usr/bin/env python
# -*- coding: utf-8 -*-
from flask import Flask, render_template, request, redirect, url_for
import datetime
import MySQLdb


#Configuracion DB
DB_HOST = 'localhost'
DB_USER = 'root'
DB_PASS = 'perritosalvaje'
DB_NAME = 'carnalmart'

def run_query(query=''):
    datos = [DB_HOST, DB_USER, DB_PASS, DB_NAME,]

    conn = MySQLdb.connect(*datos, charset='utf8', use_unicode=True) # Conectar a la base de datos
    cursor = conn.cursor()         # Crear un cursor
    cursor.execute(query)          # Ejecutar una consulta

    if query.upper().startswith('SELECT') or query.upper().startswith('CALL'):
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
def log():
	return render_template('index.html')


@app.route('/admin')
def admin():
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

def ticket(total, pago, articulos, metodo):
	#Creamos el ticket en laDB
	hoy = datetime.datetime.now()
	fecha = str(hoy.day)+"/"+str(hoy.month)+"/"+str(hoy.year)
	hora = str(hoy.hour)+":"+str(hoy.minute)
	impuesto = total * 0.16
	cambio = pago - total
	sucursal = 1003
	valores = "NULL,'%s', '%s', %f, %f, %f, '%s'" % (fecha, hora, impuesto, total, cambio, sucursal)
	query = "INSERT INTO ticket VALUES(%s)" % valores
	run_query(query)
	#Obtenemos el id del ticket creado
	query = "SELECT MAX(idTicket) FROM ticket"
	idTicket = run_query(query)
	idTicket = int(idTicket[0][0])
	#Subimos los articulos a la tabla 'articuloticket'
	#articulos es una lista de tuplas
	for artupla in articulos:
		idArticulo = int(artupla[0])
		cantidad = int(artupla[4])
		subtotal = float(artupla[5])
		valores = "%d, %d, %d, %f" % (idArticulo, idTicket, cantidad, subtotal)
		query = "INSERT INTO articuloticket VALUES(%s)" % valores
		run_query(query)
	#Registramos el metodo con el que se pago
	valores = "%d, %d" % (idTicket, metodo)
	query = "INSERT INTO ticketmetodo VALUES(%s)" % valores
	run_query(query)
	#Se mandan los datos a imprimir
	return render_template('ticket.html', idTicket=idTicket, fecha=fecha, 
		   hora=hora, impuesto=impuesto, total=total, pago=pago, metodo=metodo,
		   cambio=cambio, articulos=articulos)
	
"""@app.route('/imprimeTicket')
def imprimeTicket():
	return render_template('ticket.html', idTicket=idTicket, fecha=fecha, 
		   hora=hora, impuesto=impuesto, total=total, pago=pago, metodo=metodo,
		   cambio=cambio, articulos=articulos)"""

total=0.0

@app.route('/caja', methods=["GET","POST"])
def caja(r=[],ids=[],cant=[]):
	#busca un articulo por su id
	global total
	subtotal = 0.0
	if request.method == "GET":
		return render_template('caja.html')

	elif request.method == "POST":

		if request.form['subida'] == "Agregar":
			codigo = request.form['id']
			ids.append(codigo)
			cantidad = request.form['cantidad']
			cant.append(cantidad)
			query = "SELECT * FROM articulo WHERE idArticulo = '%s'" % codigo 
			result = run_query(query)
			result = list(result[0])
			precio = result[2] * float(cantidad)
			subtotal = subtotal + precio
			result.append(cantidad)
			result.append(subtotal)
			r.append(result)
			total=0
			for x in r:
				total = total + x[5]	
			return render_template('caja.html', result=r, cantidad=cant, total = total)

		if request.form['subida'] == 'Cobrar':
			pago=float(request.form['pago'])
			metodo = int(request.form['metodo'])
			return ticket(total,pago,r,metodo)

if __name__ == '__main__':
	app.run(host='0.0.0.0')
