
'''import pyodbc

def establecer_conexion():
    server = 'DESKTOP-LHKIQDK'
    database = 'DronesReque'
    username = 'sa'
    password = 'CowardlySpice16'

    try:
        # Create a connection to the database
        conn = pyodbc.connect('DRIVER={SQL Server};SERVER='+server+';DATABASE='+database+';UID='+username+';PWD='+ password)
        return conn
    except pyodbc.Error as ex:
        print("Error en la conexión:", ex)
        return None'''