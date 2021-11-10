FROM animcogn/face_recognition:gpu

WORKDIR /app/

COPY . .

RUN pip install -r requirements.txt