from flask import Flask, render_template, request, redirect

app = Flask(__name__)

@app.route('/')
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        # Realiza las operaciones para actualizar el servicio con la email ingresada.
        # Esto podría incluir consultas a la base de datos y otros procesos específicos.

        # Después de actualizar el servicio, puedes redirigir a la página de éxito o a otra página.

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

    return render_template('registro.html')

@app.route('/administrador', methods=['GET', 'POST'])
def administrador():
    mensaje = "Bienvenido Administrador"
    if request.method == 'POST':
        opcion = request.form['opcion']
        if opcion == 'registrar_cliente':
            return redirect('/administrador/registrar_cliente')
        elif opcion == 'crear_servicio':
            return redirect('/administrador/crear_servicio')
        elif opcion == 'buscar_cliente':
            return redirect('/administrador/buscar_cliente')
        elif opcion == 'buscar_servicio':
            return redirect('/administrador/buscar_servicio')
        elif opcion == 'salir':
            return redirect('/login')
    
    return render_template('administrador.html', mensaje=mensaje)

@app.route('/administrador/registrar_cliente', methods=['GET', 'POST'])
def registrar_cliente():
    mensaje = "¡Página de registrar cliente!"

    return render_template('registrar_cliente.html', mensaje=mensaje)

@app.route('/administrador/crear_servicio', methods=['GET', 'POST'])
def crear_servicio():
    mensaje = "¡Página de crear servicio!"

    return render_template('crear_servicio.html', mensaje=mensaje)

@app.route('/administrador/buscar_cliente', methods=['GET', 'POST'])
def buscar_cliente():
    mensaje = "¡Página de buscar cliente!"

    return render_template('buscar_cliente.html', mensaje=mensaje)

@app.route('/administrador/buscar_servicio', methods=['GET', 'POST'])
def buscar_servicio():
    mensaje = "¡Página de buscar servicio!"

    return render_template('buscar_servicio.html', mensaje=mensaje)


@app.route('/tecnico', methods=['GET', 'POST'])
def tecnico():
    mensaje = "¡Página de técnico!"
    if request.method == 'POST':
        cedula = request.form['cedula']
        return redirect('/tecnico/consultar_servicio')
    return render_template('tecnico.html', mensaje=mensaje)

@app.route('/tecnico/consultar_servicio', methods=['GET', 'POST'])
def consultar_servicio():
    mensaje = "¡Página de consultar servicio!"

    return render_template('consultar_servicio.html', mensaje=mensaje)

@app.route('/analista', methods=['GET', 'POST'])
def analista():
    mensaje = "Bienvenido Analista"
    
    if request.method == 'POST':
        cedula = request.form['cedula']
        # Realiza las operaciones para actualizar el servicio con la cédula ingresada.
        # Esto podría incluir consultas a la base de datos y otros procesos específicos.

        # Después de actualizar el servicio, puedes redirigir a la página de éxito o a otra página.
        return redirect('/analista/exito')

    return render_template('analista.html', mensaje=mensaje)

@app.route('/analista/consultar_servicio', methods=['GET', 'POST'])
def actualizar_servicio():
    mensaje = "¡Página de actualizar servicio!"

    return render_template('consultar_servicio.html', mensaje=mensaje)

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)