# Clone and run project
```bash
git clone https://github.com/tsadimas/django3-sampe-project.git
python -m venv myvenv
source myvenv/bin/activate
pip install -r requirements.txt
cd myproject
cp myproject/.env.example myproject/.env
```
edit myproject/.env file to define
```vim
SECRET_KEY='test123'
DATABASE_URL=sqlite:///./db.sqlite3
```
# run development server
```bash
python manage.py runserver
```
test webhook