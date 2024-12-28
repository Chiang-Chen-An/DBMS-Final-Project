from flask import Flask, render_template, request, redirect, flash, session, jsonify
import mysql.connector
import hashlib
import pandas as pd

app = Flask(__name__)
app.secret_key = "your_secret_key"

db_config = {
    'host': 'localhost',  # Change this to your MySQL host
    'user': 'root',  # Change this to your MySQL username
    'password': '792b3967',  # Change this to your MySQL password
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
    db_connection = get_db_connection()
    cursor = db_connection.cursor(dictionary = True)

    cursor.execute('SELECT username, text, created_at FROM comments ORDER BY created_at DESC LIMIT 5')
    comments = cursor.fetchall()

    cursor.close()
    db_connection.close()

    return render_template('homepage.html', comments = comments)

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

    cursor.execute('SELECT race_id, circuit_name, wiki_url FROM races WHERE year_of_race = %s', (year,))
    races = cursor.fetchall()

    cursor.close()
    db_connection.close()

    return jsonify(races)

@app.route('/driver/<int:constructor_id>', methods=['GET'])
def getDriver(constructor_id):
    db_connection = get_db_connection()
    cursor = db_connection.cursor(dictionary=True)

    cursor.execute('SELECT driver_id FROM qualifying WHERE constructor_id = %s;', (constructor_id,))
    driver_ids = cursor.fetchall()
    driver_id_list = [driver['driver_id'] for driver in driver_ids]
    cursor.execute('''
        SELECT driver_id, f_name, l_name, date_of_birth, nationality, wiki_url
        FROM drivers 
        WHERE driver_id IN (%s);
    ''' % ','.join(['%s'] * len(driver_id_list)), tuple(driver_id_list))
    drivers = cursor.fetchall()

    if drivers is None:
        print("No drivers found")
    else:
        print(drivers)
        print(constructor_id)
    cursor.close()
    db_connection.close()

    return jsonify(drivers)

@app.route('/insertDriver', methods=['GET', 'POST'])
def insertDriver():
    if request.method == 'POST':
        db_connection = get_db_connection()
        cursor = db_connection.cursor()

        # 檢查是否已登入
        if 'user' not in session:
            flash('You must be logged in to insert a driver', 'error')
            cursor.close()
            db_connection.close()
            return redirect('/insertDriver')

        # 從請求中獲取車手資料
        f_name = request.form.get('f_name')
        l_name = request.form.get('l_name')
        date_of_birth = request.form.get('date_of_birth')
        nationality = request.form.get('nationality')
        wiki_url = request.form.get('wiki_url')

        # 檢查必要的資料是否存在
        if not all([f_name, l_name, date_of_birth, nationality, wiki_url]):
            flash('All fields are required', 'error')
            cursor.close()
            db_connection.close()
            return redirect('/insertDriver')

        # 連接資料庫並插入新車手資料
        try:
            cursor.execute('''
                INSERT INTO drivers (f_name, l_name, date_of_birth, nationality, wiki_url)
                VALUES (%s, %s, %s, %s, %s)
            ''', (f_name, l_name, date_of_birth, nationality, wiki_url))
            db_connection.commit()
        except Exception as e:
            db_connection.rollback()
            flash(f'Error: {str(e)}', 'error')
            cursor.close()
            db_connection.close()
            return redirect('/insertDriver')

        cursor.close()
        db_connection.close()

        flash('Driver inserted successfully', 'success')
        return redirect('/insertDriver')

    # GET request: render the homepage
    return render_template('homepage.html')

@app.route('/insertResult', methods=['GET', 'POST'])
def insertResult():
    if request.method == 'POST':
        db_connection = get_db_connection()
        cursor = db_connection.cursor()

        # 檢查是否已登入
        if 'user' not in session:
            flash('You must be logged in to insert a result', 'error')
            cursor.close()
            db_connection.close()
            return redirect('/insertResult')

        # 從請求中獲取結果資料
        driver_id = request.form.get('driver_id')
        constructor_id = request.form.get('constructor_id')
        car_num = request.form.get('car_num')
        position_grid = request.form.get('position_grid')
        position = request.form.get('position')
        position_text = request.form.get('position_text')
        position_order = request.form.get('position_order')
        points = request.form.get('points')
        laps = request.form.get('laps')
        time = request.form.get('time')
        time_in_milliseconds = request.form.get('time_in_milliseconds')
        fastest_lap = request.form.get('fastest_lap')
        rank_of_fastest_lap = request.form.get('rank_of_fastest_lap')
        fastest_lap_time = request.form.get('fastest_lap_time')
        fastest_lap_speed = request.form.get('fastest_lap_speed')
        status_id = request.form.get('status_id')

        # 檢查必要的資料是否存在
        if not all([driver_id, constructor_id, car_num, position_grid, position, position_text, position_order, points, laps, time, time_in_milliseconds, fastest_lap, rank_of_fastest_lap, fastest_lap_time, fastest_lap_speed, status_id]):
            flash('All fields are required', 'error')
            cursor.close()
            db_connection.close()
            return redirect('/insertResult')

        # 連接資料庫並插入新結果資料
        try:
            cursor.execute('''
                INSERT INTO results (driver_id, constructor_id, car_num, position_grid, position, position_text, position_order, points, laps, `time`, time_in_milliseconds, fastest_lap, rank_of_fastest_lap, fastest_lap_time, fastest_lap_speed, status_id)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            ''', (driver_id, constructor_id, car_num, position_grid, position, position_text, position_order, points, laps, time, time_in_milliseconds, fastest_lap, rank_of_fastest_lap, fastest_lap_time, fastest_lap_speed, status_id))
            db_connection.commit()
        except Exception as e:
            db_connection.rollback()
            flash(f'Error: {str(e)}', 'error')
            cursor.close()
            db_connection.close()
            return redirect('/insertResult')

        cursor.close()
        db_connection.close()

        flash('Result inserted successfully', 'success')
        return redirect('/insertResult')

    # GET request: render the homepage
    return render_template('homepage.html')

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

@app.route('/searchDriver', methods=['GET'])
def searchDriver():
    # Get the query parameters
    f_name = request.args.get('f_name', '').strip().lower()
    l_name = request.args.get('l_name', '').strip().lower()
    date_of_birth = request.args.get('date_of_birth', '').strip()
    nationality = request.args.get('nationality', '').strip().lower()

    db_connection = get_db_connection()
    cursor = db_connection.cursor(dictionary=True)

    try:
        # Build the dynamic query
        query = """
            SELECT driver_id, f_name, l_name, date_of_birth, nationality, wiki_url
            FROM drivers
            WHERE TRUE
        """
        params = []

        # Add conditions based on the parameters provided
        if f_name:
            query += " AND LOWER(f_name) LIKE %s"
            params.append(f"%{f_name}%")
        if l_name:
            query += " AND LOWER(l_name) LIKE %s"
            params.append(f"%{l_name}%")
        if date_of_birth:
            query += " AND date_of_birth = %s"
            params.append(date_of_birth)
        if nationality:
            query += " AND LOWER(nationality) LIKE %s"
            params.append(f"%{nationality}%")

        # Execute the query
        cursor.execute(query, tuple(params))
        drivers = cursor.fetchall()

        return jsonify(drivers)
    except Exception as e:
        return jsonify({"error": str(e)}), 500
    finally:
        cursor.close()
        db_connection.close()

@app.route('/deleteDriver/<int:driver_id>', methods=['POST'])
def deleteDriver(driver_id):
    db_connection = get_db_connection()
    cursor = db_connection.cursor()

    try:
        # Check if the driver exists
        cursor.execute('SELECT * FROM drivers WHERE driver_id = %s', (driver_id,))
        driver = cursor.fetchone()

        if driver:
            # Delete the driver if they exist
            cursor.execute('DELETE FROM drivers WHERE driver_id = %s', (driver_id,))
            db_connection.commit()
            return jsonify({"success": True, "message": "Driver deleted successfully"})
        else:
            return jsonify({"success": False, "message": "Driver not found"}), 404
    except Exception as e:
        db_connection.rollback()
        return jsonify({"success": False, "message": str(e)}), 500
    finally:
        cursor.close()
        db_connection.close()

@app.route('/ranking', methods=['GET'])
def get_ranking():
    db_connection = get_db_connection()
    cursor = db_connection.cursor(dictionary=True)

    cursor.execute('SELECT driver_name, points FROM rankings ORDER BY points DESC')
    rankings = cursor.fetchall()

    cursor.close()
    db_connection.close()

    return jsonify(rankings)

@app.route('/add_comment', methods=['POST'])
def add_comment():
    if 'user' not in session:
        flash('你需要登錄帳號才能留言', 'danger')
        return redirect('/login')

    comment_text = request.form['comment']
    username = session['user']['username']

    db_connection = get_db_connection()
    cursor = db_connection.cursor()

    cursor.execute("INSERT INTO comments (username, text) VALUES (%s, %s)", (username, comment_text))
    db_connection.commit()

    cursor.close()
    db_connection.close()

    flash('成功送出', 'success')
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True)