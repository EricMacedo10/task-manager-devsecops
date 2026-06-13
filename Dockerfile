FROM python:3.9-slim

# Metadados de Autoria (Senior Standard)
LABEL maintainer="Estudo de Caso - DevSecOps"
LABEL description="Task Manager Flask - Container Seguro"

# Criar um usuário não-root (Mitigação de Ameaça: Privilege Escalation)
RUN groupadd -r flaskgroup && useradd -r -g flaskgroup flaskuser

# Definir o diretório de trabalho
WORKDIR /app

# Copiar apenas os requirements primeiro para aproveitar o cache do Docker
COPY requirements.txt .

# Instalar dependências sem cache para reduzir o tamanho da imagem
RUN pip install --no-cache-dir -r requirements.txt

# Copiar o restante do código-fonte
COPY . .

# Mudar a propriedade da pasta para o usuário não-root
RUN chown -R flaskuser:flaskgroup /app

# Trocar para o usuário não-root
USER flaskuser

# Expor a porta que a aplicação Flask utiliza
EXPOSE 5000

# Comando para iniciar a aplicação
CMD ["python", "run.py"]
