# Use a imagem oficial do Node.js como base
FROM node:14

# Defina o diretório de trabalho para /app
WORKDIR /app

# Copie o package.json e package-lock.json para o diretório de trabalho
COPY package*.json ./

# Instale as dependências
RUN npm install

# Copie todos os arquivos para o diretório de trabalho
COPY . .

# Build o aplicativo
RUN npm run build

# Defina a porta exposta
EXPOSE 3000

# Inicie o aplicativo
CMD ["npm", "start"]
