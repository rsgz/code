from flask import Flask,render_template

app=Flask(__name__)

@app.route("/show/info")
def index():
    return render_template("index.html")  # http://127.0.0.1:8888/show/info

@app.route("/get/news")
def get_news():
    return render_template("get_news.html")  # http://127.0.0.1:8888/get/news

@app.route("/get/table1")
def get_table1():
    return render_template("table.html")  # http://127.0.0.1:8888/get/table1

if __name__ == '__main__':
    app.run(host="", port="8888")  # http://127.0.0.1:8888