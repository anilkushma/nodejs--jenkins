apiVersion: apps/v1
kind: Deployment
metadata:
  name: nodejs-app-deployment
spec:
  replicas: 2
  selector:
    matchLabels:
      app: nodejs-app
  template:
    metadata:
      labels:
        app: nodejs-app
    spec:
      containers:
      - name: nodejs-app
        image: ramboo2023/nodejs-app:latest
        ports:
        - containerPort: 3000
        command: ["node"]
        args: ["app.js"]
