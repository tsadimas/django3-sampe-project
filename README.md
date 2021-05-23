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
# K8S

## microk8s enable storage
```bash
microk8s enable storage
```

## Persistense Volume
```bash
kubectl apply -f k8s/db/postgres-pvc.yaml
```
## secrets
* pg secret

```bash
kubectl create secret generic pg-user \
--from-literal=PGUSER=<put user name here> \
--from-literal=PGPASSWORD=<put password here>
```

## Deployments
* Postgres
```bash
kubectl apply -f k8s/db/postgres-deployment.yaml
```

## Services
* Postgres
```bash
kubectl apply -f k8s/db/postgres-clip.yaml
```