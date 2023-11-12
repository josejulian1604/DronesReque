from flask import Flask, render_template, request, redirect
#from .database import conn 

#import Prototipo.database

app = Flask(__name__)

@app.route('/')
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        cursor = conn.cursor()
        cursor.execute('EXEC ValidarUsuario ?, ?', (email, password))
        login = cursor.fetchone()[0]
        conn.commit()
        cursor.close() 
        if(login == 0):
            return redirect('/administrador')
        elif(login == 1):
            return redirect('/tecnico')
        elif(login == 2):
            return redirect('/analista')

    return render_template('login.html')

@app.route('/registro', methods=['GET', 'POST'])
def registro():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']
        role = request.form['role']
        correo = request.form['correo']
        nombre = request.form['nombre']
        appellido = request.form['apellido']
        cursor = conn.cursor()
        cursor.execute('EXEC RegistrarUsuario ?, ?, ?', (email, password, role))
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
        cursor.execute('EXEC BuscarCliente ?', (cedula))
        conn.commit()
        cursor.close()

        return redirect('/administrador/exito') #Crear página de éxito

    return render_template('buscar_cliente.html')

@app.route('/administrador/buscar_servicio', methods=['GET', 'POST'])
def buscar_servicio():
    if request.method =='POST':
        cedula = request.form['cedula']

        cursor = conn.cursor()
        cursor.execute('EXEC BuscarServicio ?', (cedula))
        resultado = cursor.fetchone()
        conn.commit()
        cursor.close()

        return redirect('/administrador/exito') #Crear página de éxito

    return render_template('buscar_servicio.html')


@app.route('/tecnico', methods=['GET', 'POST'])
def tecnico():
    if request.method == 'POST':
        cedula = request.form['cedula']

        cursor = conn.cursor()
        cursor.execute('EXEC BuscarCliente ?', (cedula))
        conn.commit()
        cursor.close()

        return redirect('/tecnico/crear_servicio')
    
    return render_template('tecnico.html')

@app.route('/tecnico/crear_servicio', methods=['GET', 'POST'])
def consultar_servicio():
    if request.method == 'POST':
        nombreServicio = request.form['nombreServicio']
        tipoServicio = request.form['tipoServicio']
        area = request.form['area']
        costo = request.form['costo']
        cultivo = request.form['cultivo']
        descripcion = request.form['descripcion']
        dron = request.form['dron']
        estado = request.form['estado']
        fechaIni = request.form['fechaIni']
        fechaFin = request.form['fechaFin']

        cursor = conn.cursor()
        cursor.execute('EXEC CrearServicio ?, ?, ?, ?, ?, ?, ?, ?, ?, ?', (descripcion, costo, cultivo, fechaIni, fechaIni, fechaFin, estado, area, "cliente", dron, tipoServicio) ))
        conn.commit()
        cursor.close()
        
        return redirect('/tecnico')


    return render_template('consultar_servicio.html')

@app.route('/analista', methods=['GET', 'POST'])
def analista():
    
    if request.method == 'POST':
        cedula = request.form['cedula']

        cursor = conn.cursor()
        cursor.execute('EXEC BuscarServicio ?', (cedula))
        conn.commit()
        cursor.close()
        
        return redirect('/analista/exito') #Crear página de éxito

    return render_template('analista.html')

@app.route('/analista/consultar_servicio', methods=['GET', 'POST'])
def actualizar_servicio():
        

    return render_template('consultar_servicio.html')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)