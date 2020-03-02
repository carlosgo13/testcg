# Instrucciones para el despliegue de las aplicaciones

## 1. Pre-requisitos:

- Terraform.
- Git.
- Python3.7.
- Docker.
- AWS CLI.
- Configurar las credenciales de AWS localmente.

## 2. Descargar el repositorio de Git:

Ir a la carpeta de su gusto y correr alguno de los siguientes comandos: 

- git clone git@github.com:carlosgo13/testcg.git
- git clone https://github.com/carlosgo13/testcg.git

## 3. Crear el paquete de la lambda:

- Ir al path lambda.
- Ejecutar: python3 -m venv <virtual-env>. Luego, cambiar al path frontend y ejecutar: source ./bin/activate.
- Correr pip3 install -r requirements.txt.
- Ejecutar cd lib/python3.7/site-packages.
- Ejecutar: deactivate.
- Comprimir el paquete con el comando: zip -r9 ${OLDPWD}/<function-name>.zip.
- Cambiar el path a cd ${OLDPWD}.
- Agregar app.py con el comando: zip -g <function-name>.zip app.py.

## 4. Crear imagen de docker:

- Cambiar al path ./ecs.
- Ejecutar: docker build -t backend .

## 5. Aprovisionar la infraestructura usando terraform:

- Cambiar al path terraform/modules.
- Crear la clave de la instancia de RDS usando: echo  database_password = \"<su-clave>\" > terraform.tfvars.
- Crear un bucket de S3 para almacenar el tfstate. Tome nota del nombre del bucket y actualizarlo en el backend de terraform.
- Ejecutar: terraform init --backend-config=init.txt.
- Correr el plan de terraform usando: terraform plan --var-file=terraform.tfvars.
- Ejecutar: terraform apply --var-file=terraform.tfvars.
- Tomar nota del output **ecr_endpoint** para hacer push de la imagen de docker.

## 6. Crear el schema en RDS:

- Con un cliente de mysql, crear la estructura de la base de datos. Tomar el dato del endpoint de RDS en el output de terraform.

## 7. Hacer push de la imagen de docker:

- Cambiar nuevamente al path ecs.
- Correr: docker tag backend **ecr_endpoint**:0.2.
- Ejecutar **aws ecr get-login** para tomar el link de login a usar.
- Finalmente hacer push: docker push **ecr_endpoint**:0.2.

## 8. Subir el zip a la lambda:

- Cambiar a lambda/frontend.
- Ejecutar: aws lambda update-function-code --function-name **<lambda_name>** --zip-file fileb://<function-name>.zip

# Technical debt list:

- La instancia de ECS no funciona adecuadamente.
- No se pudo aprovisionar la lambda ni el API gateway usando terraform.
- Localmente las apis funcionan adecuadamente. Incluso, el backend funciona en ECS, pero no pude alcanzar a que funcionara la lambda. No pude conseguir hacer las configuraciones pertinentes en Python. Entiendo que faltan algunas dependencias.