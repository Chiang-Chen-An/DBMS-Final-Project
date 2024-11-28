from flask import Flask, render_template, request, redirect, flash, session
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

@app.route("/", methods=["GET", "POST"])
def login():
    if request.method == "POST":
        username = request.form['username']
        password = request.form['password']

        # TODO # 4: Hash the password using SHA-256
        # password = ???
        hashed_password = hash_password(password)

        # Connect to the database
        conn = get_db_connection()
        cursor = conn.cursor()

        # TODO # 2. Check if the user exists in the database and whether the password is correct
        # Query to check the user
        # cursor.execute(f"SELECT password FROM users WHERE username = '{username}'")
        cursor.execute("SELECT password FROM users WHERE username = %s", (username,))
        result = cursor.fetchone() # fetchone() returns None if no record is found
        # print(result)

        # if ???:
        if result and result[0] == hashed_password:
            session['username'] = username
            return redirect("/homepage")
        else:
            flash("Invalid username or password")
            return redirect("/")

        
        # Close the connection
        cursor.close()
        conn.close()

        # if pass the check, redirect to the welcome page and store the username in the session
        session['username'] = username
        return redirect("/welcome") # commit this line after completing TODO # 2
        
    return render_template("login.html")

@app.route("/signup", methods=["GET", "POST"])
def signup():
    if request.method == "POST":
        username = request.form['username']
        password = request.form['password']

        # TODO # 4: Hash the password using SHA-256
        # password = ???
        hashed_password = hash_password(password)

        # Connect to the database
        conn = get_db_connection()
        cursor = conn.cursor()



        # TODO # 3: Add the query to insert a new user into the database
        try:
            cursor.execute("INSERT INTO users (username, password) VALUES (%s, %s)", (username, hashed_password))
            conn.commit()
            flash("Account created successfully! Please log in.", "success")
            return redirect("/")
        except mysql.connector.Error as err:
            flash(f"Error: {err}", "danger")
        finally:
            cursor.close()
            conn.close()
    
    return render_template("signup.html")

@app.route("/logout")
def logout():
    session.pop('username', None)
    return redirect("/")

@app.route('/homepage')
def index():
    return render_template('homepage.html')

if __name__ == '__main__':
    app.run(debug=True)
