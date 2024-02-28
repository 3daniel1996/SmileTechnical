from flask import Flask, jsonify, request 

app = Flask(__name__) 


@app.route('/', methods=['GET']) 
def helloworld(): 
	if(request.method == 'GET'): 
		data = {"message": "Hello Smile"} 
		return jsonify(data) 


if __name__ == '__main__': 
	app.run(host='0.0.0.0',debug=True) 
