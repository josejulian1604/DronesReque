from flask import Flask, render_template, request, redirect, url_for
from database import establecer_conexion
import pyodbc


app = Flask(__name__)

conn = establecer_conexion()

if conn is None:
    print("No se pudo establecer la conexión. La aplicación no se iniciará.")
else:
    print("La conexión se ha establecido correctamente.")

CEDULA = None

@app.route('/')
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['correo']
        password = request.form['password']
        cursor = conn.cursor()
        cursor.execute('EXEC ValidarUsuario ?, ?', (email, password))
        login = cursor.fetchone()[0]
        conn.commit()
        cursor.close()
        if(login == -1):
            pass # Error de login, no se encontro mail o correo
        elif(login == 1):
            return redirect('/administrador')
        elif(login == 2):
            return redirect('/tecnico')
        elif(login == 3):
            return redirect('/analista')

    return render_template('login.html')

@app.route('/registro', methods=['GET', 'POST'])
def registro():
    if request.method == 'POST':
        password = request.form['password']
        role = request.form['role']
        correo = request.form['correo']
        nombre = request.form['nombre']
        apellido = request.form['apellido']
    
        cursor = conn.cursor()
        cursor.execute('EXEC RegistrarUsuario ?, ?, ?, ?, ?', (nombre, apellido, correo, password, role))
        resultado = cursor.fetchone()[0]
        conn.commit()
        cursor.close()

    return render_template('registro.html')

@app.route('/administrador', methods=['GET', 'POST'])
def administrador():
    mensaje = "Bienvenido Administrador"
    if request.method == 'POST':
        opcion = request.form['opcion']
        if opcion == 'registrar_cliente':
            return redirect('/administrador/registrar_cliente')
        elif opcion == 'buscar_cliente':
            return redirect('/administrador/buscar_cliente')
        elif opcion == 'buscar_servicio':
            return redirect('/administrador/buscar_servicio')
        elif opcion == 'salir':
            return redirect('/login')
    
    return render_template('administrador.html', mensaje=mensaje)

@app.route('/administrador/registrar_cliente', methods=['GET', 'POST'])
def registrar_cliente():
    if request.method == 'POST':
        cedula = request.form['cedula']
        nombre = request.form['nombre']
        apellido = request.form['apellido']
        telefono = request.form['telefono']
        correo = request.form['correo']
        direccion = request.form['direccion']

        cursor = conn.cursor()
        cursor.execute('EXEC CrearCliente ?, ?, ?, ?, ?, ?', (nombre, apellido, cedula, correo, direccion, telefono))
        conn.commit()
        cursor.close()

        return redirect('/administrador')

    return render_template('registrar_cliente.html')


@app.route('/administrador/buscar_cliente', methods=['GET', 'POST'])
def buscar_cliente():
    if request.method == 'POST':
        cedula = request.form['cedula']

        cursor = conn.cursor() 
        cursor.execute('EXEC BuscarCliente ?', (cedula,))
        infoCliente = cursor.fetchall()
        conn.commit()
        cursor.close()

        # Redirigir a la ruta de información del cliente y pasar la información como argumentos de consulta
        return redirect(url_for('informacion_cliente', nombre=infoCliente[0][0], apellido=infoCliente[0][1], cedula=infoCliente[0][2], 
                                correo=infoCliente[0][3], direccion=infoCliente[0][4], telefono=infoCliente[0][5]))

    return render_template('buscar_cliente.html')

@app.route('/administrador/informacion_cliente', methods=['GET'])
def informacion_cliente():
    # Obtener la información del cliente de los argumentos de consulta
    nombre = request.args.get('nombre')
    apellido = request.args.get('apellido')
    cedula = request.args.get('cedula')
    correo = request.args.get('correo')
    direccion = request.args.get('direccion')
    telefono = request.args.get('telefono')

    # Renderizar la plantilla con la información del cliente
    return render_template('informacion_cliente.html', nombre=nombre, apellido=apellido, cedula=cedula, 
                           correo=correo, direccion=direccion, telefono=telefono)

@app.route('/administrador/buscar_servicio', methods=['GET', 'POST'])
def buscar_servicio():
    if request.method =='POST':
        cedula = request.form['cedula']

        cursor = conn.cursor()
        cursor.execute('EXEC BuscarServicio ?', (cedula))
        servicios = cursor.fetchall()
        conn.commit()
        cursor.close()

        # Redirigir a la ruta de información del cliente y pasar la información como argumentos de consulta
        return render_template('servicios_cliente.html', servicios=servicios)

    return render_template('buscar_servicio.html')


@app.route('/tecnico', methods=['GET', 'POST'])
def tecnico():
    if request.method == 'POST':
        global CEDULA
        cedula = request.form['cedula']
        CEDULA = cedula

        cursor = conn.cursor()
        cursor.execute('EXEC BuscarCliente ?', (cedula))
        conn.commit()
        cursor.close()

        return redirect(url_for('crear_servicio'))
    
    return render_template('tecnico.html')

@app.route('/tecnico/crear_servicio', methods=['GET', 'POST'])
def crear_servicio():
    if request.method == 'POST':
        global CEDULA
        tipoServicio = request.form['tipoServicio']
        area = request.form['area']
        costo = request.form['costo']
        cultivo = request.form['cultivo']
        descripcion = request.form['descripcion']
        dron = request.form['dron']
        estado = request.form['estado']
        fechaIni = request.form['fechaIni']
        fechaFin = request.form['fechaFin']
        print(CEDULA, tipoServicio, area, costo, cultivo, descripcion, dron, estado, fechaIni, fechaFin)

        cursor = conn.cursor()
        cursor.execute('EXEC CrearServicio ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?', (descripcion, costo, cultivo, fechaIni, fechaIni, 
                                                                           fechaFin, estado, area, CEDULA, dron, tipoServicio) )
        conn.commit()
        cursor.close()
        
        return redirect('/tecnico/crear_servicio')


    return render_template('crear_servicio.html')



@app.route('/analista', methods=['GET', 'POST'])
def analista():
    
    if request.method == 'POST':
        cedula = request.form['cedula']

        cursor = conn.cursor()
        cursor.execute('EXEC BuscarServicio ?', (cedula))
        servicios = cursor.fetchall()
        conn.commit()
        cursor.close()
        
        return render_template('servicios_cliente.html', servicios=servicios) #Crear página de éxito

    return render_template('analista.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)