from flask import Flask,render_template,request

app=Flask(__name__)

@app.route("/register", methods=["GET"])  # 这个限制了 访问网址只能使用get请求
def register():
    return render_template("register.html")

@app.route("/do/reg", methods=["GET"])
def do_register():
    print(request.args)
    return "注册成功!!!"

@app.route("/post/reg", methods=["POST"])
def do_post_register():
    print(request.form)
    return "注册成功!!!"

if __name__ == '__main__':
    app.run(host="", port="8888")  # http://127.0.0.1:8888