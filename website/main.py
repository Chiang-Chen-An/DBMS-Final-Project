from flask import Flask, render_template, request, redirect, flash, session, jsonify
import mysql.connector
import hashlib

app = Flask(__name__)
app.secret_key = "your_secret_key"

db_config = {
    'host': 'localhost',  # Change this to your MySQL host
    'user': 'root',  # Change this to your MySQL username
    'password': '03020302',  # Change this to your MySQL password
    'database': 'dbms_final'  # Change this to your MySQL database name
}

def get_db_connection():
    return mysql.connector.connect(**db_config)

def hash_password(password):
    sha256_hash = hashlib.sha256()
    sha256_hash.update(password.encode('utf-8'))
    return sha256_hash.hexdigest()

@app.route('/', methods=['GET', 'POST'])
def homepage():
    return render_template('homepage.html')

@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        db_connection = get_db_connection()
        cursor = db_connection.cursor(dictionary=True)

        cursor.execute('SELECT * FROM users WHERE username = %s AND password = %s', (username, hash_password(password)))
        user = cursor.fetchone()

        cursor.close()
        db_connection.close()

        # print(user)
        if user:
            session['user'] = user
            return redirect("/")
        else:
            flash('Invalid username or password', "danger")
            return redirect("/login")

    return render_template('login.html')

@app.route('/logout', methods=['GET'])
def logout():
    session.pop('user', None)
    return redirect('/')

@app.route('/register', methods=['GET', 'POST'])
def register():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']

        db_connection = get_db_connection()
        cursor = db_connection.cursor()

        if username != '' and password != '':
            # print("username: ", username)
            # print("password: ", password)
            try:
                cursor.execute("INSERT INTO users (username, password) VALUES (%s, %s)", (username, hash_password(password)))
                db_connection.commit()
                flash("Account created successfully! Please log in.", "success")
                return redirect("/register")
            except mysql.connector.Error as err:
                flash(f"Error: {err}", "danger")
            finally:
                cursor.close()
                db_connection.close()

            flash('Account created successfully', 'success')
            return redirect('/register')
        else:
            flash('please enter a valid username and password', "danger")

    return render_template('register.html')

@app.route('/race/<int:year>', methods=['GET'])
def getRace(year):
    db_connection = get_db_connection()
    cursor = db_connection.cursor(dictionary=True)

    cursor.execute('SELECT race_id, circuit_name FROM races WHERE year_of_race = %s', (year,))
    races = cursor.fetchall()

    cursor.close()
    db_connection.close()

    return jsonify(races)

@app.route('/driver/<int:constructor_id>', methods=['GET'])
def getDriver(constructor_id):
    db_connection = get_db_connection()
    cursor = db_connection.cursor(dictionary=True)

    cursor.execute('SELECT driver_id, f_name, l_name, date_of_birth, nationality FROM drivers d JOIN constructorAndDriver cd ON cd.driverID = d.driver_id WHERE cd.constructorID = %s;', (constructor_id,))
    drivers = cursor.fetchall()

    if drivers is None:
        print("No drivers found")
    else:
        print(drivers)
        print(constructor_id)
    cursor.close()
    db_connection.close()

    return jsonify(drivers)

@app.route('/insertUser', methods=['GET', 'POST'])
def insertUser():
    if request.method == 'POST':
        db_connection = get_db_connection()
        cursor = db_connection.cursor()
        # 登入才能新增
        if 'user' not in session:
            flash('You must be logged in to insert a user', 'error')
            cursor.close()
            db_connection.close()
            return redirect('/insertUser')
        if request.form['username'] == '' or request.form['password'] == '':
            flash('Username and password cannot be empty', 'error')
            cursor.close()
            db_connection.close()
            return redirect('/insertUser')

        username = request.form['username']
        password = request.form['password']

        cursor.execute('INSERT INTO users (username, password) VALUES (%s, %s)', (username, hash_password(password)))
        db_connection.commit()

        cursor.close()
        db_connection.close()

        flash('User inserted successfully', 'success')
        return redirect('/insertUser')

    # GET request: render the homepage
    return render_template('homepage.html')

if __name__ == '__main__':
    app.run(debug=True)