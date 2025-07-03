# Etapa 1: Escolha de uma imagem base estável e leve
# Usamos uma versão estável do Python (3.11) e a variante 'slim' que é menor que a padrão.
FROM python:3.11-slim

# Etapa 2: Definir o diretório de trabalho dentro do container
# Isso evita que os arquivos da aplicação se espalhem pelo sistema de arquivos do container.
WORKDIR /app

# Etapa 3: Copiar o arquivo de dependências
# Copiamos primeiro para aproveitar o cache de camadas do Docker.
# O Docker só reinstalará as dependências se o requirements.txt mudar.
COPY requirements.txt .

# Etapa 4: Instalar as dependências
# Atualizamos o pip e instalamos os pacotes sem guardar cache para manter a imagem menor.
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Etapa 5: Copiar o código da aplicação para o container
COPY . .

# Etapa 6: Expor a porta que a aplicação usará
EXPOSE 8000

# Etapa 7: Comando para iniciar a aplicação
# Usamos uvicorn para rodar o app FastAPI, escutando em todas as interfaces (0.0.0.0).
CMD ["uvicorn", "app:app", "--host", "0.0.0.0", "--port", "8000"]
