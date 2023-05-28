from flask import Flask,render_template,request

app=Flask(__name__)

@app.route("/login", methods=["GET", "POST"])  # 这个限制了 访问网址只能使用get请求
def login():
    if request.method == "GET":
        return render_template("login.html")
    elif request.method == "POST":
        user = request.form.get("user")
        pwd = request.form.get("pwd")
        gender = request.form.get("gender")
        hobby_list = request.form.getlist("hobby")
        city = request.form.get("city")
        skill_list = request.form.getlist("skill")
        more = request.form.get("more")
        return "注册成功!!!" + f"{user},{pwd},{gender},{hobby_list},{city},{skill_list},{more}"

if __name__ == '__main__':
    app.run(host="", port="8888")  # http://127.0.0.1:8888