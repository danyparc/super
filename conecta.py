#!/usr/bin/env python
# -*- coding: utf-8 -*-
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

#INTRO
print "Este script ejecuta ciertas acciones en una db"

op=0
while op!=6:
    print "\nMENU"
    print "1.- Insertar datos"
    print "2.- Consultar"
    print "3.- Consulta especifica"
    print "4.- Eliminar registros"
    print "5.- Update"
    print "6.- Salir"
    op=int(raw_input("Seleccione una opcion: "))

    #Insertar datos
    if op==1:
        print "Formato: \n id (varchar) | nombre (varchar) | precio (double) | marca (varchar)  "
        dato = raw_input("VALUES: ")
        query = "INSERT INTO producto VALUES (%s)" % dato
        run_query(query)
    #Consultar datos
    elif op==2:
        query = "SELECT * FROM producto ORDER BY id ASC"
        #select COLUMN_NAME from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME='producto'
        result = run_query(query) 
        for lista in result:
            for tupla in lista:
                print tupla
    #Consulta con condiciones
    elif op==3:
        criterio = raw_input("Ingrese marca: ") 
        query = "SELECT * FROM producto WHERE marca = '%s'" % criterio 
        result = run_query(query)
        print result
    #Eliminar registros
    elif op==4:
        criterio = raw_input("Ingrese id a eliminar: ") 
        query = "DELETE FROM producto WHERE id = '%s'" % criterio 
        run_query(query)
    #Actualizar datos
    elif op==5:
        b1 = raw_input("ID: ") 
        b2 = raw_input("Nuevo precio: ") 
        query = "UPDATE producto SET precio='%s' WHERE id = %i" % (b2, int(b1)) 
        run_query(query)
