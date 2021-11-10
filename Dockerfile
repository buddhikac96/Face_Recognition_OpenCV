FROM animcogn/face_recognition:gpu

WORKDIR /app/

COPY . .

RUN apt-get update ##[edited]
RUN apt-get install ffmpeg libsm6 libxext6  -y

RUN pip install -r requirements.txt

RUN python extract_embeddings.py --dataset dataset  --embeddings output/embeddings.pickle  --detector face_detection_model  --embedding-model openface_nn4.small2.v1.t7

RUN python train_model.py --embeddings output/embeddings.pickle --recognizer output/recognizer.pickle --le output/le.pickle

RUN python recognize_video.py --detector face_detection_model --embedding-model openface_nn4.small2.v1.t7 --recognizer output/recognizer.pickle --le output/le.pickle

#CMD ["python", "extract_embeddings.py", "--dataset dataset", "--embeddings", "output/embeddings.pickle",  "--detector face_detection_model",  "--embedding-model", "openface_nn4.small2.v1.t7"]

#CMD ["python", "train_model.py", "--embeddings output/embeddings.pickle", "--recognizer", "output/recognizer.pickle", "--le output/le.pickle"]

#CMD ["python", "recognize_video.py", "--detector", "face_detection_model", "--embedding-model", "openface_nn4.small2.v1.t7", "--recognizer", "output/recognizer.pickle", "--le", "output/le.pickle"]