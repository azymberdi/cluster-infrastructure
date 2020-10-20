from flask import render_template, Flask 
from jinja2 import Template
import yaml
import requests

app = Flask(__name__)


def isItUp(url):
    try:
        response = requests.get(url)
    except Exception as e:
        print(e)
        return False
    if response.status_code == 200 or response.status_code == 403:
        return True
    else:
        return False 

@app.route('/')
def index():
    # data =  requests.get('https://raw.githubusercontent.com/fuchicorp/isitup/master/configurations/domains.yaml').text
    with open('configurations/domains.yaml') as file:
        config = yaml.load(file)
        
    return render_template('index.html', config_data=config)

@app.route('/services/<domain>')
def services(domain):
    with open('services-config.yaml') as file:
        file = file.read().format(domain=domain)
        services = yaml.load(file)
        for service in services['data']:
            if isItUp(service['url']):
                service['status'] = True
            else:
                service['status'] = False
                service['message'] = "The application is down!!" 

    return render_template('services.html', config_data=services)



@app.route('/meeting')
def meeting():
    
    with open('configurations/domains.yaml') as file:
        config = yaml.load(file)
        
    return render_template('meeting.html', config_data=config)
if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)