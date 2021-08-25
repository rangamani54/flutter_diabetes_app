from keras.models import load_model
from flask import Flask
from flask import render_template
from flask import request, make_response
from flask import jsonify
import traceback
import numpy as np
from flask_cors import CORS

app = Flask("mani_app")
CORS(app)
cors= CORS(app, resource={r"/*":{"origins":"*"}})

model = load_model('diabetes_mlmodel.h5')

model.summary()


@app.route("/result", methods=['POST'])
def lw():
	try:	
		json = request.get_json(force=True)
		temp = list(json[0].values())
		p = model.predict([temp])
		print(round(p[0][0]))
		if round(p[0][0]) == 0:
			result = "Tested negative for diabetes"
			print(result)
		elif round(p[0][0]) == 1:
			result = "Tested positive for diabetes"
			print(result)
		return jsonify({'prediction': result})

	except:
		return jsonify({'trace': traceback.format_exc()})

@app.route("/form")
def lw1():
	form = render_template("form.html")
	return form

 

app.run(host='0.0.0.0', port=1111, debug=True)
